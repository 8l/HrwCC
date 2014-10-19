#Remove old hrwcc binaries
rm -f hrwcc/hrwcc-*

echo "*** Compile hrwcc with gcc ***"
make clean
make
cp hrwcc/hrwcc hrwcc/hrwcc-1

echo "*** Compile hrwcc with hrwcc(1) ***"
make -f Makefile.hrwcc clean
make -f Makefile.hrwcc
cp hrwcc/hrwcc hrwcc/hrwcc-2

echo "*** Compile hrwcc with hrwcc(2) ***"
make -f Makefile.hrwcc clean
make -f Makefile.hrwcc
cp hrwcc/hrwcc hrwcc/hrwcc-3


echo "*** Calculating MD5-sum of executeables ***"
md5sum hrwcc/hrwcc-*


