#############################################################################
##
##  grpclass.gd                      CRISP                 Burkhard H\"ofling
##
##  @(#)$Id$
##
##  Copyright (C) 2000 by Burkhard H\"ofling, Mathematisches Institut,
##  Friedrich Schiller-Universit\"at Jena, Germany
##
Revision.grpclass_gd :=
    "@(#)$Id$";


#############################################################################
##
#P  IsGroupClass
##
##  A class is a group classes if it consists of groups and is closed
##  under group isomorphisms
##
DeclareProperty ("IsGroupClass", IsClass);

#############################################################################
##
#M  IsGroupClass
##
InstallTrueMethod (IsGroupClass, IsEmpty and IsClass);


#############################################################################
##
#O  GroupClass (<obj>)
##
##  creates a group class from an object
##
DeclareOperation ("GroupClass", [IsObject]);


#############################################################################
##
#O  GroupClass (<list>, <func>)
##
##  creates a group class from a list of groups and an isomorphism function
##
DeclareOperation ("GroupClass", [IsList and IsMultiplicativeElementWithInverseCollColl,
	IsFunction]);


#############################################################################
##
#P  IsSubgroupClosed (<group class>)
#P  IsNormalSubgroupClosed (<group class>)
#P  IsQuotientClosed (<group class>)
#P  IsResiduallyClosed (<group class>)
#P  IsNormalProductClosed (<group class>)
#P  IsDirectProductClosed (<group class>)
#P  IsSchunckClass (<group class>)
#P  IsSaturated (<group class>)
##
##  primitive closure properties of group classes
##
DeclareProperty ("IsSubgroupClosed", IsGroupClass);
DeclareProperty ("IsNormalSubgroupClosed", IsGroupClass);
DeclareProperty ("IsQuotientClosed", IsGroupClass);
DeclareProperty ("IsResiduallyClosed", IsGroupClass);
DeclareProperty ("IsNormalProductClosed", IsGroupClass);
DeclareProperty ("IsDirectProductClosed", IsGroupClass);
DeclareProperty ("IsSchunckClass", IsGroupClass);
DeclareProperty ("IsSaturated", IsGroupClass);

#############################################################################
##
#V  ClosureProperties
##
##  list of all closure properties
##
DeclareGlobalVariable ("ClosureProperties");
InstallValue (ClosureProperties, 
	[IsSubgroupClosed,
	IsNormalSubgroupClosed,
	IsQuotientClosed,
	IsResiduallyClosed,
	IsNormalProductClosed,
	IsDirectProductClosed,
	IsSchunckClass,
	IsSaturated]);


#############################################################################
##
#M  IsNormalSubgroupClosed
##
InstallTrueMethod (IsNormalSubgroupClosed, IsSubgroupClosed);


#############################################################################
##
#M  IsDirectProductClosed
##
InstallTrueMethod (IsDirectProductClosed, IsResiduallyClosed);


#############################################################################
##
#M  IsDirectProductClosed
##
InstallTrueMethod (IsDirectProductClosed, IsNormalProductClosed);


#############################################################################
##
#M  IsNonEmpty
##
InstallTrueMethod (IsNonEmpty, IsSchunckClass);


#############################################################################
##
#M  IsDirectProductClosed
##
InstallTrueMethod (IsDirectProductClosed, IsSchunckClass);


#############################################################################
##
#M  IsQuotientClosed
##
InstallTrueMethod (IsQuotientClosed, IsSchunckClass);


#############################################################################
##
#M  IsSaturated
##
InstallTrueMethod (IsSaturated, IsSchunckClass);


#############################################################################
##
#M  IsSchunckClass
##
InstallTrueMethod (IsSchunckClass, 
	IsNonEmpty and IsQuotientClosed and IsResiduallyClosed and IsSaturated);


#############################################################################
##
#M  IsResiduallyClosed
##
InstallTrueMethod (IsResiduallyClosed, 
	IsDirectProductClosed and IsSubgroupClosed);


#############################################################################
##
#E
##
