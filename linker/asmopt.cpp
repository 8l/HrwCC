#include "../include/hrwcccomp.h"
#include "asmopt.h"
#include "utils.h"

#define OPT_CODE_BUFFER_SIZE 4  //size of the code buffer (code lines) we are analyzing
#define OPT_MAX_LINE_LENGTH 512 //max line length we support

struct AsmOptimizer
{
	TokensList code_buffer[OPT_CODE_BUFFER_SIZE]; //list of code lines we are currently analyzing
	int curr_buffer_size; //current buffer size
	int eof_reached;         //flag to indicate that EOF was reached
	
	int infile_fd;           //input file descriptor
	int outfile_fd;          //output file descriptor
	
	int stack_seq_opts;      //number of optimized push/pop sequences
	int jmp_opts;            //number of jmp optimization
};

//for debugging purposes only
void printCodeBuffer(AsmOptimizer *instance)
{
	int idx;
	
	idx = 0;
	while ( idx < OPT_CODE_BUFFER_SIZE )
	{
		printTokensList(&instance->code_buffer[idx]);
		puts("---");
		idx = idx+1;
	}
	puts("=================");
}

/**
 * init the optimizer instance
 */
int asmopt_initInstance(AsmOptimizer *instance)
{
	int idx;

	instance->eof_reached      = 0;
	instance->curr_buffer_size = 0;
	instance->stack_seq_opts   = 0;
	instance->jmp_opts         = 0;
	
	idx = 0;
	while ( idx < OPT_CODE_BUFFER_SIZE )
	{
		Clear_TokensList(&instance->code_buffer[idx]);
		idx = idx+1;
	}

	return 0;
}

void asmopt_freeCodeBufferSlot(AsmOptimizer *instance, int idx)
{
	freeTokensList(&instance->code_buffer[idx]);
	Clear_TokensList(&instance->code_buffer[idx]);
}

/**
 * free all allocated resources
 */
int asmopt_freeInstance(AsmOptimizer *instance)
{
	int idx;

	idx = 0;
	while ( idx < OPT_CODE_BUFFER_SIZE )
	{
		asmopt_freeCodeBufferSlot(instance, idx);
		idx = idx+1;
	}
	
	instance->curr_buffer_size = -1;

	return 0;
}

/**
 * pop the 'idx' element in the code_buffer
 * (moves all following elements one position up)
 */
void asmopt_popCodeBuffer(AsmOptimizer *instance, int idx)
{
	//free/clear the slot we have to remove
	asmopt_freeCodeBufferSlot(instance, idx);

	idx = idx+1;
	while ( idx < OPT_CODE_BUFFER_SIZE )
	{
		memcpy(&instance->code_buffer[idx-1], &instance->code_buffer[idx], sizeof(TokensList));
		Clear_TokensList(&instance->code_buffer[idx]);

		idx = idx+1;
	}

	instance->curr_buffer_size = instance->curr_buffer_size-1;
}

/**
 * fill up the buffer (until code buffer size = OPT_CODE_BUFFER_SIZE) or EOF
 * if EOF is reached this function will return 1 till the code buffer is empty
 */
int asmopt_codeBufferFetch(AsmOptimizer *instance)
{
	int ret;
	int idx;
	char tmp_chr;
	char line_buffer[OPT_MAX_LINE_LENGTH];

	//if we are at the end of the file we are done
	if ( instance->eof_reached == 1 )
	{
		//until there are still lines in the code buffer we return 1
		if ( instance->curr_buffer_size > 0 )
			return 1;

		return 0;
	}

	//for every line in our code buffer
	while ( instance->curr_buffer_size<OPT_CODE_BUFFER_SIZE && instance->eof_reached==0 )
	{
		//fetch a line
		memset(line_buffer, 0, OPT_MAX_LINE_LENGTH);

		idx = 0;
		while ( idx < OPT_MAX_LINE_LENGTH )
		{
			ret = read(instance->infile_fd, &tmp_chr, sizeof(char));

			//see if we got EOF
			if ( ret==0 )
			{
				instance->eof_reached = 1;
				break;
			}

			//if we got a end of str we are done
			if ( tmp_chr=='\n' )
				break;

			line_buffer[idx] = tmp_chr;
			idx              = idx+1;
		}

		if ( idx==OPT_MAX_LINE_LENGTH && line_buffer[idx]!='\n' )
		{
			puts("AsmOpt: Source line too long");
			return -1;
		}

		//tokenize the fetched line (if we at least got one char)
		if ( idx > 0 )
		{
			tokenizeString(&instance->code_buffer[instance->curr_buffer_size], line_buffer);
			instance->curr_buffer_size = instance->curr_buffer_size+1;
		}
	}

	return 1;
}

