#############################################################################
##
##  radicals.gd                     CRISP                 Burkhard H\"ofling
##
##  @(#)$Id$
##
##  Copyright (C) 2000 by Burkhard H\"ofling, Mathematisches Institut,
##  Friedrich Schiller-Universit\"at Jena, Germany
##
Revision.radicals_gd :=
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
##  returns a normal subgroup M of <grp> belonging to a class X, and
##  such that no normal subgroup N of <grp> properly containing M belongs
##  to X. X must have the following property: If K and L are normal subgroups 
##  of <grp>, K is in X and L is contained in K, then also L must be in X.
##  It is always presumed that the trivial subgroup of <grp> belongs to X.
##
##  <pretest> is a function taking four arguments, U, V, R, and <data>, where
##  <data> is just the argument passed to OneNormalSubgroupMaxWrtNProperty.
##  U/V is a chief factor of <grp>, and R is a normal subgroup of <grp>
##  which is known to belong to X.
##
##  <pretest> may return the values true, false, or fail. If it returns 
##  true, every normal subgroup N of <grp> which is the extension of R by
##  a group isomorphic with U/V must belong to X. If it returns false, no
##  such extension may belong to to X. U/V is always a chief factor of <grp>.
##
##  <test> is a function taking three arguments, S, R, and <data>, where
##  data has been described above. R is a normal subgroup of G belonging to X,
##  and S/R is a chief factor of G. The function must return true if S belongs
##  to X, and false otherwise. 
##
##  Note that <test> is never called if <pretest>(U, V, R) has returned true or
##  false for a chief factor U/V which is G-isomorphic with S/R.
##
##  <data> is never used or changed by OneNormalSubgroupMaxWrtNProperty, but
##  exists only as a means for passing additional information to the test
##  functions.
##
DeclareOperation ("OneNormalSubgroupMaxWrtNProperty", 
	[IsGroup, IsFunction, IsFunction, IsObject]);


#############################################################################
##
#O  AllNormalSubgroupsWithNProperty (<grp>, <pretest>, <test>, <data>)
##
##  returns a list consisting of all normal subgroups of <grp> belonging to
##  the class X described by <pretest> and <test>.
##
##  For the precise meaning of <pretest>, <test> and <data>, see 
##  OneNormalSubgroupMaxWrtNProperty above.
##
##  It is always presumed that the trivial subgroup of <grp> belongs to X.
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
