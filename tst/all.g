############################################################################
##
##  all.g                           CRISP                 Burkhard H\"ofling
##
##  @(#)$Id$
##
##  Copyright (C) 2000 by Burkhard H\"ofling, Mathematisches Institut,
##  Friedrich Schiller-Universit\"at Jena, Germany
##
RequirePackage ("crisp");

if not IsBound (PRINT_METHODS) then
	PRINT_METHODS := false;
fi;

Print ("testing class construction \n");
ReadPkg ("crisp", "tst/classes.g");

Print ("testing bases of classes \n");
ReadPkg ("crisp", "tst/basis.g");

Print ("testing boundaries of classes  \n");
ReadPkg ("crisp", "tst/boundary.g");

Print ("testing characteristics of classes  \n");
ReadPkg ("crisp", "tst/char.g");

Print ("testing membership for classes  \n");
ReadPkg ("crisp", "tst/in.g");

Print ("testing injectors \n");
ReadPkg ("crisp", "tst/injectors.g");

Print ("testing normal subgroups \n");
ReadPkg ("crisp", "tst/normals.g");

Print ("testing projectors routines \n");
ReadPkg ("crisp", "tst/projectors.g");

Print ("testing radicals \n");
ReadPkg ("crisp", "tst/radicals.g");

Print ("testing residuals \n");
ReadPkg ("crisp", "tst/residuals.g");

Print ("testing socles \n");
ReadPkg ("crisp", "tst/socle.g");

Print ("testing print routines \n");
ReadPkg ("crisp", "tst/print.g");


FAST_TEST := true;
DO_TIMING := false;

ReadPkg ("crisp", "tst/timing_injectors.g");
ReadPkg ("crisp", "tst/timing_normals.g");
ReadPkg ("crisp", "tst/timing_normpro.g");
ReadPkg ("crisp", "tst/timing_projectors.g");
ReadPkg ("crisp", "tst/timing_radicals.g");
ReadPkg ("crisp", "tst/timing_residuals.g");
ReadPkg ("crisp", "tst/timing_socle.g");

FAST_TEST := false;
DO_TIMING := true;

ReadPkg ("crisp", "tst/timing_injectors.g");
ReadPkg ("crisp", "tst/timing_normals.g");
ReadPkg ("crisp", "tst/timing_projectors.g");
ReadPkg ("crisp", "tst/timing_radicals.g");
ReadPkg ("crisp", "tst/timing_residuals.g");
ReadPkg ("crisp", "tst/timing_socle.g");
ReadPkg ("crisp", "tst/timing_normpro.g");


############################################################################
##
#E
##
