#############################################################################
##
##  residual.gd                      CRISP                 Burkhard H\"ofling
##
##  @(#)$Id$
##
##  Copyright (C) 2000 by Burkhard H\"ofling, Mathematisches Institut,
##  Friedrich Schiller-Universit\"at Jena, Germany
##
Revision.residual_gd :=
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
##  See the manual.
##
DeclareOperation ("OneNormalSubgroupMinWrtQProperty", 
   [IsGroup, IsFunction, IsFunction, IsObject]);


#############################################################################
##
#O  AllNormalSubgroupsWithQProperty (<grp>, <pretest>, <test>, <data>)
##
##  See the manual.
##
DeclareOperation ("AllNormalSubgroupsWithQProperty", 
   [IsGroup, IsFunction, IsFunction, IsObject]);


############################################################################
##
#E
##
