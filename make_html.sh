rm html/CHAP???.html
rm html/biblio.html
rm html/theindex.html
rm html/chapters.html
perl ../../etc/convert.pl -n CRISP -c -i doc html
(cd html; for file in *.htm; do mv $file $file"l"; done)
chmod -R a+r htm
