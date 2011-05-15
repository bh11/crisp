#############################################################################
##
##  util.gd                         CRISP                   Burkhard Höfling
##
##  @(#)$Id$
##
##  Copyright (C) 2000-2002, 2005 Burkhard Höfling
##
Revision.util_gd :=
    "@(#)$Id$";


#############################################################################
##
#A  NormalGeneratorsOfNilpotentResidualNilpotentResidual 
##
##  the normal closure of the subgroup generated by these elements
##  is the nilpotent residual (i.e., last term of the lower central series)
##
DeclareAttribute ("NormalGeneratorsOfNilpotentResidual", IsGroup);


#############################################################################
##
#F  CompositionSeriesElAbFactorUnderAction (<act>, <M>, <N>)
##
##  computes a <act>-composition series of the elementary abelian normal section M/N,
##  i.e. a list M = N_0 > N_1 > ... > N_r = N of subgroups of <grp> such that 
##  there is no <grp>-invariant subgroup between N_i and N_{i+1}.
##
DeclareGlobalFunction ("CompositionSeriesElAbFactorUnderAction");


#############################################################################
##
#F  PcgsCompositionSeriesElAbModuloPcgsUnderAction (<act>, <sec>)
##
##  computes a series of pcgs representing a <grp>-composition series of the  
##  elementary abelian normal section M/N,
##  i.e. a list M = N_0 > N_1 > ... > N_r = N of subgroups of <grp> such that 
##  there is no <grp>-invariant subgroup between N_i and N_{i+1}.
##
DeclareGlobalFunction ("PcgsCompositionSeriesElAbModuloPcgsUnderAction");


#############################################################################
##
#F  IsAbelianModuloPcgs (<pcgs>)
##
##  tests whether pcgs (regarded as factor group) is abelian
##
DeclareGlobalFunction ("IsAbelianModuloPcgs");


#############################################################################
##
#O  CentralizesLayer (<list>, <mpcgs>)
##
DeclareOperation ("CentralizesLayer", [IsListOrCollection, IsModuloPcgs]);


#############################################################################
##
#O  CompositionSeriesUnderAction (<act>, <grp>)
##
DeclareOperation ("CompositionSeriesUnderAction", 
	[IsListOrCollection, IsGroup]);


#############################################################################
##
#F  PcgsElementaryAbelianSeriesFromGenericPcgs (<G>)
##
##  computes a pcgs exhibiting an elementary abelian series of G
##  from a given pcgs, avoiding SpecialPcgs. In particular returns the family 
##  pcgs if it has the required property
##
DeclareGlobalFunction ("PcgsElementaryAbelianSeriesFromGenericPcgs");


#############################################################################
##
#O  SiftedPcElementWrtPcSequence (<pcgs>, <seq>, <depths>, <x>)
##
##  sifts an element x through a pc sequence <seq> (that is, a plain list
##  whose elements form a (modulo) pcgs), reducing <x> if it has the same  
##  depth (wrt. the pcgs <pcgs>) as an element in seq. It returns the 
##  sifted element. <depths> must be a list containing for each element 
##  in seq its depth wrt. <pcgs>.
##
DeclareOperation ("SiftedPcElementWrtPcSequence", 
   [IsPcgs, IsListOrCollection, IsList, IsMultiplicativeElementWithInverse]);
   
#############################################################################
##
#O  AddPcElementToPcSequence (<pcgs>, <seq>, <depths>, <x>)
##
##  sifts an element <x> through a pc sequence <seq> reducing <x> if it has 
##  the same depth (wrt. the pcgs <pcgs>) as an element in <seq>. If the
##  resulting element is nontrivial, it is inserted at the
##  appropriate position in <seq>, and the list <depths>, which must be a 
##  list containing for each element in <seq> its depth wrt. <pcgs>, 
##  is adjusted accordingly. In this case, AddPcElementToPcSequence returns 
##  true. Otherwise it returns false. 
##
DeclareOperation ("AddPcElementToPcSequence", 
   [IsPcgs, IsListOrCollection, IsList, IsMultiplicativeElementWithInverse]);


#############################################################################
##
#A  PrimePowerGensPcSequence (<grp>)
##
##  returns a record with components `primes', `generators', and `pcgs'.
##  `pcgs' contains a pcgs of <grp>
##  `primes' contains the set of all prime divisors of <grp>, and
##  `generators' contains a list of group elements, such that the elements in
##  generators[i] have relative order primes[i] and order a power of primes[i].
##  In addition, the list obtained by concatenating all lists in generators
##  forms a pcgs of <grp> when sorted according to their depths wrt. pcgs.

DeclareAttribute ("PrimePowerGensPcSequence", IsGroup);


#############################################################################
##
#F  InstallMethodByNiceMonomorphismForGroupAndClass( <oper>, <filt1>, <filt2>)
##
##  install method for oper taking a group and a class
BindGlobal( "InstallMethodByNiceMonomorphismForGroupAndClass", 
   function( oper, filt1, filt2)
   InstallMethod (oper,
      "handled by nice monomorphism",
      true,
      [IsGroup and IsHandledByNiceMonomorphism and filt1, filt2],
      0,
      function( grp, class)
         return PreImagesSet (NiceMonomorphism (grp), 
            oper (NiceObject (grp), class) );
      end);
   end);


#############################################################################
##
#F  InstallMethodByNiceMonomorphismForGroupAndClassReturningBool (
##      <oper>, <filt1>, <filt2>)
##
BindGlobal( "InstallMethodByNiceMonomorphismForGroupAndBool", 
   function( oper, filt1, filt2)
   InstallMethod (oper,
      "handled by nice monomorphism",
      true,
      [IsGroup and IsHandledByNiceMonomorphism and filt1, filt2],
      0,
      function( grp, class)
         return oper (NiceObject (grp), class);
      end);
   end);


#############################################################################
##
#F  InstallMethodByIsomorphismPcGroupForGroupAndClass( <oper>, <filt1>, <filt2>)
##
##  install method for oper taking a group and a class
BindGlobal( "InstallMethodByIsomorphismPcGroupForGroupAndClass", 
   function( oper, filt1, filt2)
   InstallMethod (oper,
      "handled by IsomorphismPcGroup",
      true,
      [IsGroup and IsSolvableGroup and filt1, filt2],
      0,
      function( grp, class)
         local iso;
         if CanEasilyComputePcgs (grp) then
            TryNextMethod();
         fi;
         iso := IsomorphismPcGroup (grp);
         return PreImagesSet (iso, 
            oper (ImagesSource (iso), class) );
      end);
   end);


#############################################################################
##
#F  InstallMethodByIsomorphismPcGroupForGroupAndClassReturningBool (
##      <oper>, <filt1>, <filt2>)
##
BindGlobal( "InstallMethodByIsomorphismPcGroupForGroupAndClassReturningBool", 
   function( oper, filt1, filt2)
   InstallMethod (oper,
      "handled by IsomorphismPcGroup",
      true,
      [IsGroup and IsSolvableGroup and filt1, filt2],
      0,
      function( grp, class)
         if CanEasilyComputePcgs (grp) then
            TryNextMethod();
         fi;
         return oper (ImagesSource (IsomorphismPcGroup (grp)), class);
      end);
   end);


#############################################################################
##
#E
##
