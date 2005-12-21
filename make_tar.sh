#!/bin/csh
set tarfile = crisp/crisp-$1.tar
if ($tarfile == crisp/crisp-.tar) then
   echo "Version number expected";
   exit;
endif

cd ../
rm -f $tarfile
rm -f $tarfile.bz2
chmod -R a+rX crisp

set libfiles = (classes.gd classes.gi compl.gd compl.gi \
       fitting.gd fitting.gi form.gd form.gi grpclass.gd grpclass.gi \
       injector.gd injector.gi normpro.gd normpro.gi \
       projector.gd projector.gi radical.gd radical.gi \
       residual.gd residual.gi samples.gd samples.gi \
       schunck.gd schunck.gi socle.gd socle.gi solveeq.gd solveeq.gi \
       util.gd util.gi pcgscache.gd pcgscache.gi )

set docfiles = (manual.tex classes.tex examples.tex fitting.tex \
       grpclass.tex intro.tex)
    
set manfiles = (.bbl .ind .idx .six .dvi .pdf .tst .mst)

set testfiles = (test.tst all.g basis.g boundary.g char.g classes.g \
       in.g injectors.g normals.g print.g projectors.g radicals.g \
       Readme-Tests.txt residuals.g samples.g socle.g \
       timing_injectors.g timing_normals.g timing_normpro.g \
       timing_projectors.g timing_radicals.g timing_residuals.g \
       timing_samples.g timing_socle.g timing_test.g)

tar -c -f $tarfile crisp/PackageInfo.g 
tar -r -f $tarfile crisp/init.g 
tar -r -f $tarfile crisp/read.g 

foreach file ($libfiles)
   tar -r -f $tarfile crisp/lib/$file 
end

foreach file ($docfiles)
   tar -r -f $tarfile crisp/doc/$file 
end

foreach file ($manfiles)
   tar -r -f $tarfile crisp/doc/manual$file 
end

foreach file ($testfiles)
   tar -r -f $tarfile crisp/tst/$file 
end

foreach file (crisp/htm/*)
	tar -r -f $tarfile $file 
end

tar -r -f $tarfile crisp/README 

bzip2  $tarfile 



