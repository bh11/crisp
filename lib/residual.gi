#############################################################################
##
##  residual.gi                      CRISP                 Burkhard H\"ofling
##
##  @(#)$Id$
##
##  Copyright (C) 2000 by Burkhard H\"ofling, Mathematisches Institut,
##  Friedrich Schiller-Universit\"at Jena, Germany
##
Revision.residual_gi :=
    "@(#)$Id$";


#############################################################################
##
#M  NormalSubgroups (<grp>)
##
InstallMethod (NormalSubgroups, 
   "normal complement method for finite soluble groups",
   true,
   [IsGroup and IsFinite and IsSolvableGroup], 
   RankFilter (IsPcGroup and IsPermGroup), # use for pc groups and perm groups 
   function (G) 
      return AllNormalSubgroupsWithQProperty (G, 
         ReturnTrue, ReturnTrue, rec());
   end);


#############################################################################
##
#M  NormalSubgroups (<grp>)
##
RedispatchOnCondition (NormalSubgroups, 
   true, [IsGroup],  [IsFinite and IsSolvableGroup], 
   # rank this method fairly high - presumably all fast methods for computing
   # the normal subgroups need to know if the group is finite and soluble
   RankFilter (IsPcGroup and IsPermGroup));
   

#############################################################################
##
#M  AllNormalSubgroupsWithQProperty (<grp>, <pretest>, <test>, <data>)
##
InstallMethod (AllNormalSubgroupsWithQProperty, 
   "for solvable groups",
   true,
   [IsGroup and IsSolvableGroup and IsFinite, IsFunction, IsFunction, IsObject], 
   RankFilter (IsPcGroup), 
   function (G, pretest, test, data)

      local i, norms, ser, gens, new, N, cmpl, bool, testser;
      
      norms := [G];
      testser := true;
      
      ser := ChiefSeries (G);
      gens := SmallGeneratingSet (G);
         
      for i in [3..Length (ser)] do
         new := [];
         for N in norms do
            bool := pretest (ser[i-1], ser[i], N, data);
            if bool <> false then
               cmpl := NormalComplementsOfElAbSectionUnderAction (
                  gens, N, ser[i-1], ser[i], true);
               if bool = true then
                  Append (new, cmpl);
               else
                  Append (new, Filtered (cmpl, C -> test (C, N, data)));
               fi;
            fi;
         od;
         
         Append (norms, new);
         
         if testser then # ser[i-2] has passed the test
            bool := pretest (ser[i-2], ser[i-1], ser[i-2], data);
            if bool = fail then
               bool := test (ser[i-1], ser[i-2], data);
            fi;
            if bool then
               Add (norms, ser[i-1]);
            else
               testser := false;
            fi;
         fi;
         Info (InfoLattice, 1, "Step ",i,", ",Length (norms)," normal subgroups");
      od;
         
      if testser then # ser[i-2] has passed the test
         bool := pretest (ser[Length (ser)-1], 
            ser[Length (ser)], ser[Length (ser)-1], data);
         if bool = fail then
            bool := test (ser[Length (ser)], ser[Length (ser)-1], data);
         fi;
         if bool then
            Add (norms, ser[Length (ser)]);
         fi;
      fi;
      return norms;
   end);


#############################################################################
##
#M  AllNormalSubgroupsWithQProperty (<grp>, <pretest>, <test>, <data>)
##
RedispatchOnCondition (AllNormalSubgroupsWithQProperty, true, 
   [IsGroup, IsFunction, IsFunction, IsObject], 
   [IsFinite and IsSolvableGroup], # no conditions on other arguments
   RankFilter (IsGroup) + 2*RankFilter (IsFunction) + RankFilter (IsObject));
   
   
#############################################################################
##
#M  OneNormalSubgroupMinWrtQProperty (<grp>, <pretest>, <test>, <data>)
##
InstallMethod (OneNormalSubgroupMinWrtQProperty, 
   "for solvable groups",
   true,
   [IsGroup and IsSolvableGroup and IsFinite, IsFunction, IsFunction, IsObject], 
   0, 
   function (G, pretest, test, data)

      local i, k, M, ser, gens, new, N, cmpl, bool, R;

      if IsTrivial (G) then
         return [G];
      fi;
      
      ser := ChiefSeries (G);

      for k in [2..Length (ser)] do
         bool := pretest (ser[k-1], ser[k], ser[k-1], data);
         if bool = fail then
            bool := test (ser[k], ser[k-1], data);
         fi;
         if not bool then
            break;
         fi;
      od;
      
      if bool then
         return TrivialSubgroup (G);
      fi;
      
      M := ser[k-1];
      
      gens := SmallGeneratingSet (G);
         
      for i in [k..Length (ser)-1] do
         bool := pretest (ser[i], ser[i+1], M, data);
         if bool <> false then
            cmpl := NormalComplementsOfElAbSectionUnderAction (
               gens, M, ser[i], ser[i+1], bool <> true);
            if bool = true then
               if cmpl <> fail then
                  M := cmpl;
               fi;
            else
               for R in cmpl do
                  if test (R, M, data) then
                     M := R;
                     break;
                  fi;
               od;
            fi;
         fi;
         Info (InfoLattice, 1, "Step ",i,"done");
      od;
               
      return M;
   end);


