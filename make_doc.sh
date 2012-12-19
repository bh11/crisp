#! /bin/sh
cd doc
pdftex manual
makeindex -s manual.ist manual
pdftex manual
pdftex manual
cd ..

 

