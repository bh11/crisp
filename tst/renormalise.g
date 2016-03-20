############################################################################
##
##  renormalise.g                     CRISP                 Burkhard Höfling
##
##  Copyright © 2016 Burkhard Höfling
##
LoadPackage("crisp", "", false);
DeclareInfoClass("InfoTest");
SetInfoLevel(InfoTest,3);
PRINT_METHODS := false;
TestDirectory(DirectoriesPackageLibrary("crisp", "tst"),
    rec(renormaliseStones := true, exitGAP := true));

############################################################################
##
#E
##
