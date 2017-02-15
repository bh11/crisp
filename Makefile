SHELL=/bin/bash
VERSION=1.5.dev
DATE=$(shell echo `date "+%d/%m/%Y"`)
GAPROOT=../..
TESTOPTS=-b -m 100m -o 1g -A -q -x 80


ifeq ("$(shell tmp=$(GAPROOT); echo $${tmp:0:1})", "/")
	TEXROOT="$(GAPROOT)"
else 
	TEXROOT="../$(GAPROOT)"
endif 

libfiles=classes.gd classes.gi compl.gd compl.gi \
	   fitting.gd fitting.gi form.gd form.gi grpclass.gd grpclass.gi \
	   injector.gd injector.gi normpro.gd normpro.gi \
	   projector.gd projector.gi radical.gd radical.gi \
	   residual.gd residual.gi samples.gd samples.gi \
	   schunck.gd schunck.gi socle.gd socle.gi solveeq.gd solveeq.gi \
	   util.gd util.gi

docfiles=manual.tex copyright.tex classes.tex examples.tex fitting.tex \
	   grpclass.tex intro.tex normal.tex schunck.tex versions.tex
	
manexts=.bbl .ind .idx .six .pdf .mst .toc \
	   .example-2.tst .example-3.tst .example-4.tst .example-5.tst .example-7.tst

testsrc=basis boundary char classes in injectors normals print \
	projectors radicals residuals socle 

testfiles= Readme-Tests.txt testall.g samples.g \
	timing_injectors.g timing_normals.g timing_normpro.g timing_projectors.g \
	timing_radicals.g timing_residuals.g timing_samples.g timing_socle.g \
	timing_test.g
	# plus all files tst/*.tst

update_files =README.in index.in.html PackageInfo.in.g doc/manual.in.tex


tarfile=crisp/crisp-$(VERSION).tar

taropts=-s /crisp/crisp-$(VERSION)/ -f

default: update_in manual

dist: testver update_in manual tar

testver:
	if [ "$(tarfile)" == "crisp/crisp-dev.tar" ]; \
		then echo "Please define VERSION in make call"; \
        exit 1; \
	fi

update_in: 
	for file in $(update_files); \
	do \
		outfile=$${file%.in*}$${file#*.in}; \
		rm -f $$outfile; \
		sed -e "s/CRISP_VERSION/$(VERSION)/g" \
			-e "s-CRISP_DATE-$(DATE)-" \
			-e "s-GAPROOT-$(TEXROOT)-" \
			$$file \
			> $$outfile; \
		chmod a-w $$outfile; \
        done 

manual.pdf: update_in
	cd doc; \
	pdftex manual; \
	makeindex -s manual.mst manual; \
	pdftex manual; \
	pdftex manual 

manual.html:
	mkdir -p htm; \
	rm -f htm/CHAP00?.htm; \
	perl $(GAPROOT)/etc/convert.pl -n CRISP -c -i -t doc htm; \
	chmod -R a+r htm

manual: manual.pdf manual.html

tar: update_in
	export COPY_EXTENDED_ATTRIBUTES_DISABLE=1; \
	export COPYFILE_DISABLE=1; \
	cd ../; \
	rm -f $(tarfile); \
	rm -f $(tarfile).bz2; \
	chmod -R a+rX irredsol; \
	for file in $(update_files); \
	do \
		outfile=$${file%.in*}$${file#*.in}; \
		chmod +w crisp/$$outfile; \
	done; \
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
	for file in crisp/tst/*.tst; \
		do tar -r $(taropts) $(tarfile) $$file; \
	done; \
	for file in crisp/htm/*.htm; \
		do tar -r $(taropts) $(tarfile) $$file; \
	done; \
	tar -r $(taropts) $(tarfile) crisp/README; \
	tar -r $(taropts) $(tarfile) crisp/LICENSE; \
	bzip2 $(tarfile); \
	for file in $(update_files); \
	do \
		outfile=$${file%.in*}$${file#*.in}; \
		chmod -w crisp/$$outfile; \
	done; 

testfiles:   
	for file in $(testsrc); \
	do \
		gap $(TESTOPTS) < tst/$$file.g; \
		mv -f test.log tst/$$file.tst; \
	done;

testinstall:
teststandard:
testall:
	gap $(TESTOPTS) tst/testall.g

testrenormalise:
	gap $(TESTOPTS) tst/renormalise.g

coverage:
	mkdir -p private/coverage
	echo 'Read("tst/in.g");quit;' \
		| gap $(TESTOPTS) --cover private/coverage/cover.gz >/dev/null
	echo 'LoadPackage("profiling", "", false); \
		OutputAnnotatedCodeCoverageFiles("private/coverage/cover.gz", \
			Filename(DirectoriesPackageLibrary("crisp"), ""), \
			"private/coverage");' \
		| gap -b -q -A; \
	open private/coverage/index.html

