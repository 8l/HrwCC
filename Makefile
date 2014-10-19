
#The parent directory
DIRECTORY = HrwCC


#Make executeable
all:
	make -C preproc 
	make -C scanner 
	make -C parser 
	make -C symbolTable 
	make -C codegen 
	make -C hrwcc 
	make -C linker 

#I love ctags and vim
.PHONY: tags
tags:
	exuberant-ctags --recurse *

#Pack all in a tar.bz2
dist: clean
	tar -cvjf ../$(DIRECTORY).tar.bz2 --exclude '*/.*' ../$(DIRECTORY)

#Get rid of all files which are build by make
clean:
	make -C preproc clean
	make -C scanner clean
	make -C parser clean
	make -C symbolTable clean
	make -C codegen clean
	make -C hrwcc clean
	make -C linker clean





