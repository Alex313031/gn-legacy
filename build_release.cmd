gn.bat gen .\out\Release && ninja.bat -C .\out\Release -t clean && ninja.bat -C .\out\Release all -d stats -j 8
