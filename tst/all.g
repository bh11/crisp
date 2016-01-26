############################################################################
##
##  all.g                             CRISP                 Burkhard Höfling
##
##  Copyright (C) 2000 Burkhard Höfling
##
LoadPackage ("crisp", "", false);

PRINT_METHODS := false;

#Print ("testing manual examples\n");
#CRISP_Read("tst/manual.g");

Print ("testing class construction \n");
CRISP_Read("tst/classes.g");

Print ("testing bases of classes \n");
CRISP_Read("tst/basis.g");

Print ("testing boundaries of classes  \n");
CRISP_Read("tst/boundary.g");

Print ("testing characteristics of classes  \n");
CRISP_Read("tst/char.g");

Print ("testing membership for classes  \n");
CRISP_Read("tst/in.g");

Print ("testing injectors \n");
CRISP_Read("tst/injectors.g");

Print ("testing normal subgroups \n");
CRISP_Read("tst/normals.g");

Print ("testing projectors routines \n");
CRISP_Read("tst/projectors.g");

Print ("testing radicals \n");
CRISP_Read("tst/radicals.g");

Print ("testing residuals \n");
CRISP_Read("tst/residuals.g");

Print ("testing socles \n");
CRISP_Read("tst/socle.g");

Print ("testing print routines \n");
CRISP_Read("tst/print.g");

############################################################################
##
#E
##
