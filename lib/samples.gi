#############################################################################
##
##  samples.gi                      CRISP                 Burkhard H\"ofling
##
##  @(#)$Id$
##
##  Copyright (C) 2000 by Burkhard H\"ofling, Mathematisches Institut,
##  Friedrich Schiller-Universit\"at Jena, Germany
##
Revision.samples_gi :=
    "@(#)$Id$";


#############################################################################
##  
#V  AllPrimes
##
InstallValue (AllPrimes, Class (x -> IsInt (x) and IsPrimeInt (x)));


#############################################################################
##  
#V  TrivialGroups
##
InstallValue (TrivialGroups, SaturatedFittingFormation ( rec(
	\in := IsTrivial,
	rad := TrivialSubgroup,
	res := G -> G,
	proj := TrivialSubgroup,
	locdef := ReturnFail,
	char := [],
	bound := G -> not IsTrivial (G)
	)));
SetName (TrivialGroups, "<class of all trivial groups>");


#############################################################################
##  
#V  NilpotentGroups
##
InstallValue (NilpotentGroups, SaturatedFittingFormation ( rec(
	\in := IsNilpotentGroup,
	rad := FittingSubgroup,
	res := G -> NormalClosure (G, 
		SubgroupNC (G, NormalGeneratorsOfNilpotentResidual (G))),
	proj := NilpotentProjector,
	locdef := function (G, p) return SmallGeneratingSet (G); end,
	char := AllPrimes,
	bound := G -> G <> Socle (G)
	)));
SetName (NilpotentGroups, "<class of all nilpotent groups>");


#############################################################################
##  
#M  NilpotentProjector
##
InstallMethod (NilpotentProjector, "for finite soluble groups", true, 
	[IsFinite and IsGroup and IsSolvableGroup], 0,
	function (G)
		return ProjectorFromExtendedBoundaryFunction (
			G,
			rec (
				dfunc := function (gpcgs, npcgs, kpcgs, p, data)
					if Length (npcgs) > 1 then 
						return true;
					else
						return fail;
					fi;
				end,
				cfunc := function (gpcgs, npcgs, kpcgs, p, cent, data)
					return cent > 1;
				end),
			false);
	end);


#############################################################################
##
#M  NilpotentProjector
##
InstallMethod (NilpotentProjector, "try if group is finite and solvable", true, 
	[IsGroup], 
	0,
	function (G)
		if not (HasIsFinite(G) and HasIsSolvableGroup (G))
			and IsFinite (G) and IsSolvableGroup (G) then
				return NilpotentProjector (G);
		else
			TryNextMethod();
		fi;
	end);


#############################################################################
##
#V  SupersolvableGroups
##
InstallValue (SupersolvableGroups, SaturatedFormation ( rec(
	res := SupersolvableResiduum,
	proj := SupersolvableProjector,
	locdef := function (G, p) 
		local gens, res, i, j;
		gens := SmallGeneratingSet (G);
		res := List (gens, x -> x^(p-1)); 
		for i in [1..Length (gens)] do
			for j in [i+1..Length (gens)] do
				Add (res, Comm(gens[i], gens[j]));
			od;
		od;
		return res;
	end,
	char := AllPrimes,
	bound := G -> not IsPrime (Size (Socle (G)))
	)));
SetIsSubgroupClosed (SupersolvableGroups, true);
SetName (SupersolvableGroups, "<class of all supersolvable groups>");


#############################################################################
##  
#M  SupersolvableProjector
##
InstallMethod (SupersolvableProjector, "for finite soluble groups", true, 
	[IsFinite and IsGroup and IsSolvableGroup], 0,
	function (G)
		return ProjectorFromExtendedBoundaryFunction (
			G,
			rec (
				dfunc := function (gpcgs, npcgs, kpcgs, p, data)
					return Length (npcgs) > 1;
				end),
			false);
	end);


#############################################################################
##
#M  SupersolvableProjector
##
InstallMethod (SupersolvableProjector, 
	"try if group is finite and solvable", true, 
	[IsGroup], 
	0,
	function (G)
		if not (HasIsFinite(G) and HasIsSolvableGroup (G))
			and IsFinite (G) and IsSolvableGroup (G) then
				return SupersolvableProjector (G);
		else
			TryNextMethod();
		fi;
	end);


#############################################################################
##
#V  AbelianGroups
##
InstallValue (AbelianGroups, OrdinaryFormation ( rec(
	res := DerivedSubgroup,
	char := AllPrimes
	)));
SetIsSubgroupClosed (AbelianGroups, true);
SetName (AbelianGroups, "<class of all abelian groups>");


#############################################################################
##
#F  AbelianGroupsOfExponent
##
InstallGlobalFunction ("AbelianGroupsOfExponent", function (exp)
	local form;
	form := OrdinaryFormation ( rec(
		res := G -> ClosureGroup (DerivedSubgroup (G), 
				List (SmallGeneratingSet (G), x -> x^exp)),
		char := Set(Factors(exp))
		));
	SetIsSubgroupClosed (form, true);
	SetName (form, Concatenation (
		"<class of all abelian groups of exponent dividing ",
		String (exp), ">"));
		return form;
end);


#############################################################################
##
#F  PiGroups
##
InstallGlobalFunction ("PiGroups", function (pi)
	local res;
	res := SaturatedFittingFormation ( rec(
		\in := G -> ForAll (Set(Factors (Size(G))), p -> p in pi),
		proj := G -> HallSubgroup (G, Intersection (pi, Set(Factors (Size(G))))),
		inj := G -> HallSubgroup (G, Intersection (pi, Set(Factors (Size(G))))),
		locdef := function (G, p) 
			if p in pi then
				return [];
			else
				return fail;
			fi;
		end,
		char := pi,
		bound := G -> not Factors (Size(Socle (G)))[1] in pi
		));
		return res;
	end);


#############################################################################
##
#F  PGroups
##
InstallGlobalFunction ("PGroups", function (p)
	return SaturatedFittingFormation ( rec(
		\in := G -> ForAll (Set(Factors (Size(G))), q -> q = p),
		proj := G -> SylowSubgroup (G, p),
		locdef := function (G, q) 
			if p = q then
				return [];
			else
				return fail;
			fi;
		end,
		char := [p],
		bound := G -> Factors (Size(Socle (G)))[1] <> p
		));
	end);


############################################################################
##
#E
##