#############################################################################
##
#M  OneNormalSubgroupMinWrtQProperty (<grp>, <pretest>, <test>, <data>)
##
RedispatchOnCondition (OneNormalSubgroupMinWrtQProperty, true, 
   [IsGroup, IsFunction, IsFunction, IsObject], 
   [IsFinite and IsSolvableGroup], # no conditions on other arguments
   RankFilter (IsGroup) + 2*RankFilter (IsFunction) + RankFilter (IsObject));
   
   
#############################################################################
##
#M  ResidualOp (<grp>, <class>)
##
InstallMethod (ResidualOp, "for group and formation with ResidualFunction", true, 
   [IsGroup and IsFinite and IsSolvableGroup, IsOrdinaryFormation and HasResidualFunction], 
   SUM_FLAGS, # highly preferable
   function (G, C)
       return ResidualFunction(C) (G);
 end);


#############################################################################
##
#M  ResidualOp (<grp>, <class>)
##
InstallMethod (ResidualOp, "for group and formation product", true, 
   [IsGroup and IsFinite and IsSolvableGroup, IsFormationProductRep], 0,
   function (G, C)
       return Residual (Residual (G, C!.top), C!.bot);
 end);


#############################################################################
##
#M  ResidualOp (<grp>, <class>)
##
InstallMethod (ResidualOp, "for group and intersection of formations", true, 
   [IsGroup and IsFinite and IsSolvableGroup, IsOrdinaryFormation and IsClassByIntersectionRep], 
   function (G, C)
      local D, R, l;
      R := TrivialSubgroup (G);
      l := [];
      
      # first form the join of all residuals that can be computed cheaply
      for D in C!.intersected do
         if HasResidualFunction (D) then
            R := ClosureGroup (R, ResidualFunction (D)(G));
         elif HasLocalDefinitionFunction (D) then
            R := ClosureGroup (R, Residual (G, D));
         else
            Add (l, D);
         fi;
      od;
      
      if Length (l) > 0 then # treat the remaining classes
         # Note that, although the intersection of the classes in l 
         # need not be a formation, any subgroup returned by 
         # OneNormalSubgroupMinWrtQProperty lies below the C-residual of G.
         
         R := ClosureGroup (R, OneNormalSubgroupMinWrtQProperty (G, 
             ReturnFail,
            function (R, S, data)
               local fac;
               fac := data.grp/R;
               return ForAll (data.list, D -> fac in D);
            end,
            rec (grp := G, list := l)));
      fi;
      return R;
   end);


#############################################################################
##
#M  ResidualOp (<grp>, <class>)
##
InstallMethod (ResidualOp, "generic method for formation", true, 
   [IsGroup and IsFinite and IsSolvableGroup, IsOrdinaryFormation], 0,
   function (G, C)
       return OneNormalSubgroupMinWrtQProperty (G, 
          ReturnFail,
          function (R, S, data)
             return data.grp/R in data.class;
          end,
          rec (grp := G, class := C));
   end);


#############################################################################
##
#M  ResidualOp (<grp>, <class>)
##
InstallMethod (ResidualOp, "for locally defined formation", true, 
   [IsGroup and IsFinite and IsSolvableGroup, 
      IsSaturatedFormation and HasLocalDefinitionFunction], 
   0,
   function (G, C)
       return OneNormalSubgroupMinWrtQProperty (G, 
          function (U, V, R, data)
             local mpcgs, p, pos;
             mpcgs := ModuloPcgs (U, V);
             p := RelativeOrders (mpcgs)[1]; # exponent of U/V
             if p in Characteristic (data.class) then
                pos := PositionSorted (data.primes, p);
                if pos > Length (data.primes) or data.primes[pos] <> p then
                   # add the information from LocalDefinitionFunction
                   data.locgens{[pos+1..Length (data.primes)+1]} := 
                      data.locgens{[pos..Length (data.primes)]};
                   data.primes{[pos+1..Length (data.primes)+1]} := 
                      data.primes{[pos..Length (data.primes)]};
                   data.primes[pos] := p;
                   data.locgens[pos] := LocalDefinitionFunction (data.class)(data.grp, p);
                fi;
                # test if generators of local residual acts centrally
                return CentralizesLayer (data.locgens[pos], mpcgs);
             else
                return false;
             fi;
          end,
          ReturnFail, # will produce an error message if accidentally called
          rec (grp := G, 
             class := C, 
             primes := [], # primes for which the local function has been called
             locgens := [] # corresponding results of calls to local function
          ));
   end);


#############################################################################
##
#M  ResidualOp (<grp>, <class>)
##
InstallMethodByNiceMonomorphismForGroupAndClass (ResidualOp, 
   IsFinite and IsSolvableGroup, IsOrdinaryFormation);
   
   
#############################################################################
##
#M  ResidualOp (<grp>, <class>)
##
RedispatchOnCondition (ResidualOp, true, 
   [IsGroup, IsGroupClass], 
   [IsFinite and IsSolvableGroup],
   RankFilter (IsGroup) + RankFilter (IsGroupClass));
   
   
############################################################################
##
#E
##

