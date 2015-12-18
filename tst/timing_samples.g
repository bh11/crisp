############################################################################
##
##  timing_samples.g                CRISP                   Burkhard Höfling
##
##  Copyright (C) 2000 Burkhard Höfling
##
LoadPackage ("format");

groups := [
 ["format","grp/g93.gi", "g93", "31:3"],
 ["format","grp/OOF.gi", "OOF"],
 ["format","grp/ONF.gi", "ONF"],
 ["format","grp/FI22.gi", "G", "FI22"],
 ["format","grp/LUX2_12.gi", "LUX2_12"],
 ["format","grp/UPP.gi", "G", "UPP"],
 ["format","grp/DARK.gi","G", "DARK"],
 ["format","grp/LUX.gi", "G", "LUXwrS3"],
];

if IsBound (FAST_TEST) and FAST_TEST then
    groups := groups{[1..3]};
fi;


############################################################################
##
#E
##
