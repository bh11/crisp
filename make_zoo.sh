#! /bin/sh
if [ "x$1" = "x" ];  then
echo "Please supply a version number"
else
cd ../
chmod -R a+rX crisp
rm crisp.zoo
zoo ach crisp crisp/init.g <crisp/text_comment
zoo ach crisp crisp/read.g <crisp/text_comment
zoo ach crisp crisp/PackageInfo.g <crisp/text_comment
zoo ach crisp crisp/doc/classes.tex <crisp/text_comment
zoo ach crisp crisp/doc/examples.tex <crisp/text_comment
zoo ach crisp crisp/doc/fitting.tex <crisp/text_comment
zoo ach crisp crisp/doc/grpclass.tex <crisp/text_comment
zoo ach crisp crisp/doc/intro.tex <crisp/text_comment
zoo ach crisp crisp/doc/manual.bbl <crisp/text_comment
zoo ah crisp crisp/doc/manual.dvi
zoo ah crisp crisp/doc/manual.pdf
zoo ach crisp crisp/doc/manual.idx <crisp/text_comment
zoo ach crisp crisp/doc/manual.ind <crisp/text_comment
zoo ach crisp crisp/doc/manual.six <crisp/text_comment
zoo ach crisp crisp/doc/manual.tex <crisp/text_comment
zoo ach crisp crisp/doc/manual.tst <crisp/text_comment
zoo ach crisp crisp/doc/schunck.tex <crisp/text_comment
zoo ach crisp crisp/lib/banner.g <crisp/text_comment
zoo ach crisp crisp/lib/classes.gd <crisp/text_comment
zoo ach crisp crisp/lib/classes.gi <crisp/text_comment
zoo ach crisp crisp/lib/compl.gd <crisp/text_comment
zoo ach crisp crisp/lib/compl.gi <crisp/text_comment
zoo ach crisp crisp/lib/fitting.gd <crisp/text_comment
zoo ach crisp crisp/lib/fitting.gi <crisp/text_comment
zoo ach crisp crisp/lib/form.gd <crisp/text_comment
zoo ach crisp crisp/lib/form.gi <crisp/text_comment
zoo ach crisp crisp/lib/grpclass.gd <crisp/text_comment
zoo ach crisp crisp/lib/grpclass.gi <crisp/text_comment
zoo ach crisp crisp/lib/injector.gd <crisp/text_comment
zoo ach crisp crisp/lib/injector.gi <crisp/text_comment
zoo ach crisp crisp/lib/normpro.gd <crisp/text_comment
zoo ach crisp crisp/lib/normpro.gi <crisp/text_comment
zoo ach crisp crisp/lib/projector.gd <crisp/text_comment
zoo ach crisp crisp/lib/projector.gi <crisp/text_comment
zoo ach crisp crisp/lib/radical.gd <crisp/text_comment
zoo ach crisp crisp/lib/radical.gi <crisp/text_comment
zoo ach crisp crisp/lib/residual.gd <crisp/text_comment
zoo ach crisp crisp/lib/residual.gi <crisp/text_comment
zoo ach crisp crisp/lib/samples.gd <crisp/text_comment
zoo ach crisp crisp/lib/samples.gi <crisp/text_comment
zoo ach crisp crisp/lib/schunck.gd <crisp/text_comment
zoo ach crisp crisp/lib/schunck.gi <crisp/text_comment
zoo ach crisp crisp/lib/socle.gd <crisp/text_comment
zoo ach crisp crisp/lib/socle.gi <crisp/text_comment
zoo ach crisp crisp/lib/solveeq.gd <crisp/text_comment
zoo ach crisp crisp/lib/solveeq.gi <crisp/text_comment
zoo ach crisp crisp/lib/util.gd <crisp/text_comment
zoo ach crisp crisp/lib/util.gi <crisp/text_comment
zoo ach crisp crisp/tst/all.g <crisp/text_comment
zoo ach crisp crisp/tst/basis.g <crisp/text_comment
zoo ach crisp crisp/tst/boundary.g <crisp/text_comment
zoo ach crisp crisp/tst/char.g <crisp/text_comment
zoo ach crisp crisp/tst/classes.g <crisp/text_comment
zoo ach crisp crisp/tst/in.g <crisp/text_comment
zoo ach crisp crisp/tst/injectors.g <crisp/text_comment
zoo ach crisp crisp/tst/normals.g <crisp/text_comment
zoo ach crisp crisp/tst/print.g <crisp/text_comment
zoo ach crisp crisp/tst/projectors.g <crisp/text_comment
zoo ach crisp crisp/tst/radicals.g <crisp/text_comment
zoo ach crisp crisp/tst/Readme-Tests.txt <crisp/text_comment
zoo ach crisp crisp/tst/residuals.g <crisp/text_comment
zoo ach crisp crisp/tst/samples.g <crisp/text_comment
zoo ach crisp crisp/tst/socle.g <crisp/text_comment
zoo ach crisp crisp/tst/timing_injectors.g <crisp/text_comment
zoo ach crisp crisp/tst/timing_normals.g <crisp/text_comment
zoo ach crisp crisp/tst/timing_normpro.g <crisp/text_comment
zoo ach crisp crisp/tst/timing_projectors.g <crisp/text_comment
zoo ach crisp crisp/tst/timing_radicals.g <crisp/text_comment
zoo ach crisp crisp/tst/timing_residuals.g <crisp/text_comment
zoo ach crisp crisp/tst/timing_samples.g <crisp/text_comment
zoo ach crisp crisp/tst/timing_socle.g <crisp/text_comment
zoo ach crisp crisp/tst/timing_test.g <crisp/text_comment
zoo ach crisp crisp/htm/biblio.htm <crisp/text_comment
zoo ach crisp crisp/htm/CHAP001.htm <crisp/text_comment
zoo ach crisp crisp/htm/CHAP002.htm <crisp/text_comment
zoo ach crisp crisp/htm/CHAP003.htm <crisp/text_comment
zoo ach crisp crisp/htm/CHAP004.htm <crisp/text_comment
zoo ach crisp crisp/htm/CHAP005.htm <crisp/text_comment
zoo ach crisp crisp/htm/CHAP006.htm <crisp/text_comment
zoo ach crisp crisp/htm/chapters.htm <crisp/text_comment
zoo ach crisp crisp/htm/theindex.htm <crisp/text_comment
zoo ach crisp crisp/htm/index.htm <crisp/text_comment
zoo ah crisp crisp/htm/logo.gif
zoo ach crisp crisp/README <crisp/text_comment
mv crisp.zoo crisp/crisp-$1.zoo
fi






