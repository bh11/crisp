############################################################################
##
##  init.g                          CRISP                 Burkhard H\"ofling
##
##  @(#)$Id$
##
##  Copyright (C) 2000 by Burkhard H\"ofling, Mathematisches Institut,
##  Friedrich Schiller-Universit\"at Jena, Germany
##
DeclareAutoPackage ("crisp", "1.2.1", true);
DeclarePackageAutoDocumentation ("crisp", "doc");

if BANNER then
	ReadPkg ("crisp", "lib/banner.g");
fi;

ReadPkg ("crisp", "lib/classes.gd");
ReadPkg ("crisp", "lib/grpclass.gd");
ReadPkg ("crisp", "lib/fitting.gd");
ReadPkg ("crisp", "lib/schunck.gd");
ReadPkg ("crisp", "lib/form.gd");
ReadPkg ("crisp", "lib/projector.gd");
ReadPkg ("crisp", "lib/injector.gd");
ReadPkg ("crisp", "lib/normpro.gd");
ReadPkg ("crisp", "lib/solveeq.gd");
ReadPkg ("crisp", "lib/compl.gd");
ReadPkg ("crisp", "lib/radical.gd");
ReadPkg ("crisp", "lib/residual.gd");
ReadPkg ("crisp", "lib/util.gd");
ReadPkg ("crisp", "lib/samples.gd");
ReadPkg ("crisp", "lib/socle.gd");


############################################################################
##
#E
##