############################################################################
##
##  timings.g                        CRISP                  Burkhard Höfling
##
##  Copyright (C) 2000, 2011 Burkhard Höfling
##
LoadPackage ("crisp");

FAST_TEST := true;
TIMEOUT := 10^7;
DO_TIMING := false;

CRISP_Read("tst/timing_injectors.g");
CRISP_Read("tst/timing_normals.g");
CRISP_Read("tst/timing_normpro.g");
CRISP_Read("tst/timing_projectors.g");
CRISP_Read("tst/timing_radicals.g");
CRISP_Read("tst/timing_residuals.g");
CRISP_Read("tst/timing_socle.g");

FAST_TEST := false;
TIMEOUT := 60*10^6;
DO_TIMING := true;

CRISP_Read("tst/timing_injectors.g");
CRISP_Read("tst/timing_normals.g");
CRISP_Read("tst/timing_projectors.g");
CRISP_Read("tst/timing_radicals.g");
CRISP_Read("tst/timing_residuals.g");
CRISP_Read("tst/timing_socle.g");
CRISP_Read("tst/timing_normpro.g");


############################################################################
##
#E
##
