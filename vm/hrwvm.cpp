#include <iostream>
#include <fstream>

#include "VM.h"

using namespace std;

void printUsage(char *program_name)
{
	cout << program_name << " <hrwcc_binary> [program arguments]" << endl;
}

int main(int argc, char **argv)
{
	char *exe_name;

	//check the CLI parameters
	//we at least expect 2 parameters: program name and executable name
	if ( argc < 2 )
	{
		printUsage(argv[0]);
		exit(1);
	}

	//name of the executable that should be executed
	exe_name = argv[1];

	//open input file
	ifstream input(exe_name);
	if ( !input.good() )
	{
		cout << "Executable [" << exe_name << "] could not be executed" << endl;
		return 1;
	}
	
	//create the VM object and pass the input stream
	VM vm(input);

	//add the other parameters to the VM parameters
	int   offset   = 1; //offset is the number of args THIS binary uses (except vm_argv[0] is the filename)
	int   vm_argc  = argc-offset;
	char **vm_argv = argv+offset;

	//set the program arguments for the vm
	vm.setProgramArguments(vm_argc, vm_argv);

	int state;
	do
	{
		state = vm.executeNextInstruction();
		if ( state != 0 )
		{
			cout << "Received State [" << state << "] aborting..." << endl;
			break;
		}
	}
	while ( !vm.isEof(state) );

	input.close();
}
