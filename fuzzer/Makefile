#The one and only
PROGRAMS = fuzzer
PROGARGS = 

#The parent directory
DIRECTORY = fuzzer

#The source files
CPPSRC = fuzzer.cpp
CPPOBJ = $(CPPSRC:%.cpp=%.o)


#My custom cflags, one for release, one for debug and one for all
CXXFLAGS = $(CXXFLAGSDEBUG) -ansi
CXXFLAGSRELEASE = -O3 -DNDEBUG
CXXFLAGSDEBUG = -Wall -g
CXX = g++

#File of dependency
DEPENDFILE = .depend


#Make executeable
all: $(PROGRAMS)

#Build executeable if obj have been modified
$(PROGRAMS): $(CPPOBJ)
	$(CXX) $(CXXFLAGS) $(CPPOBJ) -o $(PROGRAMS)


#I love ctags and vim
.PHONY: tags
tags:
	exuberant-ctags --recurse *

#Make dependencies of source
dep: 
	$(CXX) $(CXXFLAGS) -MM $(CPPSRC) > $(DEPENDFILE)

#Include the dependency file
-include $(DEPENDFILE)

#Run the little proggy
run: all
	./$(PROGRAMS) $(PROGARGS)

#Pack all in a tar.bz2
dist: clean
	tar -cvjf ../$(DIRECTORY).tar.bz2 --exclude '*/.*' ../$(DIRECTORY)

#Get rid of all files which are build by make
clean:
	rm -f *.o
	rm -f $(PROGRAMS)





