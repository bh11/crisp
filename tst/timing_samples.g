############################################################################
##
##  timing_samples.g                CRISP                 Burkhard H\"ofling
##
##  @(#)$Id$
##
##  Copyright (C) 2000 by Burkhard H\"ofling, Mathematisches Institut,
##  Friedrich Schiller-Universit\"at Jena, Germany
##
RequirePackage ("format");

G := fail; # define global var.

StoreDirectPower := function (F, n)
   G := DirectProduct (ListWithIdenticalEntries (n, F));
end;

groups := [
 [StoreDirectPower, [SymmetricGroup (4), 3], "G", "Sym(4)^3"],
 [StoreDirectPower, [SymmetricGroup (4), 4], "G", "Sym(4)^4"],
 [StoreDirectPower, [SymmetricGroup (4), 5], "G", "Sym(4)^5"],
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
   groups := groups{[4..7]};
fi;


############################################################################
##
#E
##
