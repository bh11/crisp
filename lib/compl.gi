#############################################################################
##
##  compl.gi                         CRISP                 Burkhard H\"ofling
##
##  @(#)$Id$
##
##  Copyright (C) 2000 by Burkhard H\"ofling, Mathematisches Institut,
##  Friedrich Schiller-Universit\"at Jena, Germany
##
Revision.compl_gi :=
    "@(#)$Id$";


#############################################################################
##
#F  PcgsComplementOfChiefFactor
##
##  compute an induced pcgs (wrt pcgs) of a complement of the chief 
##  factor N/K of exponent p of H represented by the modulo pcgs npcgs 
##  in the group H  
##
##   H          hpcgs is a pc sequence representing the factor group H/D
##  : \         hpcgs{[first..Length (hpcgs)]} represents R/D, where
## ?   R        R/D must be elementary abelian of expoent q <> p,
##  : / \       D must centralise N/K, and R must not centralise N/K
##   Q   N      
##    \ /       npcgs is a modulo pcgs representing N/K. The depths (wrt pcgs)
##     K        of the elements in the numerator of npcgs must be strictly  
##              larger than the depths of the elements in hpcgs.
##
InstallGlobalFunction ("PcgsComplementOfChiefFactor", 
	function (pcgs, hpcgs, first, npcgs, kpcgs)

	local p,      # prime expoent of npcgs
		q,        # prime dividing the order of the sylow subgroup
		r,        # integer divisible by p with r mod q = 1
		field,    # GF(p)
		qpcgs,    # pc sequence for Q mod K
		depths,   # depths of elements in qpcgs (wrt pcgs)
		cpcgs,    # pc sequence for a complement
		cdepths,  # depths of elements in cpcgs (wrt pcgs)
		copied,   # true if cpcgs is a shallow copy of qpcgs, 
		          # false as long as they refer to the same object
		g,        # element to be adjusted
		conj,     # qgens[k]^g
		n,        # conj = t * n with t in Q and n in  N
		e,        # exponent vector 
		mat, res, # linear system of equations 
		sol,      # solution of the system 
		j, k, l,  # loop indices
		tmp;      # temp store for result, for debugging only

	p := RelativeOrderOfPcElement (npcgs, npcgs[1]);
	q := RelativeOrderOfPcElement (pcgs, hpcgs[first]);
	Assert (1, p <> q);
	
	r := Gcdex (p, q).coeff1 * p;
	field := GF(p);
	qpcgs := [hpcgs[Length(hpcgs)]^r];
	depths := [DepthOfPcElement (pcgs, qpcgs[1])];
	cpcgs := qpcgs;
	cdepths := depths;
	copied:= false; 
	
	for j in [Length (hpcgs)-1, Length (hpcgs)-2..1] do
		# adjust hpcgs[j]
		g := hpcgs[j];
			
		mat := [];
		res := [];
			
		for l in [1..Length (npcgs)] do
			mat[l] := [];
		od;
			
		# determine the conjugation action of g = hpcgs[j] on npcgs
		for k in [1..Length (qpcgs)] do
			conj := qpcgs[k]^g;
			n := SiftedPcElementWrtPcSequence (pcgs, qpcgs, depths, conj);
			for l in [1..Length (npcgs)] do
				e := ExponentsConjugateLayer (npcgs, npcgs[l], conj)* One (field);
				e[l] := e[l] - One(field);
				Append (mat[l],e);
			od;	
			
			Append (res, ExponentsOfPcElement (npcgs, n) * One(field));
		od;
			
		# now solve the system and adjust g = hpcgs[j]
		
		sol := SolutionMat (mat , res);

		g := g * PcElementByExponentsNC (npcgs, List (sol, IntFFE ));;
		
		if j >= first then
			g := g^r;
			AddPcElementToPcSequence (pcgs, qpcgs, depths, g);
		else
			if not copied then
				cpcgs := ShallowCopy (qpcgs);
				cdepths := ShallowCopy (depths);
				copied := true;
			fi;
			AddPcElementToPcSequence (pcgs, cpcgs, cdepths, g);
		fi;
	od;

	for g in kpcgs do
		AddPcElementToPcSequence (pcgs, cpcgs, cdepths, g);
	od;
	
	tmp := InducedPcgsByPcSequenceNC (pcgs, cpcgs);
	Assert (1, CanonicalPcgs (tmp) = CanonicalPcgs (InducedPcgsByGenerators (pcgs, cpcgs)),
		Error ("cpcgs is not a pc sequence"));
	return tmp;
end);


