#############################################################################
##
##  grpclass.gi                      CRISP                 Burkhard H\"ofling
##
##  @(#)$Id$
##
##  Copyright (C) 2000 by Burkhard H\"ofling, Mathematisches Institut,
##  Friedrich Schiller-Universit\"at Jena, Germany
##
Revision.grpclass_gi :=
    "@(#)$Id$";


#############################################################################
##
#M  GroupClass
##
InstallMethod (GroupClass, "for record", true, [IsRecord], 0, 
	function (record)
		local res, r;
		r := ShallowCopy (record);
		res := NewClass ("ClassFamily", IsClassByPropertyRep and IsGroupClass, 
			rec(definingAttributes := [
				["in", MemberFunction], 
                ["char", Characteristic]]));
        if IsBound (r.char) then
        	SetCharacteristic (res, r.char);
        	Unbind (r.char);
        fi;
		InstallDefiningAttributes (res, r);
		return res;
	end);


#############################################################################
##
#M  GroupClass
##
InstallMethod (GroupClass, " for property function", true, [IsFunction], 0, 
	function (prop)
		return GroupClass (rec (\in := prop));
	end);


#############################################################################
##
#M  \in
##
InstallMethod (\in, " for class by property", true, 
	[IsObject, IsGroupClass and HasMemberFunction], 0, 
	function (x, C)
		return IsGroup (x) and IsMember (x, C);
	end);


#############################################################################
##
#M  ViewObj
##
InstallMethod (ViewObj, " for IsGroupClass and IsClassByPropertyRep", true, 
	[IsGroupClass and IsClassByPropertyRep], 0,
	function (C) 
		Print ("GroupClass (");
		ViewDefiningAttributes (C);
		Print (")");
	end);


#############################################################################
##
#M  PrintObj
##
InstallMethod (PrintObj, " for IsGroupClass and IsClassByPropertyRep", true, 
	[IsGroupClass and IsClassByPropertyRep], 0,
	function (C) 
		Print ("GroupClass (");
		PrintDefiningAttributes (C);
		Print (")");
	end);


#############################################################################
##
#M  Complement (<cl>)
##
InstallMethod (Complement, "for a group class", true, [IsGroupClass], 0, 
	function (C) 
		return NewClass ("class complement fam", 
			IsClassByComplementRep and IsGroupClass,
			rec (complement := C));
	end);


#############################################################################
##
#M  Intersection2
##
##  it should not be necessary to install methods for intersections
##  other than the ones following below. 
##
InstallMethod (Intersection2, " of two classes", true, 
	[IsGroupClass, IsGroupClass], 0, 
	function (C, D)
		local new, c;
		new :=  NewClass ("class intersection fam", 
			IsClassByIntersectionRep and IsGroupClass,
			rec (intersected := [C,D]));
		for c in ClosureProperties do
			if Tester (c)(C) and Tester (c) (D) and c(C) and c(D) then
				Setter (c) (new, true);
			fi;
		od;
		return new;
	end);


#############################################################################
##
#M  Intersection2
##
InstallMethod (Intersection2, " of grp class and grp class intersection", true, 
	[IsGroupClass, IsClassByIntersectionRep and IsGroupClass], 0, 
	function (C, D)
		local new, c;
		new := NewClass ("class intersection fam", 
			IsClassByIntersectionRep and IsGroupClass,
			rec (intersected := Concatenation (D!.intersected, [C])));
		for c in ClosureProperties do
			if Tester (c)(C) and Tester (c) (D) and c(C) and c(D) then
				Setter (c) (new, true);
			fi;
		od;
		return new;
	end);


#############################################################################
##
#M  Intersection2
##
InstallMethod (Intersection2, " of grp class and grp class intersection", true, 
	[IsClassByIntersectionRep and IsGroupClass, IsGroupClass], 0, 
	function (C, D)
		local new, c;
		new :=  NewClass ("class intersection fam", 
			IsClassByIntersectionRep and IsGroupClass,
			rec (intersected := Concatenation (C!.intersected, [D])));
		for c in ClosureProperties do
			if Tester (c)(C) and Tester (c) (D) and c(C) and c(D) then
				Setter (c) (new, true);
			fi;
		od;
		return new;
	end);
	

#############################################################################
##
#M  Union2
##
InstallMethod (Union2, " of two grp classes", true, 
	[IsGroupClass, IsGroupClass], 0, 
	function (C, D)
		return NewClass ("class intersection fam", IsClassByUnionRep,
			rec (united := [C,D]));
	end);


#############################################################################
##
#M  Union2
##
InstallMethod (Union2, " of grp class and grp class union", true, 
	[IsGroupClass, IsClassByUnionRep and IsGroupClass], 0, 
	function (C, D)
		return NewClass ("class intersection fam", 
			IsClassByUnionRep and IsGroupClass,
			rec (united := Concatenation (D!.united, [C])));
	end);


