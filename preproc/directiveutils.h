#ifndef DIRECTIVEUTILS_H
#define DIRECTIVEUTILS_H

	/**
	 * register a new define name.
	 * calling this function is equal to the following
	 * preprocessing directive: #define <name> <value>
	 * the name will be copied (NOTE: PREPROC_MAX_MACRO_NAME_LENGTH)
	 */
	int directivestage_addDefine(preproc *instance, char *name);

    /**
     * checks if the given line IS a directive statement
     * this means: whitespace followed by #
     * so we got a directive for sure!
     * if it is valid has to be checked...
     * if this pattern is found line->pos is moved (set to #-pos+1) and 1 is returned
     * otherwise line->pos stays untouched and 0 will be returned
     */
    int isDirectiveLine(CharacterLine *line);
    
    /**
     * the following functions are intended to be called AFTER isDirectiveLine()
     * for that line->pos is at the correct position (AFTER the # in the correct case)
     * they check if the directive followed by at least one whitespace exists
     * these functions return 1 if such a pattern is found 0 otherwise
     */
    int isIncludeDirective(CharacterLine *line);
    int isDefineDirective(CharacterLine *line);
    int isIfdefDirective(CharacterLine *line);
    int isIfndefDirective(CharacterLine *line);
    int isElseDirective(CharacterLine *line);
    int isEndifDirective(CharacterLine *line);

#endif
