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
#A  CharacteristicSubgroups (<grp>)
##
##  See the manual.
##
DeclareAttribute ("CharacteristicSubgroups", IsGroup);


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
#O  OneNormalSubgroupMinWrtQPropertyUnderAction 
#O                                  (<grp>, <act>, <pretest>, <test>, <data>)
##
##  See the manual.
##
DeclareOperation ("OneNormalSubgroupMinWrtQPropertyUnderAction", 
   [IsGroup, IsListOrCollection, IsFunction, IsFunction, IsObject]);


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
#O  AllNormalSubgroupsWithQPropertyUnderAction 
#O                                 (<grp>, <act>, <pretest>, <test>, <data>)
##
##  See the manual.
##
DeclareOperation ("AllNormalSubgroupsWithQPropertyUnderAction", 
   [IsGroup, IsListOrCollection, IsFunction, IsFunction, IsObject]);


############################################################################
##
#E
##