#############################################################################
##
#M  Union2
##
InstallMethod (Union2, " of grp class and grp class union", true, 
	[IsClassByUnionRep and IsGroupClass, IsGroupClass], 0, 
	function (C, D)
		return NewClass ("class intersection fam", 
			IsClassByUnionRep and IsGroupClass,
			rec (united := Concatenation (C!.united, [D])));
	end);


#############################################################################
##
#R IsGroupClassByListRep
##
DeclareRepresentation ("IsGroupClassByListRep", 
	IsClass and IsGroupClass, ["list", "isofunc"]);


#############################################################################
##
#M  GroupClass
##
InstallOtherMethod (GroupClass, "for group defined by list", true, 
	[IsList], 0, 
	function (l) 
		return GroupClass (l, function (G, H) return IsomorphismGroups(G, H) <> fail;end);
	end);


#############################################################################
##
#M  GroupClass
##
InstallOtherMethod (GroupClass, " for list and function", true, 
	[IsList, IsFunction], 0, 
	function (l, iso) 
		local res;
		res := NewClass ("group class fam", IsGroupClassByListRep,
			rec (list := l, 
				isofunc := iso));
		SetIsGroupClass (res, true);
		return res;
	end);


#############################################################################
##
#M  IsMemberOp
##
InstallMethod (IsMemberOp, " for group class by list", true, 
	[IsObject, IsGroupClassByListRep], 0, 
	function (x, C)
		if IsGroup (x) then
			return ForAny (C!.list, y -> C!.isofunc (y, x));
		else
			return false;
		fi;
	end);


#############################################################################
##
#M  ViewObj
##
InstallMethod (ViewObj, " for IsGroupClassByListRep", true, [IsGroupClassByListRep], 0,
	function (C) 
		Print ("GroupClass (");
		View (C!.list);
		if C!.isofunc <> IsomorphismGroups then
			Print (", ");
			View (C!.isofunc);
		fi;
		Print (")");
	end);


#############################################################################
##
#M  PrintObj
##
InstallMethod (PrintObj, " for IsGroupClassByListRep", true, [IsGroupClassByListRep], 0,
	function (C) 
		Print ("GroupClass (");
		Print (C!.list);
		Print (", ");
		if C!.isofunc = IsomorphismGroups then
			Print (IsomorphismGroups);
		else
			Print (C!.isofunc);
		fi;
		Print (")");
	end);


#############################################################################
##
#M  Intersection2
##
InstallMethod (Intersection2, "for group class by list and group class", 
    true, [IsGroupClassByListRep, IsGroupClassByListRep], 0, 
	function (C, D)
		local res, iso;
		if C!.isofunc = IsomorphismGroups then
			iso := D!.isofunc;
		elif D!.isofunc = IsomorphismGroups then
			iso := C!.isofunc;
		elif C!.isofunc <> D!.isofunc then
			Info (InfoWarning ,1,
				"Don't know which isomorphism function to choose");
			iso := C!.isofunc;
		fi;
		
		res := GroupClass (Filtered (C!.list, x -> x in D), iso);
		
		return res;
	end);


#############################################################################
##
#M  Intersection2
##
InstallMethod (Intersection2, "for group class by list and group class", 
    true, [IsGroupClassByListRep, IsGroupClass], 0, 
	function (C, D)
		local res;
		res := GroupClass (Filtered (C!.list, x -> x in D), C!.isofunc);
		return res;
	end);


#############################################################################
##
#M  Intersection2
##
InstallMethod (Intersection2, "for grp class and group class by list",
	true, [IsGroupClass, IsGroupClassByListRep], 0, 
	function (C, D)
		local res;
		res :=  GroupClass (Filtered (D!.list, x -> x in C), D!.isofunc);
		return res;
	end);


#############################################################################
##
#M  Difference
##
InstallMethod (Difference, "for group class by list and group class", true, 
	[IsGroupClassByListRep, IsGroupClass], 0, 
	function (C, D)
		return GroupClass (Filtered (C!.list, x -> not x in D), C!.isofunc);
	end);


#############################################################################
##
#M  IsSubgroupClosed (<group class>)
##
InstallMethod (IsSubgroupClosed, "for generic group class", 
	true, [IsGroupClass], 0, 
	function (C)
		Error ("Sorry, cannot decide if the group class <C> \
			is subgroup closed.");
	end);
	
	
#############################################################################
##
#M  IsNormalSubgroupClosed (<group class>)
##
InstallMethod (IsNormalSubgroupClosed, "for generic group class", 
	true, [IsGroupClass], 0, 
	function (C)
		Error ("Sorry, cannot decide if the group class <C> \
			is normal subgroup closed.");
	end);
	
	
#############################################################################
##
#M  IsQuotientClosed (<group class>)
##
InstallMethod (IsQuotientClosed, "for generic group class", 
	true, [IsGroupClass], 0, 
	function (C)
		Error ("Sorry, cannot decide if the group class <C> \
			is quotient closed.");
	end);
	
	
