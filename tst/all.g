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

ReadPkg ("crisp", "tst/classes.g");
ReadPkg ("crisp", "tst/basis.g");
ReadPkg ("crisp", "tst/boundary.g");
ReadPkg ("crisp", "tst/char.g");
ReadPkg ("crisp", "tst/in.g");
ReadPkg ("crisp", "tst/injectors.g");
ReadPkg ("crisp", "tst/normals.g");
ReadPkg ("crisp", "tst/print.g");
ReadPkg ("crisp", "tst/projectors.g");
ReadPkg ("crisp", "tst/radicals.g");
ReadPkg ("crisp", "tst/residuals.g");
ReadPkg ("crisp", "tst/socle.g");

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
ReadPkg ("crisp", "tst/timing_normpro.g");
ReadPkg ("crisp", "tst/timing_socle.g");


############################################################################
##
#E
##