#############################################################################
##
#F  PcgsComplementOfChiefFactor2
##
##  compute an induced pcgs (wrt pcgs) of a complement of the chief 
##  factor N/K of exponent p of H represented by the modulo pcgs npcgs 
##  in the group H  
##
##   H          hpcgs is a pc sequence representing the factor group H/D
##  : \         hpcgs{[first..Length (hpcgs)]} represents R/D, where
## ?   R        R/D must be elementary abelian of expoent q <> p,
##  : / \       D must centralise N/K, and R must not centralise N/K
##   Q   D      
##    \ / \     npcgs is a modulo pcgs representing N/K. The depths (wrt pcgs)
##     C   N    of the elements in the numerator of npcgs must be strictly  
##      \ /     larger than the depths of the elements in hpcgs.
##       K      ncpcgs is a pcgs representing c
##
InstallGlobalFunction ("PcgsComplementOfChiefFactor2", 
	function (pcgs, hpcgs, first, npcgs, ncpcgs, kpcgs, frec)

	local p,      # prime expoent of npcgs
		q,        # prime dividing the order of the sylow subgroup
		r,        # integer divisible by p with r mod q = 1
		fact,     # factoring information wrt <ncpcgs>.<npcgs>
		finds,    # depths of elements occuring in the factorisation
		field,    # GF(p)
		qpcgs,    # pc sequence for Q mod K
		depths,   # depths of elements in qpcgs (wrt pcgs)
		cpcgs,    # pc sequence for a complement
		cdepths,  # depths of elements in cpcgs (wrt pcgs)
		copied,   # true if cpcgs is a shallow copy of qpcgs, 
		          # false as long as they refer to the same object
		g,        # element to be adjusted
		conj,     # qgens[k]^g
		n,        # conj = t * n with t in Q and n in  N
		exp,      # exponent vector 
		nexp,     # exponent vector 
		mat, res, # linear system of equations 
		sol,      # solution of the system 
		j, k, l,  # loop indices
		tmp;      # temp store for result, for debugging only

	p := RelativeOrderOfPcElement (npcgs, npcgs[1]);
	q := RelativeOrderOfPcElement (pcgs, hpcgs[first]);
	Assert (1, p <> q);
	
	r := Gcdex (p, q).coeff1 * p;
	field := GF(p);
	qpcgs := [hpcgs[Length(hpcgs)]^r];
	depths := [DepthOfPcElement (pcgs, qpcgs[1])];
	cpcgs := qpcgs;
	cdepths := depths;
	copied:= false; 
			
	fact := frec.nPartFunction (frec, 1, true);
	if pcgs <> frec.pcgs then
		Error ("incomplatible pcgs");
	fi;
	finds := fact.mDepths;
	
	for j in [Length (hpcgs)-1, Length (hpcgs)-2..1] do
		# adjust hpcgs[j]
		g := hpcgs[j];
			
		mat := [];
		res := [];
			
		for l in [1..Length (npcgs)] do
			mat[l] := [];
		od;
			
		# determine the conjugation action of g = hpcgs[j] on qpcgs and npcgs
		for k in [1..Length (qpcgs)] do
			conj := qpcgs[k]^g;
			
			for l in [1..Length (npcgs)] do
				exp := ExponentsConjugateLayer (npcgs, npcgs[l], conj)* One (field);
				exp[l] := exp[l] - One(field);
				Append (mat[l],exp);
			od;	
			
			n := SiftedPcElementWrtPcSequence (pcgs, qpcgs, depths, conj);
			exp := ExponentsOfPcElement (pcgs, n, finds);
			n := Product ([1..Length (exp)], i -> fact.npartR[i]^exp[i]);
			nexp := ExponentsOfPcElement (npcgs, n) * One(field);
			Append (res, nexp);
		od;
			
		# now solve the system and adjust g = hpcgs[j]
		
		sol := SolutionMat (mat , res);

		g := g * PcElementByExponentsNC (npcgs, List (sol, IntFFE ));;
		
		if j >= first then
			g := g^r;
			AddPcElementToPcSequence (pcgs, qpcgs, depths, g);
		else
			if not copied then
				cpcgs := ShallowCopy (qpcgs);
				cdepths := ShallowCopy (depths);
				copied := true;
			fi;
			AddPcElementToPcSequence (pcgs, cpcgs, cdepths, g);
		fi;
	od;

	for g in ncpcgs do
		AddPcElementToPcSequence (pcgs, cpcgs, cdepths, g);
	od;
	
	tmp := InducedPcgsByPcSequenceNC (pcgs, cpcgs);
	Assert (1, CanonicalPcgs (tmp) = CanonicalPcgs (InducedPcgsByGenerators (pcgs, cpcgs)),
		Error ("result is not a pcgs"));
	return tmp;
end);


