#############################################################################
##
##  injector.gd                      CRISP                   Burkhard Höfling
##
##  Copyright © 2000 Burkhard Höfling
##


#############################################################################
##
#V  InfoInjector
##
DeclareInfoClass("InfoInjector");


#############################################################################
##
#A  Injector(<grp>, <class>)
##
KeyDependentOperation("Injector", IsGroup, IsClass, ReturnTrue);


#############################################################################
##
#F  InjectorFromRadicalFunction(<grp>, <func>, <hom>)
##
##  compute an F-injector of <grp>, from a function func which computes the 
##  F-radical for any subgroup of <grp>. If <hom> is true, computations are
##  carried out in factor groups wherever possible.
##
DeclareGlobalFunction("InjectorFromRadicalFunction");


############################################################################
##
#E
##
