#############################################################################
##
##  radicals.gi                     CRISP                 Burkhard H\"ofling
##
##  @(#)$Id$
##
##  Copyright (C) 2000 by Burkhard H\"ofling, Mathematisches Institut,
##  Friedrich Schiller-Universit\"at Jena, Germany
##
Revision.radicals_gi :=
    "@(#)$Id$";


#############################################################################
##
#F  GInvariantSubgroupsCA (G, ser, avoid, cover, pretest, test, data) 
##
##  if all is true, GInvariantSubgroupsCA computes the G-invariant normal
##  subgroups N of ser[1] such that ser[cover] equals the intersection of N
##  and ser[avoid], N contains ser[cover] properly, and N belongs to the
##  class described by pretest and test.
##
InstallGlobalFunction (GInvariantSubgroupsCA,
	function (G, ser, avoid, cover, pretest, test, data)

		local j, CC, L, newser, norms, res, newnorms;
		
		if avoid = 1 then
			return [];
		fi;
		
		if avoid > 2 then
			norms := GInvariantSubgroupsCA (G, ser, avoid-1, cover, 
						pretest, test, data);
		else
			norms := [];
		fi;
		
		res := pretest (ser[avoid-1], ser[avoid], ser[cover], data);
		if res <> false then
			if avoid = cover then
				CC := [ser[avoid-1]];
			else
				CC := ComplementsMaximalUnderAction (G, ser, avoid-1,
						avoid, cover, true);
				Info (InfoLattice, 1, Length (CC), " complements found");
			fi;
			if Length (CC) > 0 then 
				newser := ShallowCopy (ser);
				for L in CC do
					if res = true or test(L, ser[cover], data) then # L belongs to class
						newser[cover-1] := L;
						for j in [avoid+1..cover-1] do
							newser[j-1] := ClosureGroup (ser[j], L); #make ser a chief series through L
						od;
						Add (norms, L);
						if avoid > 2 then
							Append (norms, 
								GInvariantSubgroupsCA (G, 
									newser, avoid-1, cover-1, 
									pretest, test, data));
						fi;
					fi;
				od;
			fi;
		fi;
		return norms;
	end);


#############################################################################
##
#O  AllNormalSubgroupsWithNProperty (<G>, <pretest>, <test>, <data>) 
##
InstallMethod (AllNormalSubgroupsWithNProperty, 
	"for solvable group and function", true, 
	[IsGroup and IsSolvableGroup and IsFinite, IsFunction, IsFunction, IsObject], 
	0,
	function( G, pretest, test, data)

		local ser, res;
		
		if IsTrivial (G) then
			return [G];
		fi;
		
		ser := ChiefSeries (G);
		res := GInvariantSubgroupsCA (G, ser, 
				Length (ser), Length (ser), pretest, test, data);
		Add (res, TrivialSubgroup (G));
		return res;
	end);


#############################################################################
##
#M  AllNormalSubgroupsWithNProperty
##
InstallMethod (AllNormalSubgroupsWithNProperty, 
	"test if group is finite and solvable", true, 
	[IsGroup, IsFunction, IsFunction, IsObject], 
	0,
	function( G, pretest, test, data)
	
		if not (HasIsFinite(G) and HasIsSolvableGroup (G))
			and IsFinite (G) and IsSolvableGroup (G) then
				return AllNormalSubgroupsWithNProperty ( G, pretest, test, data);
		fi;
		TryNextMethod();
	end);
	
	
#############################################################################
##
#M  OneNormalSubgroupMaxWrtNProperty (<G>, <pretest>, <test>, <data>) 
##
InstallMethod (OneNormalSubgroupMaxWrtNProperty, 
	"for solvable group and function", true, 
	[IsGroup and IsSolvableGroup and IsFinite, IsFunction, IsFunction, IsObject], 
	0,
	function( G, pretest, test, data)

		local n, ser, i, j, CC, R, rpos, res;
		
		ser := ShallowCopy (ChiefSeries (G));
		n := Length (ser);
		for rpos in [n-1, n-2..1] do
			Info (InfoComplement, 1, "starting step ",n-rpos, " (testing ser)");
			res := pretest(ser[rpos], ser[rpos+1], ser[rpos+1], data);
			if res = fail then
				res := test (ser[rpos], ser[rpos+1], data);
			fi;
			if not res then
				break;
			fi;
		od;
			
		if res then # G has passed test
			return G;
		fi;
		
		rpos := rpos + 1;
		
		for i in [rpos-2,rpos-3..1] do
			# ser[rpos] is the property-radical of ser[i+1]
			Info (InfoComplement, 1, "starting step ",n-i+1);
			res := pretest (ser[i], ser[i+1], ser[rpos], data);
			if res <> false then
				Info (InfoComplement, 3, "Complementing");
				CC := ComplementsMaximalUnderAction (G, ser, i, i+1, rpos, res <> true);
	
				Info (InfoComplement, 3, Length (CC), "complements found, ",
					" (res) = ",res);
				if res = true then
					if CC = fail then
						CC := [];
					else
						CC := [CC];
					fi;
				fi;
				for R in CC do
					if res = true or test (R, ser[rpos], data) then  # R is the property-radical of i
						Info (InfoComplement, 3, "modifying series...\n");
						for j in [i+2..rpos-1] do
							ser[j-1] := ClosureGroup(ser[j], R); #make ser a chief series through L
						od;
						rpos := rpos - 1;
						ser[rpos] := R;
						break; # no need to check other groups
					fi;
				od;
			fi;
		od;
		return ser[rpos];
	end);


