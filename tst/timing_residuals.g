############################################################################
##
##  timing_residuals.g              CRISP                 Burkhard H\"ofling
##
##  @(#)$ $
##
##  Copyright (C) 2000 by Burkhard H\"ofling, Mathematisches Institut,
##  Friedrich Schiller-Universit\"at Jena, Germany
##
RequirePackage ("crisp");


groups := [
 ["format","grp/g93.gi", "g93", "31:3"],
 ["format","grp/OOF.gi", "OOF"],
 ["format","grp/ONF.gi", "ONF"],
 ["format","grp/FI22.gi", "G", "FI22"],
# ["crisp", "grp/FI22mod.gp", "FI22mod", "FI22mod"],
 ["format","grp/LUX2_12.gi", "LUX2_12"],
# ["crisp", "grp/DARKmod6.gp", "DARKmod6", "DARK/6"],
 ["format","grp/UPP.gi", "G", "UPP"],
 ["format","grp/DARK.gi","G", "DARK"],
# ["format","grp/DARKplus4.gp", "DARKplus"],
# ["format","grp/LUXwreath4.gp", "LUX2_12wrs3", "LUXwrS3"],
 ["format","grp/LUX.gi", "G", "LUXwrS3"],
# ["crisp", "grp/DARKwrS3.gp", "DARKwrS3"],
];

if IsBound (FAST_TEST) and FAST_TEST then
   groups := groups{[1..3]};
fi;


if not IsBound (PRINT) then
   PRINT := Print;
   MakeReadOnlyGlobal ("PRINT");
fi;

SilentRead := function (pkg, fname)

   MakeReadWriteGlobal ("Print");
   Print := Ignore;
   ReadPkg (pkg, fname);
   Print := PRINT;
   MakeReadOnlyGlobal ("Print");
end;

SpecialPcGroup := G -> Image (IsomorphismSpecialPcGroup (G));

mtxinfo := [];

MTXTime := function ()
   return Sum (mtxinfo, x -> x[2]);
end;


MTXReset := function (tmp)
   mtxinfo := [];
end;


DoTests := function (groups, tests)

   local g, name, tmp, t, t0, t1, res, prevres, size;
   
   Print (String ("group",-10));
   Print (String ("logsize", 8));
   Print (String ("complen", 8));
   if IsBound (DO_TIMING) and DO_TIMING then
      for t in tests do
         Print (String(t[3],8),"\c");
         if IsBound (t[6]) then
            Print (String (t[7],8), "\c");
         fi;
      od;
   fi;
   Print ("\n");
   for g in groups do
      if IsBoundGlobal (g[3]) then
         UnbindGlobal (g[3]);
      fi;
      if IsBoundGlobal (Concatenation ("MAKE_",g[3])) then
         UnbindGlobal(Concatenation ("MAKE_",g[3]));
      fi;
      SilentRead (g[1],g[2]);
      if IsBound (g[4]) then
         name := g[4];
      else
         name := g[3];
      fi;
      Print (String (name,-10));
      tmp := ValueGlobal (g[3]);
      size := Size (tmp);
      Print (String (LogInt (Size (tmp), 10), 8));
      Print (String (Length (Pcgs(tmp)), 8), "\c");
      UnbindGlobal (g[3]);
      if IsBoundGlobal (Concatenation ("MAKE_",g[3])) then
         UnbindGlobal(Concatenation ("MAKE_",g[3]));
      fi;
      prevres := fail;
      
      for t in tests do
         if name in t[4] then
            t1 := 999999;
         else
            SilentRead (g[1],g[2]);
            tmp := ValueGlobal (g[3]);
            if IsBound (t[5]) then
               t[5](tmp);
            fi;
            if IsBound (DO_TIMING) and DO_TIMING then
               GASMAN ("collect");
            fi;
            t0 := Runtime();
            res := t[1](tmp);
            t1 := Runtime() - t0;
            res := t[2](res);
            if prevres <> fail then
               if res <> fail and res <> prevres then
                  Error ("results do not match");
               fi;
            else
               prevres := res;
            fi;
            UnbindGlobal (g[3]);
            if IsBoundGlobal (Concatenation ("MAKE_",g[3])) then
               UnbindGlobal(Concatenation ("MAKE_",g[3]));
            fi;
         fi;
         
         if IsBound (DO_TIMING) and DO_TIMING then
            Print (String(t1,8), "\c");
            if IsBound (t[6]) then
               Print (String(t[6](),8), "\c");
            fi;
         fi;
      od;
      if prevres <> fail then
         Print ("  ");
         PrintFactorsInt (prevres);
         Print ("  ");
         PrintFactorsInt (size/prevres);
      fi;
      Print ("\n");
   od;
end;

nilp := SaturatedFormation (rec (\in := IsNilpotent, 
   locdef := LocalDefinitionFunction (NilpotentGroups),
   char := AllPrimes));

nilp2 := SaturatedFormation (rec (\in := IsNilpotent, 
   char := AllPrimes));

tests :=
[ [tmp -> Residual (tmp, nilp), Size, "locdef", []],
  [tmp -> Residual (tmp, nilp2), Size, "in", []],
  [tmp -> Residual (tmp, NilpotentGroups),  Size, "res", []],
];

Print ("nilpotent residual\n");
DoTests (groups, tests);

23groups := PiGroups ([2,3]);
23groups2 := SaturatedFormation (rec (
   \in := MemberFunction (23groups),
   locdef := LocalDefinitionFunction (23groups),
   char := [2,3]));
   
23groups3 := SaturatedFormation (rec (
   \in := MemberFunction (23groups),
   char := [2,3]));

tests :=
[ [tmp -> Residual (tmp, 23groups2), Size, "locdef", []],
  [tmp -> Residual (tmp, 23groups3), Size, "in", []],
  [tmp -> Residual (tmp, 23groups),  Size, "res", []],
];

Print ("[2,3]-residual\n");
DoTests (groups, tests);

2groups := PGroups (2);
2groups2 := SaturatedFormation (rec (
   \in := MemberFunction (2groups),
   locdef := LocalDefinitionFunction (2groups),
   char := [2]));
   
2groups3 := SaturatedFormation (rec (
   \in := MemberFunction (2groups),
   char := [2]));
   
tests :=
[ [tmp -> Residual (tmp, 2groups2), Size, "locdef", []],
  [tmp -> Residual (tmp, 2groups3), Size, "in", []],
  [tmp -> Residual (tmp, 2groups),  Size, "res", []],
];

Print ("2-residual\n");
DoTests (groups, tests);

nilp23 := Intersection (NilpotentGroups, PiGroups ([2,3]));
nilp23_2 := SaturatedFormation (rec (
   \in := G -> IsNilpotent (G) and MemberFunction (23groups)(G),
   locdef := function (G, p)
      if p in [2,3] then
         return LocalDefinitionFunction (NilpotentGroups)(G, p);
      else
         return fail;
      fi;
   end,
   char := [2,3]));
   
nilp23_3 := SaturatedFormation (rec (
   \in := G -> IsNilpotent (G) and MemberFunction (23groups)(G),
   char := [2,3]));

tests :=
[ [tmp -> Residual (tmp, nilp23_2), Size, "locdef", []],
  [tmp -> Residual (tmp, nilp23_3), Size, "in", []],
  [tmp -> Residual (tmp, nilp23),  Size, "res", []],
];


Print ("nilp.[2,3]-residual\n");
DoTests (groups, tests);


############################################################################
##
#E
##
