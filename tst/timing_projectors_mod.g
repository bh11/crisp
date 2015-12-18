############################################################################
##
##  timing_projectors_mod.g           CRISP                 Burkhard Höfling
##
##  Copyright (C) 2000 Burkhard Höfling
##
LoadPackage ("crisp");

MakeReadWriteGlobal ("BFUNC_FROM_TEST_FUNC");
BFUNC_FROM_TEST_FUNC := BFUNC_FROM_TEST_FUNC_MOD;
MakeReadOnlyGlobal ("BFUNC_FROM_TEST_FUNC");

ReadPackage ("crisp", "tst/timing_projectors.g");


############################################################################
##
#E
##