#############################################################################
##
#M  OneNormalSubgroupMaxWrtNProperty
##
InstallMethod (OneNormalSubgroupMaxWrtNProperty, 
	"test if group is finite and solvable", true, 
	[IsGroup, IsFunction, IsFunction, IsObject], 
	0,
	function( G, pretest, test, data)
	
		if not (HasIsFinite(G) and HasIsSolvableGroup (G))
			and IsFinite (G) and IsSolvableGroup (G) then
				return OneNormalSubgroupMaxWrtNProperty ( G, pretest, test, data);
		fi;
		TryNextMethod();
	end);
	
	
#############################################################################
##
#M  RadicalOp
##
InstallMethod (RadicalOp, "if only in is known", true, 
	[IsGroup and IsFinite and IsSolvableGroup, IsFittingClass], 0,
	function (G, C)
		return OneNormalSubgroupMaxWrtNProperty (G, 
			function (U, V, R, data)
				if Factors (Index (U, V))[1] in Characteristic (data.class) then
					return fail; # cannot decide
				else
					return false; # never in C
				fi;
			end,
			function (S, R, data)
				return IsMember (S, data.class);
			end,
			rec (class := C));
	end);
 
 
#############################################################################
##
#M  RadicalOp
##
InstallMethod (RadicalOp, "if injector is known", true, 
	[IsGroup and IsFinite and IsSolvableGroup, IsFittingClass and HasInjectorFunction], 2,
	function (G, C)
		return Core (G, InjectorFunction(C) (G));
	end);
 
 
#############################################################################
##
#M  RadicalOp
##
InstallMethod (RadicalOp, "if radical is known", true, 
	[IsGroup and IsFinite and IsSolvableGroup, IsFittingClass and HasRadicalFunction], 
	RankFilter (IsPcGroup and IsPermGroup),
	function (G, C)
		if not IsFittingSet (G, C) then
			Error ("<C> must be a Fitting set for <G>");
		fi;
		return RadicalFunction(C) (G);
 end);


#############################################################################
##
#M  RadicalOp
##
InstallMethod (RadicalOp, "for pc group and intersection which is a formation", true, 
	[IsGroup, IsFittingClass and IsClassByIntersectionRep], 
	function (G, C)
		local D, R;
		R := G;
		for D in C!.intersected do
			R := Radical (R, D);
		od;
 		return R;
	end);


#############################################################################
##
#M  RadicalOp
##
InstallMethod (RadicalOp, "for FittingSetRep if only member function is known", 
	function (G, C) return IsIdenticalObj (CollectionsFamily (G), C); end, 
	[IsGroup and IsFinite and IsSolvableGroup, IsFittingSetRep and HasMemberFunction], 0,
	function (G, C)
		if not IsFittingSet (G, C) then
			Error ("<C> must be a Fitting set for <G>");
		fi;
		return OneNormalSubgroupMaxWrtNProperty (G, 
			ReturnFail,
			function (S, R, data)
				return IsMember (S, data.class);
			end,
			rec (data := C));
	end);
	

#############################################################################
##
#M  RadicalOp
##
InstallMethod (RadicalOp, "for FittingSetRep if injector is known", 
	function (G, C) return IsIdenticalObj (CollectionsFamily (G), C); end, 
		[IsGroup, IsFittingSetRep and HasInjectorFunction], 0,
	function (G, C)
		if not IsFittingSet (G, C) then
			Error ("<C> must be a Fitting set for <G>");
		fi;
		return Core (G, InjectorFunction(C) (G));
	end);
	

#############################################################################
##
#M  RadicalOp
##
InstallMethod (RadicalOp, "for FittingSetRep if radical is known", 
	function (G, C) return IsIdenticalObj (CollectionsFamily (G), C); end, 
	[IsGroup and IsFinite and IsSolvableGroup, 
	IsFittingSetRep and HasRadicalFunction], 
	RankFilter (IsPcGroup and IsPermGroup),
	function (G, C)
		if not IsFittingSet (G, C) then
			Error ("<C> must be a Fitting set for <G>");
		fi;
		return RadicalFunction(C) (G);
	end);


#############################################################################
##
#M  RadicalOp
##
InstallMethodByNiceMonomorphismForGroupAndClass (ResidualOp, 
	IsFinite and IsSolvableGroup, IsFittingClass);
	
	
#############################################################################
##
#M  RadicalOp
##
InstallMethod (RadicalOp, "last resort - try if G is finite and soluble", true, 
	[IsGroup, IsClass], 0,
	function (G, F)
	
		if not (HasIsFinite(G) and HasIsSolvableGroup (G))
			and IsFinite (G) and IsSolvableGroup (G) then
				return RadicalOp (G, F);
		fi;
		TryNextMethod();
	end);
	

############################################################################
##
#E
##