#############################################################################
##
#M  IsResiduallyClosed (<group class>)
##
InstallMethod (IsResiduallyClosed, "for generic group class", 
	true, [IsGroupClass], 0, 
	function (C)
		Error ("Sorry, cannot decide if the group class <C> \
			is residually closed.");
	end);
	
	
#############################################################################
##
#M  IsNormalProductClosed (<group class>)
##
InstallMethod (IsNormalProductClosed, "for generic group class", 
	true, [IsGroupClass], 0, 
	function (C)
		Error ("Sorry, cannot decide if the group class <C> \
			is closed under products of normal subgroups.");
	end);
	
	
#############################################################################
##
#M  IsDirectProductClosed (<group class>)
##
InstallMethod (IsDirectProductClosed, "for generic group class", 
	true, [IsGroupClass], 0, 
	function (C)
		Error ("Sorry, cannot decide if the group class <C> \
			is closed under direct products.");
	end);

	
#############################################################################
##
#M  IsSchunckClass (<group class>)
##
InstallMethod (IsSchunckClass, "for generic group class", 
	true, [IsGroupClass], 0, 
	function (C)
		Error ("Sorry, cannot decide if the group class <C> \
			is a Schunck class.");
	end);

	
#############################################################################
##
#P  IsSaturated (<group class>)
##
InstallMethod (IsSaturated, "for generic group class", 
	true, [IsGroupClass], 0, 
	function (C)
		Error ("Sorry, cannot decide if the group class <C> \
			is saturated.");
	end);

		
#############################################################################
##
#F  SetIsOrdinaryFormation (<group class>)
##
##  fake setter function
##
InstallGlobalFunction ("SetIsOrdinaryFormation", 
	function (C, b)
		if not IsGroupClass (C) or b <> true then
			Error ("<C> must be a group class and <b> must be true");
		fi;
		SetIsNonEmpty (C, b);
		SetIsQuotientClosed (C, b);
		SetIsResiduallyClosed (C, b);
	end);
	
	
#############################################################################
##
#F  SetIsFittingClass (<group class>)
##
##  fake setter function
##
InstallGlobalFunction ("SetIsFittingClass", 
	function (C, b)
		if not IsGroupClass (C) or b <> true then
			Error ("<C> must be a group class and <b> must be true");
		fi;
		SetIsNonEmpty (C, b);
		SetIsNormalSubgroupClosed (C, b);
		SetIsNormalProductClosed (C, b);
	end);

	
#############################################################################
##
#F  SetIsFittingFormation (<group class>)
##
##  fake setter function
##
InstallGlobalFunction ("SetIsFittingFormation", 
	function (C, b)
		if not IsGroupClass (C) or b <> true then
			Error ("<C> must be a group class and <b> must be true");
		fi;
		SetIsFittingClass (C, b);
		SetIsOrdinaryFormation (C, b);
	end);

	
#############################################################################
##
#F  SetIsSaturatedFormation (<group class>)
##
##  fake setter function
##
InstallGlobalFunction ("SetIsSaturatedFormation", 
	function (C, b)
		if not IsGroupClass (C) or b <> true then
			Error ("<C> must be a group class and <b> must be true");
		fi;
		SetIsOrdinaryFormation (C, b);
		SetIsSaturated (C, b);
	end);

	
#############################################################################
##
#F  SetIsSaturatedFittingFormation (<group class>)
##
##  fake setter function
##
InstallGlobalFunction  ("SetIsSaturatedFittingFormation", 
	function (C, b)
		if not IsGroupClass (C) or b <> true then
			Error ("<C> must be a group class and <b> must be true");
		fi;
		SetIsFittingFormation (C, b);
		SetIsSaturated (C, b);
	end);


#############################################################################
##
#M  Basis (<class>)
##
##  the basis of a group class <class> consists of the primitive soluble 
##  groups in <class>
##
InstallMethod (Basis, "for group class", true, 
	[IsGroupClass], 0,
	function (H)
		return GroupClass (G -> IsPrimitiveSolvable (G) and G in H);
	end);
	

#############################################################################
##
#M  Boundary
##
InstallMethod (Boundary, "for generic grp class", true, 
	[IsGroupClass], 0,
	function (H)
 		return GroupClass (G -> IsPrimitiveSolvable (G) 
 			and not G in H
 			and G/Socle(G) in H);
	end);
  

#############################################################################
##
#M  Characteristic
##
InstallMethod (Characteristic, "for generic grp class", true, 
	[IsGroupClass], 0,
	function (H)
 		return Class (p -> IsPrimeInt (p) and CyclicGroup (p) in H);
	end);


#############################################################################
##
#M  Characteristic
##
InstallMethod (Characteristic, "for group class intersection", true, 
	[IsGroupClass and IsClassByIntersectionRep], 0,
	function (H)
 		return Intersection (
 			List (H!.intersected, C -> Characteristic (C)));
	end);


#############################################################################
#E
##
