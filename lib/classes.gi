#############################################################################
##
##  classes.gi                       CRISP                 Burkhard H\"ofling
##
##  @(#)$Id$
##
##  Copyright (C) 2000 by Burkhard H\"ofling, Mathematisches Institut,
##  Friedrich Schiller-Universit\"at Jena, Germany
##
Revision.classes_gi :=
    "@(#)$Id$";


#############################################################################
##
#M  \in
##
##  tests whether <obj> belongs to the class <class>. A class representation
##  should install a method for `IsMemberOp', rather than \in, so that the 
##  result of the membership test can be stored in <obj>.
##
InstallMethod (\in, " nonempty class, delegate to IsMember", true, 
	[IsObject, IsClass and IsNonEmpty], 0, 
	function (x, C)
		return IsMember (x, C);
	end);


#############################################################################
##
#M  \in
##
InstallMethod (\in, " nonempty class, delegate to IsMember", true, 
	[IsObject, IsClass and IsEmpty], 0, 
	ReturnFalse);


#############################################################################
##
#M  \in
##
##  tests whether <obj> belongs to the class <class>. A class representation
##  should install a method for `IsMemberOp', rather than \in, so that the 
##  result of the membership test can be stored in <obj>.
##
InstallMethod (\in, " for class, delegate to IsMember", true, 
	[IsObject, IsClass], 0, 
	function (x, C)
		local res;
		res := IsMember (x, C);
  if res then
			SetIsNonEmpty (C, true);
		fi;
		return res;
	end);


#############################################################################
##
#V  CLASS_ID_COUNT
##
##  used to assign a unique id to each new class generated with `NewClass'
##  this is required when attributes depending on a class are to be stored
##  using `KeyDependentOperation' because they need to be sortable via `<'
##
BindGlobal ("CLASS_ID_COUNT", 0);


#############################################################################
##
#F  NewClass (<fam/name>, <rep>, <data>)
##
##  generates a new class with unique class id, belonging to the filter rep
##
InstallGlobalFunction (NewClass, function (famname, rep, data)

	local fam;
	
	MakeReadWriteGlobal ("CLASS_ID_COUNT");
	CLASS_ID_COUNT := CLASS_ID_COUNT + 1;
	MakeReadOnlyGlobal ("CLASS_ID_COUNT");
	
	if IsString (famname) then
		fam := NewFamily (famname);
	else
		fam := famname;
	fi;
	fam!.classId := CLASS_ID_COUNT;
	return Objectify (NewType (fam, rep), data);
end);


#############################################################################
##
#F  InstallDefiningAttributes (<cls>, <rec>)  . . . . . . . . . . . . . local
##
InstallGlobalFunction ("InstallDefiningAttributes",
	function (class, record)
	
		local r, f, undef;

		r := ShallowCopy (record);
		undef := true;
		
		if IsBound (r.name) then
			SetName (class, r.name);
			Unbind (r.name);
		fi;
		
		for f in class!.definingAttributes do
			if IsBound (r.(f[1])) then
				Setter (f[2]) (class, r.(f[1]));
				Unbind (r.(f[1]));
				undef := false;
			fi;
		od;
		if undef then
			Error ("The record components do not define <class>.");
		fi;
		if not IsEmpty (RecNames (r)) then
			Error ("The components ", RecNames(r), " of r could not be used");
		fi;
	end);
	

#############################################################################
##
#F  ViewDefiningAttributes (<cls>) . . . . . . . . . . . . . . . . . . local
##
InstallGlobalFunction ("ViewDefiningAttributes",

	function (C)
	
		local sep, a;
		
		sep := false;
		
		for a in C!.definingAttributes do
			if Tester (a[2])(C) then
				if sep then
					Print (", ");
				else
					sep := true;
				fi;
				Print (a[1], "=");
				View (a[2](C));
			fi;
		od;
		if not sep then
			Print ("<undefined>");
		fi;
	end);


