#############################################################################
##
##  solveeq.gd                      CRISP                 Burkhard H\"ofling
##
##  @(#)$Id$
##
##  Copyright (C) 2000 by Burkhard H\"ofling, Mathematisches Institut,
##  Friedrich Schiller-Universit\"at Jena, Germany
##
Revision.solveeq_gd :=
    "@(#)$Id$";


#############################################################################
##
#F  LinearSystem (nrvars, nrsolutions, field, conv, convsol)
##
DeclareGlobalFunction ("LinearSystem");


#############################################################################
##
#F  AddEquation (sys, row, sol)
##
DeclareGlobalFunction ("AddEquation");


#############################################################################
##
#F  OneSolution (sys, n)
##
DeclareGlobalFunction ("OneSolution");


#############################################################################
##
#F  BasisNullspaceSolution (sys)
##
DeclareGlobalFunction ("BasisNullspaceSolution");


############################################################################
##
#E
##
