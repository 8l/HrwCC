make -C vm
make
make -f Makefile.hrwcc


#Now we can work
clear
echo "Lets rock..."
echo "Compiling features file with ELF-hrwcc:"
cd hrwcc
./hrwcc testdata/features.c
echo "Move outfile to outfile.org"
mv outfile outfile.org

echo ""
echo ""
echo ""
echo "Compiling features file with hrwvm-hrwcc (you may want to drink a coffee):"
../vm/hrwvm hrwcc.exe testdata/features.c
echo "md5sum outfile and outfile.org"
md5sum outfile outfile.org

echo "Press key..."
read enter


echo "Executing outfile"
../vm/hrwvm outfile