#############################################################################
##
#F  PrintDefiningAttributes (<cls>) . . . . . . . . . . . . . . . . . . local
##
InstallGlobalFunction ("PrintDefiningAttributes",

	function (C)
	
		local sep, a;
		
		sep := false;

		Print ("rec ( ");
		for a in C!.definingAttributes do
			if Tester (a[2])(C) then
				if sep then
					Print (", \n");
				else
					sep := true;
				fi;
				Print (a[1], " = ", a[2](C));
			fi;
		od;
		if not sep then
			Print ("<undefined>");
		fi;
		Print (")");
	end);


#############################################################################
##
#M  \< 
##
InstallMethod (\<, "for classes", true, [IsClass, IsClass], 0,
	function (C, D)
		return FamilyObj (C)!.classId < FamilyObj (D)!.classId;
	end);
	
	
#############################################################################
##
#M  \=
##
InstallMethod (\=, "for classes", true, [IsClass, IsClass], 0,
	function (C, D)
		return FamilyObj (C)!.classId = FamilyObj (D)!.classId;
	end);
	
	
#############################################################################
##
#R  IsClassByPropertyRep (<func>)
##
##  contains classes defined by a function f, consisting of all elements 
##  for which f returns true
##
DeclareRepresentation ("IsClassByPropertyRep", 
	IsClass and IsComponentObjectRep and IsAttributeStoringRep, 
	["definingAttributes"]);


#############################################################################
##
#M  Class (<func>)
##
##  returns the class consisting of all elements for which func returns true
##
InstallMethod (Class, " defined by property function", true, [IsFunction], 0, 
	function (prop) 
		local res;
		res := NewClass ("class family", IsClassByPropertyRep, 
			rec(definingAttributes := [
				["in", MemberFunction]]));
		InstallDefiningAttributes (res, rec(\in := prop));
		return res;
	end); 


#############################################################################
##
#M  ViewObj
##
InstallMethod (ViewObj, "for IsClassByPropertyRep", true, 
	[IsClassByPropertyRep], 0,
	function (C) 
		local sep;
		Print ("Class (");
		ViewDefiningAttributes (C);		
		Print (")");
	end);


#############################################################################
##
#M  PrintObj
##
InstallMethod (PrintObj, " for IsClassByPropertyRep", true, 
	[IsClassByPropertyRep], 0,
	function (C) 
		Print ("Class (");
		PrintDefiningAttributes (C);
		Print (")");
	end);


#############################################################################
##
#M  IsMemberOp
##
InstallMethod (IsMemberOp, " for class with member function", true, 
	[IsObject, IsClassByPropertyRep and HasMemberFunction], SUM_FLAGS, 
		# raise priority so that MemberFunction is preferred over other 
		# methods trying to do without MemberFunction
	function (x, C)
		return MemberFunction (C)(x);
	end);


#############################################################################
##
#R  IsClassByComplementRep (<cl>)
##
##  classes which are defined as complements of other classes
##
DeclareRepresentation ("IsClassByComplementRep", 
	IsClass and IsComponentObjectRep and IsAttributeStoringRep, 
	["complement"]);


#############################################################################
##
#M  Complement (<cl>)
##
InstallMethod (Complement, "for a class", true, [IsClass], 0, 
	function (C) 
		return NewClass ("class complement fam", IsClassByComplementRep,
			rec (complement := C));
	end);


#############################################################################
##
#M  Complement (<cl>)
##
InstallMethod (Complement, "for a class complement", true, 
	[IsClassByComplementRep], 0, 
	function (C) 
		return C!.complement;
	end);


#############################################################################
##
#M  Complement (<list>)
##
InstallMethod (Complement, "for a list/collection", true, [IsListOrCollection], 0, 
	function (list) 
		return NewClass ("class complement fam", IsClassByComplementRep,
			rec (complement := list));
	end);