#############################################################################
##
#F  Fact_NPartFunction
##
InstallGlobalFunction ("Fact_NPartFunction",
	function (res, n, canonical)
		local s, w, lhs, rhs, ldepths, perm, exp, r, i, j, ro, cf;
		s := Length (res.mpcgs);
		w := res.oneSolution + res.solutionSpace[n];
		lhs := List (res.mpcgs);
		rhs := List ([1..s], 
			i -> PcElementByExponents (res.npcgs, w{[i,i+s..i+(Length (res.npcgs)-1)*s]}));
		Append (lhs, res.npcgs);
		Append (rhs, res.npcgs);
		Append (lhs, res.nden);
		Append (rhs, ListWithIdenticalEntries (Length (lhs) - Length (rhs), 
			OneOfPcgs (res.npcgs)));
		ldepths := List (lhs, x -> DepthOfPcElement (res.pcgs, x));
		perm := Sortex (ldepths);
		lhs := Permuted (lhs, perm);
		rhs := Permuted (rhs, perm);
		Assert (1, IsSet (ldepths), Error ("depths do not form a set"));
		if canonical then
			ro := List (lhs, x -> RelativeOrderOfPcElement (res.pcgs, x));
			for i in [Length (lhs), Length (lhs)-1..1] do
				exp := ExponentsOfPcElement (res.pcgs, lhs[i]);
				cf := exp[ldepths[i]];
				if cf <> 1 then
					r := 1/cf mod ro[i];
					lhs[i] := lhs[i]^r;
					rhs[i] := rhs[i]^r;
					exp := ExponentsOfPcElement (res.pcgs, lhs[i]);
				fi;
				for j in [i+1..Length (lhs)] do
					cf := exp[ldepths[j]];
					if cf <> 0 then
						lhs[i] := lhs[i]/(lhs[j]^cf);
						rhs[i] := rhs[i]/(rhs[j]^cf);
						exp := ExponentsOfPcElement (res.pcgs, lhs[i]);
					fi;
				od;
				Assert (1, ForAll (ExponentsOfPcElement (res.pcgs, lhs[i]){ldepths{[i+1..Length (lhs)]}},
					x -> x = 0), Error ("not all depths are zero!"));
			od;
		fi;			
		return rec (mpartL := lhs, npartR := rhs, mDepths := ldepths);
	end);
				
			
#############################################################################
##
#F  Fact_SolutionFunction
##
InstallGlobalFunction ("Fact_SolutionFunction",
	function (res, i)
	
		local s, w, depth, len, gens;
		s := Length (res.mpcgs);
		gens := List (res.nden);
		w := res.oneSolution + res.solutionSpace[i];
		len := Length (gens);
		if not IsBound (res.denomDepths) then
			res.denomDepths := List (gens, x -> DepthOfPcElement (res.pcgs, x));
		fi;
		depth := ShallowCopy (res.denomDepths);
		
		for i in [1..s] do
			AddPcElementToPcSequence (res.pcgs, gens, depth,
				res.mpcgs[i] 
					* PcElementByExponents (res.npcgs, 
						w{[i,i+s..i+(Length (res.npcgs)-1)*s]}));
		od;
		gens := InducedPcgsByPcSequenceNC (res.pcgs, gens);

		Assert (1, CanonicalPcgs (gens) = CanonicalPcgs (InducedPcgsByGenerators (res.pcgs, gens)),
			Error ("gens is not a pc sequence"));
		return gens;
		
	end);


