############################################################################
##
##  timing_samples.g                CRISP                   Burkhard Höfling
##
##  Copyright © 2000 Burkhard Höfling
##
LoadPackage("format", "", false);

groups := [
    ["format","grp/g93.gi", "g93", "31:3"],
    ["format","grp/OOF.gi", "OOF"],
    ["format","grp/ONF.gi", "ONF"],
    [SmallGroup, [432, 25], "G", "Sml(432,25)"],
    [SmallGroup, [256, 537], "G", "Sml(256,537)"],
    [DirectProduct, [SmallGroup(432, 25), SmallGroup(432, 25)], "G", "(432-25)^2"],
    [DirectProduct, ListWithIdenticalEntries(3,SymmetricGroup(4)), "G", "S4^3"],
    [DirectProduct, [SmallGroup(256, 537), SmallGroup(256, 540), SmallGroup(256, 541)], "G", "256x256x256"],
    ["format","grp/FI22.gi", "G", "FI22"],
    ["format","grp/LUX2_12.gi", "LUX2_12"],
    ["format","grp/UPP.gi", "G", "UPP"],
    ["format","grp/DARK.gi","G", "DARK"],
    ["format","grp/LUX.gi", "G", "LUXwrS3"],
];

if IsBound(FAST_TEST) and FAST_TEST then
    groups := groups{[1..5]};
fi;


############################################################################
##
#E
##
