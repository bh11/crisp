############################################################################
##
##  timing_projectors_mod.g         CRISP                 Burkhard H\"ofling
##
##  @(#)$ $
##
##  Copyright (C) 2000 by Burkhard H\"ofling, Mathematisches Institut,
##  Friedrich Schiller-Universit\"at Jena, Germany
##
RequirePackage ("format");
RequirePackage ("crisp");

if BFUNC_FROM_TEST_FUNC <> BFUNC_FROM_TEST_FUNC_MOD then
	MakeReadWriteGlobal ("BFUNC_FROM_TEST_FUNC");
	BFUNC_FROM_TEST_FUNC := BFUNC_FROM_TEST_FUNC;
	MakeReadOnlyGlobal ("BFUNC_FROM_TEST_FUNC");
fi;

groups := [
# ["format","grp/g93.gi", "g93", "31:3"],
# ["format","grp/OOF.gi", "OOF"],
# ["format","grp/ONF.gi", "ONF"],
 ["format","grp/FI22.gi", "G", "FI22"],
# ["crisp", "grp/FI22mod.gp", "FI22mod", "FI22mod"],
# ["format","grp/LUX2_12.gi", "LUX2_12"],
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

nilp := Formation ("Nilpotent");
ssolv := Formation ("Supersolvable");
metanilp := ProductOfFormation (nilp, nilp);
23groups := Formation ("PiGroups", [2,3]);
nilp23 := ChangedSupport (nilp, [2,3]);

MetaNilpotentGroups := FormationProduct (NilpotentGroups, NilpotentGroups);
TwoThreeGroups := PiGroups ([2,3]);
NilpotentTwoThreeGroups := Intersection (NilpotentGroups, TwoThreeGroups);

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

tSpcgs := 0;

SpcgsCompute  := function (tmp)
	local t0;
	if IsBound (DO_TIMING) and DO_TIMING then
		GASMAN ("collect");
	fi;
	t0 := Runtime();
	IsomorphismSpecialPcGroup (tmp);
	tSpcgs := Runtime() - t0;
end;

SpcgsTime := function ()
	return tSpcgs;
end;


DoTests := function (groups, tests)

	local g, name, tmp, t, t0, t1, res, prevres;
	
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

tests :=
[ [tmp -> PcgsElementaryAbelianSeries (tmp), ReturnFail, "elabpc", []],
  [tmp -> Projector (tmp, NilpotentGroups), Size, "form", [], MTXReset, MTXTime, "mtx"],
  [tmp -> Projector (tmp, SchunckClass (rec (
  	bound := G -> not IsPrimeInt (Size (G))))), Size, "bound", [], MTXReset, MTXTime, "mtx"],
  [tmp -> CoveringSubgroup1 (tmp, nilp), Size, "cov1", [], SpcgsCompute, SpcgsTime, "spcgs"],
  [tmp -> CoveringSubgroup2 (tmp, nilp), Size, "cov2", [], SpcgsCompute, SpcgsTime, "spcgs"],
];

Print ("nilpotent projector\n");
DoTests (groups, tests);

tests :=
[ [tmp -> PcgsElementaryAbelianSeries (tmp), ReturnFail, "elabpc", []],
  [tmp -> Projector (tmp, SupersolvableGroups), Size, "form", [], MTXReset, MTXTime, "mtx"],
  [tmp -> Projector (tmp, SchunckClass (rec (
  	bound := G -> not IsPrimeInt (Size ( Socle (G)))))), Size, "bound", [], MTXReset, MTXTime, "mtx"],
  [tmp -> CoveringSubgroup1 (tmp, ssolv), Size, "cov1", [], SpcgsCompute, SpcgsTime, "spcgs"],
  [tmp -> CoveringSubgroup2 (tmp, ssolv), Size, "cov2", [], SpcgsCompute, SpcgsTime, "spcgs"],
];

Print ("supersolvable projector\n");
DoTests (groups, tests);

tests :=
[ [tmp -> PcgsElementaryAbelianSeries (tmp), ReturnFail, "elabpc", []],
  [tmp -> Projector (tmp, MetaNilpotentGroups), Size, "form", [], MTXReset, MTXTime, "mtx"],
  [tmp -> Projector (tmp, SchunckClass (rec (
  	bound := G -> not IsNilpotent (G/Socle (G))))), Size, "bound", [], MTXReset, MTXTime, "mtx"],
  [tmp -> CoveringSubgroup1 (tmp, metanilp), Size, "cov1", [], SpcgsCompute, SpcgsTime, "spcgs"],
  [tmp -> CoveringSubgroup2 (tmp, metanilp), Size, "cov2", [], SpcgsCompute, SpcgsTime, "spcgs"],
];
Print ("metanilpotent projector\n");
DoTests (groups, tests);


tests :=
[ [tmp -> PcgsElementaryAbelianSeries (tmp), ReturnFail, "elabpc", []],
  [tmp -> Projector (tmp, TwoThreeGroups), Size, "form", [], MTXReset, MTXTime, "mtx"],
  [tmp -> Projector (tmp, SchunckClass (rec (
  	bound := G -> not SmallestRootInt (Size (Socle(G))) in [2,3] ))), Size, "bound", [], MTXReset, MTXTime, "mtx"],
#  [tmp -> CoveringSubgroup1 (tmp, 23groups), Size, "cov1", [], SpcgsCompute, SpcgsTime, "spcgs"],
#  [tmp -> CoveringSubgroup2 (tmp, 23groups), Size, "cov2", [], SpcgsCompute, SpcgsTime, "spcgs"],
];
Print ("[2,3]- projector\n");
DoTests (groups, tests);

tests :=
[ [tmp -> PcgsElementaryAbelianSeries (tmp), ReturnFail, "elabpc", []],
  [tmp -> Projector (tmp, NilpotentTwoThreeGroups), Size, "form", [], MTXReset, MTXTime, "mtx"],
  [tmp -> Projector (tmp, SchunckClass (rec (
  	bound := G -> not SmallestRootInt (Size (Socle(G))) in [2,3] 
  		or not IsNilpotent (G)))), 
  	Size, "bound", [], MTXReset, MTXTime, "mtx"],
#  [tmp -> CoveringSubgroup1 (tmp, nilp23), Size, "cov1", ["FI22", "UPP"], SpcgsCompute, SpcgsTime, "spcgs"],
#  [tmp -> CoveringSubgroup2 (tmp, nilp23), Size, "cov2", [], SpcgsCompute, SpcgsTime, "spcgs"],
#  [tmp -> FNormalizerWrtFormation (tmp, nilp23), ReturnFail, "norm", [], SpcgsCompute, SpcgsTime, "spcgs"] 
];
Print ("nilp [2,3]- projector\n");
DoTests (groups, tests);


############################################################################
##
#E
##
