#############################################################################
##
##  residuals.gd                     CRISP                 Burkhard H\"ofling
##
##  @(#)$Id$
##
##  Copyright (C) 2000 by Burkhard H\"ofling, Mathematisches Institut,
##  Friedrich Schiller-Universit\"at Jena, Germany
##
Revision.residuals_gd :=
    "@(#)$Id$";


#############################################################################
##
#A  Residual (<grp>, <class>)
##
KeyDependentOperation ("Residual", IsGroup, IsGroupClass, ReturnTrue);


#############################################################################
##
#O  OneNormalSubgroupMinWrtQProperty (<grp>, <pretest>, <test>, <data>)
##
##  returns a normal subgroup M of <grp> belonging to a class X, and
##  such that no normal subgroup N of <grp> properly contained in M belongs
##  to X. X must have the following property: If K and L are normal subgroups 
##  of <grp>, K is in X and L contains K, then also L must be in X.
##  It is always presumed that <grp> belongs to X.
##
##  <pretest> is a function taking four arguments, U, V, R, and <data>, where
##  <data> is just the argument passed to OneNormalSubgroupMaxWrtNProperty.
##  U/V is a chief factor of <grp>, and R is a normal subgroup of <grp>
##  which is known to belong to X.
##
##  <pretest> may return the values true, false, or fail. If it returns 
##  true, every normal subgroup N of <grp> such that R is the extension of 
##  N by U/V must belong to X. If it returns false, no
##  such extension may belong to to X. U/V is always a chief factor of <grp>.
##
##  <test> is a function taking three arguments, S, R, and <data>, where
##  data has been described above. R is a normal subgroup of G belonging to X,
##  and R/S is a chief factor of G. The function must return true if S belongs
##  to X, and false otherwise. 
##
##  Note that <test> is never called if <pretest>(U, V, R) has returned true or
##  false for a chief factor U/V which is G-isomorphic with R/S.
##
##  <data> is never used or changed by OneNormalSubgroupMaxWrtNProperty, but
##  exists only as a means for passing additional information to the test
##  functions.
##
DeclareOperation ("OneNormalSubgroupMinWrtQProperty", 
	[IsGroup, IsFunction, IsFunction, IsObject]);


#############################################################################
##
#O  AllNormalSubgroupsWithQProperty (<grp>, <pretest>, <test>, <data>)
##
##  returns a list consisting of all normal subgroups of <grp> belonging to
##  the class X described by <pretest> and <test>. For the description
##  of <pretest>, <test>, and <data>, see OneNormalSubgroupMinWrtQProperty
##  above.
##
##  Note that <grp> is always assumed to lie in X.
##
DeclareOperation ("AllNormalSubgroupsWithQProperty", 
	[IsGroup, IsFunction, IsFunction, IsObject]);


#############################################################################
##
#F  PcgsAllNormalSubgroupsWithQProperty (<grp>, <pretest>, <test>, <data>,
##   	hom, conv)
##
##  similar to AllNormalSubgroupsWithQProperty, but working with a pcgs,
##  and returning the pcgs of all normal subgroups. Also the chief factor
##  used in <pretest> is a modulo pcgs.
##
DeclareGlobalFunction ("PcgsAllNormalSubgroupsWithQProperty");

############################################################################
##
#E
##