#############################################################################
##
#F  Fact_SolutionFunction_TrivialC
##
InstallGlobalFunction ("Fact_SolutionFunction_TrivialC",
	function (res, i)
		return res.nden;
	end);


#############################################################################
##
#F  Fact_NPartFunction_TrivialC
##
InstallGlobalFunction ("Fact_NPartFunction_TrivialC",
	function (res, n, canonical)
		local pcgs;
		if canonical then
			pcgs := CanonicalPcgs (res.mnum);
		else
			pcgs := res.mnum;
		fi;
		return rec (mpartL := pcgs, npartR := pcgs,
			mDepths := List (pcgs, x -> DepthOfPcElement (res.pcgs, x)));
	end);
			

#############################################################################
##
#F  ExtendedPcgsComplementsOfCentralModuloPcgsUnderAction (
##		<aut>, <pcgs>, <gpcgs>, <npcgs>, <kpcgs>, <all>)
##
InstallGlobalFunction (ExtendedPcgsComplementsOfCentralModuloPcgsUnderAction,
#	function (act, g, x, all)
#		return IsIdenticalObj (g,x);
#	end,
#	[IsList, IsModuloPcgs, IsModuloPcgs, IsBool], 0,
	function (act, pcgs, g, x, xden, all)

		local lin, id, beta, gamma, delta, c, d, e, field,
			sys, row, p, bas,
			i, j, k, l, r, s, n, y, exp, gens,
			depth, ddepth, len, dp, pos, res, t;
		
		t := Runtime();
				
		r := Length (act);
		
		s := Length (g);
				
		n := Length (x);
		Info (InfoComplement, 1, "complementing (bot =", n, ", top = ", s,
			", act = ", r,")");
			
		res := rec(pcgs := pcgs,
			mpcgs := g,
			npcgs := x,
			nden := xden);

		if n = 0 then
			Error ("<npcgs> must not be trivial");
		elif s = 0 then
			res.nrSolutions := 1;
			res.solutionFunction := Fact_SolutionFunction_TrivialC;
			res.nPartFunction := Fact_NPartFunction_TrivialC;
			Info (InfoComplement, 2, "trivial solution (s = 0)");
			Info (InfoComplement, 3, "time = ", Runtime() - t);
			return res;
		fi;
		
		# prepare a solution for the case when no complement exists
		res.nrSolutions := 0;
		res.solutionFunction := ReturnFail;
		
		# now set up a linear system
		# g[i] is multiplied by x[1]*t[i]+x[2]*t[i+s]+..x[n]*t[i+(n-1)*s]
		# where t is a solution of the equation system
		
		field := GF(RelativeOrderOfPcElement (x, x[1]));
		sys:= LinearSystem (n*s, 1, field, n*s > 20, false);
		
			
		Info (InfoComplement, 2, "computing action on N");
		
		e := [];
		
		for i in [1..s] do
	
			p := RelativeOrderOfPcElement (g, g[i]);
			y := g[i]^p;
			exp := ExponentsOfPcElement (g, y);
			y := LeftQuotient (PcElementByExponents (g, exp), y);
			Assert (1, y in Group (NumeratorOfModuloPcgs(x)), Error ("g[i]^p/... must be in N"));
			exp[i] := - p;
			gamma := exp * One (field);
			c := ExponentsOfPcElement (x, y) * One(field);
			
			for k in [1..n] do
				row := ShallowCopy (sys.nullrow);
				row{[(k-1)*s+1..k*s]} := gamma;
				if not AddEquation (sys, row, [c[k]]) then
					Info (InfoComplement, 2, "no solution");
					Info (InfoComplement, 3, "time = ", Runtime() - t);
					return res;
				fi;
			od;
			
			for j in [1..i-1] do
				y := g[i]^g[j]; # was Comm (g[i], g[j]);
				exp := ExponentsOfPcElement (g, y);
				y := LeftQuotient (PcElementByExponents (g, exp), y);
				Assert (1, y in Group (Concatenation (x, xden)), Error ("Comm (g[i], g[j])/... must be in N"));
				exp[i] := exp[i]-1;
				gamma := exp * One (field);
				c := ExponentsOfPcElement (x, y) * One(field);

				for k in [1..n] do
					row := ShallowCopy (sys.nullrow);
					row{[(k-1)*s+1..k*s]} := gamma;
					if not AddEquation (sys, row, [c[k]]) then
						Info (InfoComplement, 2, "no solution");
						Info (InfoComplement, 3, "time = ", Runtime() - t);
						return res;
					fi;
				od;
			od;
				
			for j in [1..r] do
				if not IsBound (e[j]) then
					e[j] := [];
					for l in [1..n] do
						y := x[l]^act[j];
						Assert (1, y in Group (Concatenation (x, xden)), Error ("x[l]^act[j] must be in N"));
						e[j][l] := ExponentsOfPcElement (x, y) * One(field);
					od;
				fi;
				
				y := g[i]^act[j];
				exp := ExponentsOfPcElement (g, y);
				delta := exp * One (field);
				y := LeftQuotient (PcElementByExponents (g, exp), y);
				Assert (1, y in Group (Concatenation (x, xden)), Error ("g[i]^act[j]/... must be in N"));
				d := ExponentsOfPcElement (x, y) * One(field);

				for k in [1..n] do
					row := ShallowCopy (sys.nullrow);
					row{[(k-1)*s+1..k*s]} := delta;
					
					for l in [1..n] do
						# this is what we really want:
						row[(l-1)*s+i] := row[(l-1)*s+i]-e[j][l][k];
						# row[(l-1)*s+i] := -e[j][l][k];
					od;
					
					# now fix the only entry in row that was nonzero before the loop
					# row[(k-1)*s+i] := delta[i] - e[j][k][k];
					
					if not AddEquation (sys, row, [d[k]]) then
						Info (InfoComplement, 2, "no solution");
						Info (InfoComplement, 3, "time = ", Runtime() - t);
						return res;
					fi;
				od;
			od;
		od;
		
		res.oneSolution := OneSolution (sys,1);
		res.nPartFunction := Fact_NPartFunction;
		res.solutionFunction := Fact_SolutionFunction;

		if all then
			bas := BasisNullspaceSolution (sys);
			res.solutionSpace := Enumerator(
				VectorSpace (field, bas, res.oneSolution*Zero(field)));
			res.nrSolutions := Size (field)^Length (bas);
			Info (InfoComplement, 2, res.nrSolutions, " solution(s) found");

		else # if we only want one solution, why bother computing the nullspace
			res.solutionSpace := [res.oneSolution*Zero(field)];
			res.nrSolutions := 1;
			Info (InfoComplement, 2, "one solution found (all = false)");
		fi;
		Info (InfoComplement, 3, "time = ", Runtime() - t);
		return res;
	end);