/**
 * we only apply this rule if one of two lines starts with a "$" or a "%"
 */
int isValidStackOptType(Token *curr_type_tok, Token *next_type_tok)
{
	return (
		strcmp(curr_type_tok->value, "%")==0 || strcmp(curr_type_tok->value, "$")==0 ||
		strcmp(next_type_tok->value, "%")==0 || strcmp(next_type_tok->value, "$")==0
	);
}

/**
 * append the token and all following tokens from
 * the Token list to buffer
 */
void appendTokens(Token *token, char *buffer)
{
	while ( token != NULL )
	{
		strcat(buffer, token->value);
		token = Get_Next_In_TokensList(token);
	}
}

int asmopt_analyzePushPopSequences(AsmOptimizer *instance)
{
	int buf_idx;
	int curr_size;
	int next_size;
	int first_is_valid;
	int second_is_valid;
	char line_val[MAX_LINE_LENGTH];
	Token *curr_tok;
	Token *next_tok;
	Token *curr_type_tok;
	Token *next_type_tok;

	/**
	 * we start at top of the buffer and try to optimize
	 * here we optimize: 
	 *  pushl %some_reg
	 *  popl %other_reg
	 * ==> becomes: movl %some_reg, %other_reg
	 * if 'some_reg' and 'other_reg' is the same register
	 * the code will completely be omitted
	 */
	buf_idx = 0;
	while ( buf_idx < OPT_CODE_BUFFER_SIZE-1 )
	{
		//see if first line starts with a push
		first_is_valid = 0;
		curr_tok  = Get_Front_Of_TokensList(&instance->code_buffer[buf_idx]);
		curr_size = getTokensListSize(&instance->code_buffer[buf_idx]);

		if ( curr_tok!=NULL && strcmp(curr_tok->value, "pushl")==0 && curr_size>=3 )
			first_is_valid = 1;

		//see if the next line starts with a popl
		second_is_valid = 0;
		next_tok  = Get_Front_Of_TokensList(&instance->code_buffer[buf_idx+1]);
		next_size = getTokensListSize(&instance->code_buffer[buf_idx+1]);

		if ( next_tok!=NULL && strcmp(next_tok->value, "popl")==0 && next_size>=3 )
			second_is_valid = 1;

		if ( first_is_valid && second_is_valid )
		{
			//get registers or dollar sign
			curr_type_tok = Get_Next_In_TokensList(curr_tok);
			next_type_tok = Get_Next_In_TokensList(next_tok);
	
			//get register name or direct value
			curr_tok = Get_Next_In_TokensList(curr_type_tok);
			next_tok = Get_Next_In_TokensList(next_type_tok);

			//finally: apply rule
			if ( isValidStackOptType(curr_type_tok, next_type_tok) )
			{
				//for statistical purpose - count number of optimizations
				instance->stack_seq_opts = instance->stack_seq_opts+1;
	
				if ( strcmp(curr_tok->value, next_tok->value) == 0 )
				{
					//we can remove the two lines
					asmopt_popCodeBuffer(instance, buf_idx);
					asmopt_popCodeBuffer(instance, buf_idx);
	
					//now we have to fetch new lines and go on with the analysis from the current position
					asmopt_codeBufferFetch(instance);
					continue;
				}
				else
				{
					//we generate: movl <curr_tokens>, <next_tokens>
	
					//build the resulting string
					memset(line_val, 0, MAX_LINE_LENGTH);
					strcpy(line_val, "\tmovl\t");
					appendTokens(curr_type_tok, line_val);
					strcat(line_val, ", ");
					appendTokens(next_type_tok, line_val);
	
					//remove the first line of these two
					asmopt_popCodeBuffer(instance, buf_idx);
					//and free the second one
					asmopt_freeCodeBufferSlot(instance, buf_idx);
	
					//tokenize the result and store it in our code buffer
					tokenizeString(&instance->code_buffer[buf_idx], line_val);
	
					//now we have to fetch a new line and go on with the analysis
					asmopt_codeBufferFetch(instance);
				}
			}
		}

		//increment buffer index to analyze the next code lines
		buf_idx = buf_idx+1;
	}

	/**
NOTE: THIS RULE IS DISABLED
	 * here we optimize: 
	 *  popl %reg_a
	 *  pushl %reg_b
	 * ==> becomes: movl (%esp), %reg_a
	 * iff 'reg_a' and 'reg_b' are the same
	 *  /
	buf_idx = 0;
	while ( buf_idx < OPT_CODE_BUFFER_SIZE-1 )
	{
		curr_tok  = Get_Front_Of_TokensList(&instance->code_buffer[buf_idx]);
		curr_size = getTokensListSize(&instance->code_buffer[buf_idx]);

		if ( curr_tok!=NULL && strcmp(curr_tok->value, "popl")==0 && curr_size>=3 )
		{
			//see if the next line starts with a popl
			next_tok  = Get_Front_Of_TokensList(&instance->code_buffer[buf_idx+1]);
			next_size = getTokensListSize(&instance->code_buffer[buf_idx+1]);

			if ( next_tok!=NULL && strcmp(next_tok->value, "pushl")==0 && next_size>=3 )
			{
				//get registers or dollar sign
				curr_type_tok = Get_Next_In_TokensList(curr_tok);
				next_type_tok = Get_Next_In_TokensList(next_tok);
		
				//get register name or direct value
				curr_tok = Get_Next_In_TokensList(curr_type_tok);
				next_tok = Get_Next_In_TokensList(next_type_tok);

				if ( strcmp(curr_tok->value, next_tok->value) == 0 )
				{
					//build the resulting string
					memset(line_val, 0, MAX_LINE_LENGTH);
					strcpy(line_val, "\tmovl\t(%esp), %");
					appendTokens(next_tok, line_val);

					//remove the first line of these two
					asmopt_popCodeBuffer(instance, buf_idx);
					//and free the second one
					asmopt_freeCodeBufferSlot(instance, buf_idx);

					//tokenize the result and store it in our code buffer
					tokenizeString(&instance->code_buffer[buf_idx], line_val);

					//now we have to fetch a new line and go on with the analysis
					asmopt_codeBufferFetch(instance);
					continue;
				}
			}
		}

		buf_idx = buf_idx+1;
	}
*/
	return 0;
}

