#############################################################################
##
##  residual.gd                      CRISP                   Burkhard Höfling
##
##  Copyright © 2000-2002, 2006 by Burkhard Höfling
##


#############################################################################
##
#A  Residual(<grp>, <class>)
##
KeyDependentOperation("Residual", IsGroup, IsGroupClass, ReturnTrue);
DeclareSynonym("Residuum", Residual);


#############################################################################
##
#A  CharacteristicSubgroups(<grp>)
##
##  See the manual.
##
DeclareAttribute("CharacteristicSubgroups", IsGroup);


#############################################################################
##
#O  OneInvariantSubgroupMinWrtQProperty 
#O                                 (<act>, <grp>, <pretest>, <test>, <data>)
##
##  See the manual.
##
DeclareOperation("OneInvariantSubgroupMinWrtQProperty", 
    [IsListOrCollection, IsGroup, IsFunction, IsFunction, IsObject]);


############################################################################
##
#O  AllInvariantSubgroupsWithQProperty 
#O                                (<act>, <grp>, <pretest>, <test>, <data>)
##
##  See the manual.
##
DeclareOperation("AllInvariantSubgroupsWithQProperty", 
    [IsListOrCollection, IsGroup, IsFunction, IsFunction, IsObject]);


#############################################################################
##
#O  OneNormalSubgroupMinWrtQProperty(<grp>, <pretest>, <test>, <data>)
##
##  See the manual.
##
DeclareOperation("OneNormalSubgroupMinWrtQProperty", 
    [IsGroup, IsFunction, IsFunction, IsObject]);


############################################################################
##
#O  AllNormalSubgroupsWithQProperty <grp>, <pretest>, <test>, <data>)
##
##  See the manual.
##
DeclareOperation("AllNormalSubgroupsWithQProperty", 
    [IsGroup, IsFunction, IsFunction, IsObject]);


############################################################################
##
#E
##