#############################################################################
##
#F  PcgsComplementsOfCentralModuloPcgsUnderActionNC (
##		<aut>, <pcgsnum>, <pcgs>, <mpcgs>, <pcgsdenum>, <all>)
##
InstallGlobalFunction (PcgsComplementsOfCentralModuloPcgsUnderActionNC,
#	function (act, g, x, all)
#		return IsIdenticalObj (g,x);
#	end,
#	[IsList, IsModuloPcgs, IsModuloPcgs, IsBool], 0,
	function (act, pcgs, g, x, xden, all)
		local res;
		res := ExtendedPcgsComplementsOfCentralModuloPcgsUnderAction(act, pcgs, g, x, xden, all);
		return List ([1..res.nrSolutions], 
				i -> res.solutionFunction (res, i));
	end);
	
#############################################################################
##
#F  PcgsNormalComplementsOfElAbModuloPcgsUnderAction (
##		<aut>, <pcgsnum>, <pcgs>, <mpcgs>, <pcgsdenum>, <all>)
##
InstallGlobalFunction ("PcgsNormalComplementsOfElAbModuloPcgsUnderAction",
#	function (act, g, x, all)
#		return IsIdenticalObj (g,x);
#	end,
#	[IsList, IsPcgs, IsModuloPcgs, IsModuloPcgs, IsPcgs, IsBool], 0,
	function (act, pcgs, g, x, xden, all)

		if CentralizesLayer (g, x) then
			return PcgsComplementsOfCentralModuloPcgsUnderActionNC (
				act, pcgs, g, x, xden, all);
		else
			return [];
		fi;
	end);
	