#############################################################################
##
#M  ViewObj
##
InstallMethod (ViewObj, "for IsClassByComplementRep", true, 
	[IsClassByComplementRep], 0,
	function (C) 
		Print ("Complement (");
		View (C!.complement);
		Print (")");
	end);


#############################################################################
##
#M  PrintObj
##
InstallMethod (PrintObj, " for IsClassByComplementRep", true, 
	[IsClassByComplementRep], 0,
	function (C) 
		Print ("Complement (");
		Print (C!.complement);
		Print (")");
	end);


#############################################################################
##
#M  IsEmpty (<group class>)
##
InstallMethod (IsEmpty, "for generic group class", 
	true, [IsGroupClass], 0, 
	function (C)
		Error ("Sorry, cannot decide if the group class <C> \
			is subgroup closed.");
	end);
	
	
#############################################################################
##
#M  IsEmpty (<group class>)
##
InstallMethod (IsEmpty, "for generic group class", 
	true, [IsGroupClass and IsNonEmpty], 0, 
	function (C)
		return false;
	end);
	
	
#############################################################################
##
#M  IsNonEmpty (<group class>)
##
InstallMethod (IsNonEmpty, "for generic group class", 
	true, [IsGroupClass], 0, 
	function (C)
		Error ("Sorry, cannot decide if the group class <C> \
			is subgroup closed.");
	end);
	
	
#############################################################################
##
#M  IsNonEmpty (<group class>)
##
InstallMethod (IsNonEmpty, "for generic group class", 
	true, [IsGroupClass and IsEmpty], 0, 
	function (C)
		return false;
	end);
	
	
#############################################################################
##
#M  \in
##
InstallMethod (\in, " for IsClassByComplementRep", true, 
	[IsObject, IsClassByComplementRep], 0, 
	function (x, C)
		return not x in C!.complement;
	end);


#############################################################################
##
#M  \in
##
InstallMethod (\in, " for an empty class", true, 
	[IsObject, IsClass and IsEmpty], 0, 
	function (x, C)
		return false;
	end);


#############################################################################
##
#R  IsClassByIntersectionRep (<cl>)
##
##  classes which are defined as intersections of other classes
##
DeclareRepresentation ("IsClassByIntersectionRep", 
	IsClass and IsComponentObjectRep and IsAttributeStoringRep, 
	["intersected"]);


#############################################################################
##
#M  ViewObj
##
InstallMethod (ViewObj, "for IsClassByIntersectionRep", true, [IsClassByIntersectionRep], 0,
	function (C) 
		Print ("Intersection (");
		View (C!.intersected);
		Print (")");
	end);


#############################################################################
##
#M  PrintObj
##
InstallMethod (PrintObj, " for IsClassByIntersectionRep", true, 
	[IsClassByIntersectionRep], 0,
	function (C) 
		Print ("Intersection (");
		Print (C!.intersected);
		Print (")");
	end);


#############################################################################
##
#M  \in
##
InstallMethod (\in, " for IsClassByIntersectionRep", true, 
	[IsObject, IsClassByIntersectionRep], 0, 
	function (x, C)
		return ForAll (C!.intersected, D -> x in D);
	end);


#############################################################################
##
#M  Intersection2
##
InstallMethod (Intersection2, " of two classes", true, 
	[IsClass, IsClass], 0, 
	function (C, D)
		return NewClass ("class intersection fam", IsClassByIntersectionRep,
			rec (intersected := [C,D]));
	end);


#############################################################################
##
#M  Intersection2
##
InstallMethod (Intersection2, " of class and class intersection", true, 
	[IsClass, IsClassByIntersectionRep], 0, 
	function (C, D)
		return NewClass ("class intersection fam", IsClassByIntersectionRep,
			rec (intersected := Concatenation (D!.intersected, [C])));
	end);


#############################################################################
##
#M  Intersection2
##
InstallMethod (Intersection2, " of class and class intersection", true, 
	[IsClassByIntersectionRep, IsClass], 0, 
	function (C, D)
		return NewClass ("class intersection fam", IsClassByIntersectionRep,
			rec (intersected := Concatenation (C!.intersected, [D])));
	end);


