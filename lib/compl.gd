#############################################################################
##
##  compl.gd                         CRISP                 Burkhard H\"ofling
##
##  @(#)$Id$
##
##  Copyright (C) 2000 by Burkhard H\"ofling, Mathematisches Institut,
##  Friedrich Schiller-Universit\"at Jena, Germany
##
Revision.compl_gi :=
    "@(#)$Id$";


#############################################################################
##
#F  PcgsComplementOfChiefFactor
##
##  compute an induced pcgs (wrt pcgs) of a complement of the chief 
##  factor N/K of exponent p of H represented by the modulo pcgs npcgs 
##  in the group H  
##
##   H          hpcgs is a pc sequence representing the factor group H/D
##  : \         hpcgs{[first..Length (hpcgs)]} represents R/D, where
## ?   R        R/D must be elementary abelian of expoent q <> p,
##  : / \       D must centralise N/K, and R must not centralise N/K
##   Q   N      
##    \ /       npcgs is a modulo pcgs representing N/K. The depths (wrt pcgs)
##     K        of the elements in the numerator of npcgs must be strictly  
##              larger than the depths of the elements in hpcgs.
##
DeclareGlobalFunction ("PcgsComplementOfChiefFactor");
DeclareGlobalFunction ("PcgsComplementOfChiefFactor2");


#############################################################################
##
#F  Fact_NPartFunction
#F  Fact_SolutionFunction
#F  Fact_SolutionFunction_TrivialC
#F  Fact_NPartFunction_TrivialC
##
DeclareGlobalFunction ("Fact_NPartFunction");
DeclareGlobalFunction ("Fact_SolutionFunction");
DeclareGlobalFunction ("Fact_SolutionFunction_TrivialC");
DeclareGlobalFunction ("Fact_NPartFunction_TrivialC");		


#############################################################################
##
#F  ExtendedPcgsComplementsOfCentralModuloPcgsUnderAction (<aut>,<pcgs>, <mpcgs>,<all>)
##
DeclareGlobalFunction ("ExtendedPcgsComplementsOfCentralModuloPcgsUnderAction");


#############################################################################
##
#F  PcgsNormalComplementsOfElAbModuloPcgsUnderAction (
##		<aut>, <numpcgs>, <pcgs>, <mpcgs>, <denpcgs>, <all>)
##
##  computes normal complements of the elementary abelian section 
##  N/L in G/L which are invariant under aut.
##  N/L is represented by the modulo pcgs <mpcgs>, G/N is in <pcgs>,
##  G is in <numpcgs>, <L> is in <denpcgs>.
##  If all is true, all such complements are computed, otherwise just one.
##  If no complement exists, an empty list is returned.
##
DeclareGlobalFunction ("PcgsNormalComplementsOfElAbModuloPcgsUnderAction"); 
#	[IsListOrCollection, IsModuloPcgs, IsModuloPcgs, IsBool]);
	

#############################################################################
##
#F  PcgsComplementsOfCentralModuloPcgsUnderActionNC (<aut>,<pcgs>, <mpcgs>,<all>)
##
##  similar to PcgsNormalComplementsOfElAbModuloPcgsUnderAction, except that it
##  presumes that pcgs centralises mpcgs (and will probably produce an
##  error if not).
##  
DeclareGlobalFunction ("PcgsComplementsOfCentralModuloPcgsUnderActionNC");
#	[IsListOrCollection, IsModuloPcgs, IsModuloPcgs, IsBool]);
	
	
#############################################################################
##
#O  NormalComplementsOfElAbSectionUnderAction (<aut>,<G>,<N>,<L>,<all>)
##
##  computes normal complements of N/L in G/L which are invariant under aut.
##  aut can be a collection of elements of a supergroup of G, or a collection 
##  of automorphisms of G which must fix G, L, N; however this is not checked. 
##  If all is true, all such complements are computed, otherwise just one.
##  If no complement exists, or if N/L is not central in G/L, an empty 
##  list is returned if all is true, and fail is returned if all is false.
##
DeclareOperation ("NormalComplementsOfElAbSectionUnderAction", 
	[IsListOrCollection, IsGroup, IsGroup, IsGroup, IsBool]);

#############################################################################
##
#F  ComplementsOfCentralSectionUnderAction (<aut>,<G>,<N>,<L>,<all>)
#O  ComplementsOfCentralSectionUnderActionNC (<aut>,<G>,<N>,<L>,<all>)
##
##  similar to ComplementsOfElAbSectionUnderAction; however G is expected
##  to act centrally on N/L. ComplementsOfCentralSectionUnderActionNC
##  does not check this.
##
DeclareGlobalFunction ("ComplementsOfCentralSectionUnderAction");
	
DeclareOperation ("ComplementsOfCentralSectionUnderActionNC", 
	[IsListOrCollection, IsGroup, IsGroup, IsGroup, IsBool]);

	
#############################################################################
##
#F  ComplementsMaximalUnderAction (G, ser, i, j, k, all) 
## 
##  computes subgroups C of ser[i] such that C/ser[k] is a G-invariant complement 
##  of ser[j]/ser[k] in ser[i]/ser[k].
##  
##  ser[k]/ser[k] < ser[k-1]/ser[k] < ... < ser[j]/ser[k] < U/ser[k] 
##  must be a G-composition of U/ser[k], and U must be a subgroup of G.
##  If all is true, it returns a list containing all such C.
##  Otherwise it returns one C if it exists, or fail if no such C exists. 
##
DeclareGlobalFunction ("ComplementsMaximalUnderAction");


#############################################################################
##
#F  PcgsComplementsMaximalUnderAction (G, U, ser, j, k, all) 
## 
##  does the nontrivial work for ComplementsMaximalUnderAction above
##
DeclareGlobalFunction ("PcgsComplementsMaximalUnderAction");


############################################################################
##
#E
##