#############################################################################
##
#M  ComplementsOfCentralSectionUnderActionNC (<aut>,<G>,<N>,<L>,<all>)
##
##  version where <aut> is a list of maps G -> G (which are supposed to
##  induce automorphisms on G/L)
##
InstallMethod (ComplementsOfCentralSectionUnderActionNC,
    "for section and list of objects acting via ^",
	function (famact, famG, famN, famL, famall)
		return IsIdenticalObj (famG, famN) and IsIdenticalObj (famN, famL) ;
	end,
	[IsList, IsGroup, IsGroup, IsGroup, IsBool], 0,
	function (act, G, N, L, all)

		local cpcgs, res, pcgs, pcgsL;
		
		pcgs := ParentPcgs (Pcgs (G));
		pcgsL:= InducedPcgs (pcgs, L);
		cpcgs := PcgsComplementsOfCentralModuloPcgsUnderActionNC (
			act, pcgs, ModuloPcgs (G, N), ModuloPcgs (N, L), pcgsL, all);
		
		res := List (cpcgs, c -> GroupOfPcgs (c));
		
		Assert (2, ForAll (res, C ->
			IsNormal (G, C) 
				and NormalIntersection (C, N) = L 
				and Index (G, C) * Index (G, N) = Index (G, L)
				and ForAll (act, a -> Image (a, C) = C)),
			Error ("wrong normal complement(s)"));
		if all then
			return res;
		else
			if Length (res) > 0 then
				return res[1];
			else
				return fail;
			fi;
		fi;
	end);


#############################################################################
##
#M  ComplementsOfCentralSectionUnderActionNC
##
InstallMethod (ComplementsOfCentralSectionUnderActionNC,
	"group acts on section",
	function (famact, famG, famN, famL, famall)
		return IsIdenticalObj (famG, famN) and IsIdenticalObj (famN, famL);
	end,
	[IsGroup, IsGroup, IsGroup, IsGroup, IsBool], 0,
	function (act, G, N, L, all)
		return ComplementsOfCentralSectionUnderActionNC (
			GeneratorsOfGroup (act), G, N, L, all);
	end);


#############################################################################
##
#F  ComplementsOfCentralSectionUnderAction
##
InstallGlobalFunction ("ComplementsOfCentralSectionUnderAction",
	function (act, G, N, L, all)
		
		if ForAll (GeneratorsOfGroup (G), g ->
			ForAll (GeneratorsOfGroup (N), n -> Comm (g, n) in L)) then
				return ComplementsOfCentralSectionUnderActionNC (
					act, G, N, L, all);
		else
			Error ("G must centralize N/L");
		fi;
	end);
	
	
#############################################################################
##
#M  NormalComplementsOfElAbSectionUnderAction (<aut>,<G>,<N>,<L>,<all>)
##
##  version where <aut> is a list of maps G -> G (which are supposed to
##  induce automorphisms on G/L)
##
InstallMethod (NormalComplementsOfElAbSectionUnderAction,
    "for section and list of automorphisms",
	function (famact, famG, famN, famL, famall)
		return IsIdenticalObj (famG, famN) and IsIdenticalObj (famN, famL);
	end,
	[IsList, IsGroup, IsGroup, IsGroup, IsBool], 0,
	function (act, G, N, L, all)

		local cpcgs, res, pcgs, pcgsL;
		
		pcgs := ParentPcgs (Pcgs(G));
		pcgsL := InducedPcgs (pcgs, L);
		
		cpcgs := PcgsNormalComplementsOfElAbModuloPcgsUnderAction (
			act, pcgs, ModuloPcgs (G, N), ModuloPcgs (N, L), pcgsL, all);
		
		res := List (cpcgs, c -> SubgroupByPcgs (G, c));
		
		if res = fail then
			res := [];
		fi;
		
		Assert (2, ForAll (res, C ->
			IsNormal (G, C) 
				and NormalIntersection (C, N) = L 
				and Index (G, C) * Index (G, N) = Index (G, L)
				and ForAll (act, a -> Image (a, C) = C)),
			Error ("wrong normal complement(s)"));
		if all then
			return res;
		else
			if Length (res) > 0 then
				return res[1];
			else
				return fail;
			fi;
		fi;
	end);


