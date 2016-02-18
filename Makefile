SHELL=/bin/bash
VERSION=1.dev
DATE=$(shell echo `date "+%d/%m/%Y"`)
GAPROOT=../..

libfiles=classes.gd classes.gi compl.gd compl.gi \
	   fitting.gd fitting.gi form.gd form.gi grpclass.gd grpclass.gi \
	   injector.gd injector.gi normpro.gd normpro.gi \
	   projector.gd projector.gi radical.gd radical.gi \
	   residual.gd residual.gi samples.gd samples.gi \
	   schunck.gd schunck.gi socle.gd socle.gi solveeq.gd solveeq.gi \
	   util.gd util.gi
docfiles=manual.tex copyright.tex classes.tex examples.tex fitting.tex \
	   grpclass.tex intro.tex normal.tex schunck.tex
	
manexts=.bbl .ind .idx .six .pdf .ist .toc \
	   .example-2.tst .example-3.tst .example-4.tst .example-5.tst .example-7.tst

testfiles=test.tst all.g basis.g boundary.g char.g classes.g \
	   in.g injectors.g normals.g print.g projectors.g radicals.g \
	   Readme-Tests.txt residuals.g samples.g socle.g \
	   timing_injectors.g timing_normals.g timing_normpro.g \
	   timing_projectors.g timing_radicals.g timing_residuals.g \
	   timing_samples.g timing_socle.g timing_test.g

tarfile=crisp/crisp-$(VERSION).tar

taropts=-s /crisp/crisp-$(VERSION)/ -f

default: versions manual

release: versions manual tar

versions:
	( \
        for file in README index.html PackageInfo.g doc/manual.tex; \
            do sed -e "s/CRISP_VERSION/$(VERSION)/g" -e "s-CRISP_DATE-$(DATE)-" $$file.in > $$file; \
        done \
	)

manual.pdf:
	( \
			cd doc; \
			pdftex manual; \
			makeindex -s manual.ist manual; \
			pdftex manual; \
			pdftex manual \
	)

manual.html:
	( \
			rm -f htm/*.htm; \
			mkdir -p htm; \
			perl $(GAPROOT)/etc/convert.pl -n CRISP -c -i doc htm; \
			chmod -R a+r htm \
	)

manual: manual.pdf manual.html

tar:
	( \
		if [ "$(tarfile)" = "crisp/crisp-.tar" ]; then\
		   echo "Version number expected"; \
		   exit; \
		fi; \
		export COPY_EXTENDED_ATTRIBUTES_DISABLE=1; \
		export COPYFILE_DISABLE=1; \
		cd ../; \
		rm -f $(tarfile); \
		rm -f $(tarfile).bz2; \
		chmod -R a+rX irredsol; \
		tar -c $(taropts) $(tarfile) crisp/PackageInfo.g; \
		tar -r $(taropts) $(tarfile) crisp/init.g; \
		tar -r $(taropts) $(tarfile) crisp/read.g; \
		for file in $(libfiles); \
		   do tar -r $(taropts) $(tarfile) crisp/lib/$$file; \
		done; \
		for file in $(docfiles); \
		   do tar -r $(taropts) $(tarfile) crisp/doc/$$file; \
		done; \
		for ext in $(manexts); \
		   do tar -r $(taropts) $(tarfile) crisp/doc/manual$$ext; \
		done; \
		for file in $(testfiles); \
		   do tar -r $(taropts) $(tarfile) crisp/tst/$$file; \
		done; \
		for file in crisp/htm/*.htm; \
		   do tar -r $(taropts) $(tarfile) $$file; \
		done; \
		tar -r $(taropts) $(tarfile) crisp/README; \
		tar -r $(taropts) $(tarfile) crisp/LICENSE; \
		bzip2 $(tarfile) \
	)