int asmopt_analyzeJumps(AsmOptimizer *instance)
{
	int buf_idx;
	int curr_jmp_tok_size;
	int next_jmp_tok_size;
	Token *curr_jmp_tok;
	Token *next_jmp_tok;
	Token *colon_lookahead;

	/**
	 * here we optimize: 
	 *  j* somewhere
	 *  j* somewhere else
	 * the second j* will be removed
	 * NOTE: we have to make sure that we did not get a marker (j*:)
	 */
	buf_idx = 0;
	while ( buf_idx < OPT_CODE_BUFFER_SIZE-1 )
	{
		curr_jmp_tok      = Get_Front_Of_TokensList(&instance->code_buffer[buf_idx]);
		curr_jmp_tok_size = getTokensListSize(&instance->code_buffer[buf_idx]);
//TODO: get rid of this deep nesting ;(
		if ( curr_jmp_tok!=NULL && strcmp(curr_jmp_tok->value, "jmp")==0 && curr_jmp_tok_size==2 )
		{
			//make sure we did not get a marker (can be decided by finding a colon)
			colon_lookahead = Get_Next_In_TokensList(curr_jmp_tok);
			//we don't have to care about being NULL since curr_jmp_tok_size is 2!
			if ( strcmp(colon_lookahead->value, ":") != 0 )
			{
				//see if the next line starts with a j* too
				next_jmp_tok      = Get_Front_Of_TokensList(&instance->code_buffer[buf_idx+1]);
				next_jmp_tok_size = getTokensListSize(&instance->code_buffer[buf_idx+1]);
	
				if ( next_jmp_tok!=NULL && strncmp(next_jmp_tok->value, "j", 1)==0 && next_jmp_tok_size==2 )
				{
					colon_lookahead = Get_Next_In_TokensList(next_jmp_tok);
					if ( strcmp(colon_lookahead->value, ":") != 0 )
					{
						//for statistical purposes
						instance->jmp_opts = instance->jmp_opts+1;
		
						//remove the second line of these two jumps
						asmopt_popCodeBuffer(instance, buf_idx+1);
	
						//now we have to fetch a new line and go on with the analysis
						asmopt_codeBufferFetch(instance);
					}
				}
			}
		}

		buf_idx = buf_idx+1;
	}

	return 0;
}