#############################################################################
##
#M  Intersection2
##
InstallOtherMethod (Intersection2, " of class and list/coll", true, 
	[IsClass, IsListOrCollection], 0, 
	function (C, D)
		return Filtered (D, x -> x in C);
	end);


#############################################################################
##
#M  Intersection2
##
InstallOtherMethod (Intersection2, " of list/coll and class", true, 
	[IsListOrCollection, IsClass], 0, 
	function (C, D)
		return Filtered (C, x -> x in D);
	end);


#############################################################################
##
#R  IsClassByUnionRep (<cl>)
##
##  classes which are defined as intersections of other classes
##
DeclareRepresentation ("IsClassByUnionRep", 
	IsClass and IsComponentObjectRep and IsAttributeStoringRep, 
	["united"]);


#############################################################################
##
#M  ViewObj
##
InstallMethod (ViewObj, "for IsClassByUnionRep", true, [IsClassByUnionRep], 0,
	function (C) 
		Print ("Union (");
		View (C!.united);
		Print (")");
	end);


#############################################################################
##
#M  PrintObj
##
InstallMethod (PrintObj, " for IsClassByUnionRep", true, 
	[IsClassByUnionRep], 0,
	function (C) 
		Print ("Union (");
		Print (C!.united);
		Print (")");
	end);


#############################################################################
##
#M  \in
##
InstallMethod (\in, " for IsClassByUnionRep", true, 
	[IsObject, IsClassByUnionRep], 0, 
	function (x, C)
		return ForAny (C!.united, D -> x in D);
	end);


#############################################################################
##
#M  Union2
##
InstallMethod (Union2, " of two classes", true, 
	[IsClass, IsClass], 0, 
	function (C, D)
		return NewClass ("class intersection fam", IsClassByUnionRep,
			rec (united := [C,D]));
	end);


#############################################################################
##
#M  Union2
##
InstallMethod (Union2, " of class and class union", true, 
	[IsClass, IsClassByUnionRep], 0, 
	function (C, D)
		return NewClass ("class intersection fam", IsClassByUnionRep,
			rec (united := Concatenation (D!.united, [C])));
	end);


#############################################################################
##
#M  Union2
##
InstallMethod (Union2, " of class and class union", true, 
	[IsClassByUnionRep, IsClass], 0, 
	function (C, D)
		return NewClass ("class intersection fam", IsClassByUnionRep,
			rec (united := Concatenation (C!.united, [D])));
	end);


#############################################################################
##
#M  Union2
##
InstallOtherMethod (Union2, " of class and list/coll", true, 
	[IsClass, IsListOrCollection], 0, 
	function (C, D)
		return NewClass ("class intersection fam", IsClassByIntersectionRep,
			rec (united := [C,D]));
	end);


#############################################################################
##
#M  Union2
##
InstallOtherMethod (Union2, " of list and class", true, 
	[IsListOrCollection, IsClass], 0, 
	function (C, D)
		return NewClass ("class intersection fam", IsClassByUnionRep,
			rec (united := [C,D]));
	end);


#############################################################################
##
#M  Difference
##
InstallMethod (Difference, "for two classes", true, 
	[IsClass, IsListOrCollection], 0, 
	function (C, D)
		return Intersection (C, Complement (D));
	end);


#############################################################################
##
#M  Difference
##
InstallOtherMethod (Difference, "for list  and class", true, 
	[IsList, IsClass], 0, 
	function (C, D)
		return Filtered (C, x -> not x in D);
	end);


#############################################################################
##
#M  Difference
##
InstallOtherMethod (Difference, "for collection and class", true, 
	[IsCollection, IsClass], 0, 
	function (C, D)
		return Intersection (C, Complement (D));
	end);


#############################################################################
##
#E
##
