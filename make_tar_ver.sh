#!/bin/bash
tarfile="crisp/crisp-$1.tar"
if [ "$tarfile" = "crisp/crisp-.tar" ]; then
   echo "Version number expected";
   exit;
fi

taropts1="-c -s /crisp/crisp-$1/ -f"
taropts="-r -s /crisp/crisp-$1/ -f"

cd ../
rm -f $tarfile
rm -f $tarfile.bz2
chmod -R a+rX crisp

# this suppresses extended attributes in tarballs
export COPY_EXTENDED_ATTRIBUTES_DISABLE=1
export COPYFILE_DISABLE=1

libfiles="classes.gd classes.gi compl.gd compl.gi \
       fitting.gd fitting.gi form.gd form.gi grpclass.gd grpclass.gi \
       injector.gd injector.gi normpro.gd normpro.gi \
       projector.gd projector.gi radical.gd radical.gi \
       residual.gd residual.gi samples.gd samples.gi \
       schunck.gd schunck.gi socle.gd socle.gi solveeq.gd solveeq.gi \
       util.gd util.gi"

docfiles="manual.tex copyright.tex classes.tex examples.tex fitting.tex \
       grpclass.tex intro.tex normal.tex schunck.tex"
    
manexts=".bbl .ind .idx .six .pdf .ist .toc \
       .example-2.tst .example-3.tst .example-4.tst .example-5.tst .example-7.tst"

testfiles="test.tst all.g basis.g boundary.g char.g classes.g \
       in.g injectors.g normals.g print.g projectors.g radicals.g \
       Readme-Tests.txt residuals.g samples.g socle.g \
       timing_injectors.g timing_normals.g timing_normpro.g \
       timing_projectors.g timing_radicals.g timing_residuals.g \
       timing_samples.g timing_socle.g timing_test.g"

# extension: automatic version numbers:
# sed -e s/@VERSION@/.../ -e s/@DATE@/.../ -e s/@ARCHIVE@/.../ crisp/PackageInfo.g | tar -c -f $tarfile 


tar $taropts1 $tarfile crisp/PackageInfo.g
tar $taropts $tarfile crisp/init.g
tar $taropts $tarfile crisp/read.g

for file in $libfiles
   do tar $taropts $tarfile crisp/lib/$file
done

for file in $docfiles
   do tar $taropts $tarfile crisp/doc/$file
done

for ext in $manexts
   do tar $taropts $tarfile crisp/doc/manual$ext
done

for file in $testfiles
   do tar $taropts $tarfile crisp/tst/$file
done

for file in crisp/html/*.htm
   do tar $taropts $tarfile $file
done

tar $taropts $tarfile crisp/README
tar $taropts $tarfile crisp/LICENSE


bzip2 $tarfile




