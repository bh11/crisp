#############################################################################
##
##  solveeq.gi                      CRISP                 Burkhard H\"ofling
##
##  @(#)$Id$
##
##  Copyright (C) 2000 by Burkhard H\"ofling, Mathematisches Institut,
##  Friedrich Schiller-Universit\"at Jena, Germany
##
Revision.solveeq_gi :=
    "@(#)$Id$";


#############################################################################
##
#F  LinearSystem (nrvars, nrsolutions, field, conv, convsol)
##
InstallGlobalFunction (LinearSystem,
	function (nrvars, nrsolutions, field, conv, convsol)

		local sys, i;
			
		sys := rec(
			nrvars := nrvars,
			nrsolutions := nrsolutions,
			field := field,
			fieldsize := Size (field),
			zero := Zero (field),
			one := One (field),
			equations := [],
			solutions := [],
			solvable := ListWithIdenticalEntries (nrsolutions,true),
			conv := conv,
			convsol := convsol);
		if conv then
			sys.nullrow := ListWithIdenticalEntries (
				sys.nrvars, sys.zero);
		else
			sys.nullrow := [];
			for i in [1..sys.nrvars] do
				sys.nullrow[i] := sys.zero;
			od;
		fi;
		if convsol then
			sys.nullsol := ListWithIdenticalEntries (
				sys.nrsolutions, sys.zero);
		else
			sys.nullsol := [];
			for i in [1..sys.nrsolutions] do
				sys.nullsol[i] := sys.zero;
			od;
		fi;
			
		return sys;
	end);


#############################################################################
##
#F  AddEquation (sys, row, sol)
##
InstallGlobalFunction (AddEquation,
	 function (sys, row, sol)

		local i, solv, oldsolv, coeff;
		
		if Length (row) <> sys.nrvars or Length (sol) <> sys.nrsolutions 
				or (sys.conv and sys.fieldsize <> ConvertToVectorRep (row, sys.fieldsize)) 
				or (sys.convsol and sys.fieldsize <> ConvertToVectorRep (sol, sys.fieldsize)) then
			Error ("vectors must be of the right length and over the correct field");
		fi;
		
		i := 1;
		while  i <= sys.nrvars do
			coeff := row[i];
			if coeff <> sys.zero then
				if IsBound (sys.equations[i]) then
					# row := row - row[i] * sys.equations[i];
					AddRowVector (row, sys.equations[i], - coeff);
					AddRowVector (sol, sys.solutions[i], - coeff);
				elif coeff = sys.one then
					sys.equations[i] := row;
					sys.solutions[i] := sol;
					return true;
				else
					sys.equations[i] := row / coeff;
					sys.solutions[i] := sol / coeff;
					return true;
				fi;
			fi;
			i := i + 1;
		od;
		
		solv := true;
		for i in [1..sys.nrsolutions] do
			if sys.solvable[i] and sol[i] <> sys.zero then
				sys.solvable[i] := false;
				solv := false;
			fi;
		od;

		return solv;
	end);


#############################################################################
##
#F  OneSolution (sys, n)
##
InstallGlobalFunction (OneSolution, 
	function (sys, n)

		local s, i;
		
		if not sys.solvable[n] then
			return fail;
		fi;
		
		s := ShallowCopy (sys.nullrow);
		
		for i in [sys.nrvars, sys.nrvars-1..1] do 
			# treat the i-th row   
			if IsBound (sys.equations[i]) then
				s[i] := sys.solutions[i][n] - s*sys.equations[i];
			fi;
		od;
				
		return s;
	end);


#############################################################################
##
#F  BasisNullspaceSolution (sys)
##
InstallGlobalFunction (BasisNullspaceSolution,

	function (sys)

		local v, i, j, basis;
		
		if IsBound (sys.nullspace) then
			return sys.nullspace;
		fi;
		
		sys.nullspace := [];
		
		for i in [sys.nrvars, sys.nrvars-1..1] do 
			# treat the i-th row   
			if not IsBound (sys.equations[i]) then
				v := ShallowCopy (sys.nullrow);
				v[i] := sys.one;
				for j in [i-1, i-2 .. 1] do
					if IsBound (sys.equations[j]) then
						v[j] := - v * sys.equations[j];
					fi;
				od;
				Add (sys.nullspace, v{[1..sys.nrvars]});
			fi;
		od;
		return sys.nullspace;
	end);

  
############################################################################
##
#E
##