#############################################################################
##
#M  NormalComplementsOfElAbSectionUnderAction
##
InstallMethod (NormalComplementsOfElAbSectionUnderAction,
	"group acts on section",
	function (famact, famG, famN, famL, famall)
		return IsIdenticalObj (famG, famN) and IsIdenticalObj (famN, famL);
	end,
	[IsGroup, IsGroup, IsGroup, IsGroup, IsBool], 0,
	function (act, G, N, L, all)
		return NormalComplementsOfElAbSectionUnderAction (
			GeneratorsOfGroup (act), G, N, L, all);
	end);


#############################################################################
##
#F  ComplementsMaximalUnderAction (G, ser, i, j, k, all) 
## 
##  computes subgroups C of ser[i] such that C/ser[k] is a G-invariant complement 
##  of ser[j]/ser[k] in ser[i]/ser[k].
##  
##  ser[k]/ser[k] < ser[k-1]/ser[k] < ... < ser[j]/ser[k] < U/ser[k] 
##  must be a G-composition of U/ser[k], and U must be a subgroup of G.
##  If all is true, it returns a list containing all such C.
##  Otherwise it returns one C if it exists, or fail if no such C exists. 
##
InstallGlobalFunction ("ComplementsMaximalUnderAction",
	function (G, ser, i, j, k, all)

		local p, res, newser, l, pcgs;
		
		if i >+ j or j >= k  then
			Error( "<j> must be smaller than <k>" );
		fi;

		newser := [PcgsElementaryAbelianSeries (ser[i])];
		pcgs := ParentPcgs (newser[1]);
		for l in [i+1..k] do
			Add (newser, InducedPcgs (pcgs, ser[l]));
		od;
		
		res := PcgsComplementsMaximalUnderAction (
			List (SmallGeneratingSet (G), x -> InnerAutomorphismNC (G,x)), 
			pcgs, newser[1], newser, j-i+1, k-i+1, all);
		
		if all then
			return List (res, GroupOfPcgs);
		elif IsEmpty (res) then
			return fail;
		else
			return GroupOfPcgs (res[1]);
		fi;
	end);
	
		
###################################################################################
##
#F  PcgsComplementsMaximalUnderAction 
##
##  does the nontrivial work for ComplementsMaximalUnderAction
##
InstallGlobalFunction ("PcgsComplementsMaximalUnderAction",
	function (act, pcgs, U, ser, j, k, all)
	
		local top, bot, CC, p, q, gens, x, y, res;
			
		# first compute complements modulo ser[j+1]
	
		top  := U mod ser[j];
		bot  := ser[j] mod ser[j+1];
		
		CC := []; # assume that there are no complements
		
		if CentralizesLayer(top, bot) then 
			p := RelativeOrderOfPcElement (top,top[1]);
			q := RelativeOrderOfPcElement (bot, bot[1]);
			if p <> q then # coprime case
				CC := [InducedPcgsByPcSequenceAndGenerators (pcgs, ser[j+1],
						List (top, x -> x^q))];
	
			elif ForAll (top, x-> SiftedPcElement (ser[j+1], x^p) = OneOfPcgs (pcgs)) then  # U/ser[j+1] is an elementary abelian  p-group
				CC := PcgsComplementsOfCentralModuloPcgsUnderActionNC (act, pcgs, top, bot, ser[j+1], all or j+1 < k);
			fi; # else U/ser[j+1] has exponent p^2, so no complement exists
		fi;
	
		Info (InfoComplement, 1, " depth ",k-j-1," ", Length (CC), " complements found");
	
		if j+1 = k then # we are done
			return CC;
		else # recurse		
			return Concatenation (List (CC, 
				C -> PcgsComplementsMaximalUnderAction (act, pcgs, C, ser, j+1, k, true)));
		fi;
	end);
		
			