int asmopt_execute(int infile_fd, int outfile_fd)
{
	AsmOptimizer inst;
	Token *curr_token;
	Token *next_token;
	int ret;
	int is_first;
	int is_marker;
	int is_dot_kwd;

	//init the asmpat instance
	ret = asmopt_initInstance(&inst);
	if ( ret != 0 )
	{
		asmopt_freeInstance(&inst);
		return ret;
	}

	//assign file descriptors
	inst.infile_fd    = infile_fd;
	inst.outfile_fd   = outfile_fd;

	//fill the "code buffer" and analyze it for patterns
	while ( asmopt_codeBufferFetch(&inst) )
	{
		//apply the pattern recognition functions
		ret = asmopt_analyzePushPopSequences(&inst);
		if ( ret != 0 )
		{
			asmopt_freeInstance(&inst);
			return ret;
		}

		ret = asmopt_analyzeJumps(&inst);
		if ( ret != 0 )
		{
			asmopt_freeInstance(&inst);
			return ret;
		}

		//write first line of the code buffer to the outfile
		curr_token = Get_Front_Of_TokensList(&inst.code_buffer[0]);
		is_first   = 1;
		while ( curr_token != NULL )
		{
			/**
			 * we have to create a sense-making formatting
			 * of the generated code
			 * somemarker: [no space between colon and "somemarker"]
			 */

			//we need a lookahead token to determine if we got a marker
			next_token = Get_Next_In_TokensList(curr_token);
			
			is_marker = 0;
			if ( next_token!=NULL && strcmp(next_token->value, ":")==0 )
				is_marker = 1;
			
			//we asume a "dot keyword" if we find a token beginning with a dot
			//and being longer than 5 chars (shortest, we use, is .globl)
			is_dot_kwd = 0;
			if ( strncmp(curr_token->value, ".", 1)==0 && strlen(curr_token->value)>=5 )
				is_dot_kwd = 1;

			//if we didn't get a marker or a token starting with a dot: don't insert a leading tab!
			if ( is_first && !is_marker && !is_dot_kwd )
				write(inst.outfile_fd, "\t", 1);

			write(inst.outfile_fd, curr_token->value, strlen(curr_token->value));

			if ( is_first && !is_marker )
			{
				write(inst.outfile_fd, "\t", 1);
				is_first = 0;
			}
			
			//move to next element
			curr_token = next_token;
		}

		write(inst.outfile_fd, "\n", 1);

		//remove the first line (just written to file)
		asmopt_popCodeBuffer(&inst, 0);
	}

	asmopt_freeInstance(&inst);
	
	printf("ASM Optimizer: Push/Pop Sequences: %d\n", inst.stack_seq_opts);
	printf("               JMP Sequences:      %d\n", inst.jmp_opts);

	return 0;
}
