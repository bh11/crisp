#############################################################################
##
##  radical.gd                      CRISP                 Burkhard H\"ofling
##
##  @(#)$Id$
##
##  Copyright (C) 2000 by Burkhard H\"ofling, Mathematisches Institut,
##  Friedrich Schiller-Universit\"at Jena, Germany
##
Revision.radical_gd :=
    "@(#)$Id$";


#############################################################################
##
#A  Radical (<grp>, <class>)
##
##  this is defined for arbitrary classes to allow radicals wrt. Fitting sets
##
KeyDependentOperation ("Radical", IsGroup, IsClass, ReturnTrue);


#############################################################################
##
#O  OneNormalSubgroupMaxWrtNProperty (<grp>, <pretest>, <test>, <data>)
##
##  See the manual.
##
DeclareOperation ("OneNormalSubgroupMaxWrtNProperty", 
   [IsGroup, IsFunction, IsFunction, IsObject]);


#############################################################################
##
#O  AllNormalSubgroupsWithNProperty (<grp>, <pretest>, <test>, <data>)
##
##  See the manual.
##
DeclareOperation ("AllNormalSubgroupsWithNProperty",
    [IsGroup, IsFunction, IsFunction, IsObject]);
   

#############################################################################
##
#F  GInvariantSubgroupsCA (G, ser, avoid, cover, property, max) . . . local
##
##  if all is true, GInvariantSubgroupsCA computes the G-invariant normal
##  subgroups N of ser[1] such that ser[cover] equals the intersection of N
##  and ser[avoid], N contains ser[cover] properly, and property(N) returns 
##  true. If all is false, GInvariantSubgroupsCA only returns the subgroups N
##  which are maximal subject to the above conditions. property must be
##  inherited by G-invariant subgroups, and property(ser[cover])
##  is assumed to be true
##
DeclareGlobalFunction ("GInvariantSubgroupsCA");


############################################################################
##
#E
##
