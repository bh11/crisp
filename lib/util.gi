#############################################################################
##
##  util.gi                         CRISP                 Burkhard H\"ofling
##
##  @(#)$Id$
##
##  Copyright (C) 2000 by Burkhard H\"ofling, Mathematisches Institut,
##  Friedrich Schiller-Universit\"at Jena, Germany
##
Revision.util_gi :=
    "@(#)$Id$";


###################################################################################
##
#M  SmallGeneratingSet 
##
InstallMethod (SmallGeneratingSet, "for pc groups", true,
   [IsPcGroup], SUM_FLAGS, 
   function (G)
      if Length (GeneratorsOfGroup (G)) < Length (Pcgs(G)) then
         return GeneratorsOfGroup (G);
      else
         return Pcgs (G);
      fi;
   end);


InstallMethod (SmallGeneratingSet, "for groups with pcgs", true,
   [IsGroup and CanEasilyComputePcgs], 0, 
   Pcgs);


#############################################################################
##
#M  CentralizesLayer (<list>, <mpcgs>)
##
InstallMethod (CentralizesLayer, "generic method", IsIdenticalObj,
   [IsListOrCollection, IsModuloPcgs], 0,
   function (l, mpcgs)

      local len, i, x, exp, j;
   
      len := Length (mpcgs);
      for i in [1..len] do
         for x in l do
            exp := ExponentsConjugateLayer (mpcgs, mpcgs[i], x);
            if exp[i] <> 1 then
               return false;
            fi;
            for j in [1..len] do
               if exp[j] <> 0 and i <> j then
                  return false;
               fi;
            od;
         od;
      od;
      return true;
   end);


InstallMethod (CentralizesLayer, "for empty list", true,
   [IsListOrCollection and IsEmpty, IsModuloPcgs], 0,
   ReturnTrue);


#############################################################################
##
#M  PrimePowerGensPcSequence (<grp>)
##
InstallMethod (PrimePowerGensPcSequence, 
   "for group which can easily compute a pcgs", true,
   [IsGroup and CanEasilyComputePcgs], 0,
   function (G)
      local pcgs, primes, gens, x, o, qr, r, p, f, pos, len;
         
      primes := [];
      gens := [];
      len := 0;
      pcgs := Pcgs (G);
      
      for x in pcgs do
         o := Order (x);
         p := RelativeOrderOfPcElement (pcgs, x);
         
         # we are looking for the p-part of x
         qr := [o, 0];
         repeat
            r := qr[1];
            qr := QuotientRemainder (Integers, r, p);
         until qr[2] <> 0;
         pos := PositionSorted (primes, p);
         
         if pos <= Length (primes) and primes[pos] = p then
            Add (gens[pos], x^r);
         else #insert a new prime
            primes{[pos+1..len+1]} := primes{[pos..len]};
            gens{[pos+1..len+1]} := gens{[pos..len]};
            primes[pos] := p;
            gens[pos] := [x^r];
            len := len + 1;
         fi;
      od;
      return rec (primes := primes, generators := gens, pcgs := pcgs);
   end);
   
   
#############################################################################
##
#M  PrimePowerGensPcSequence (<grp>)
##
InstallMethod (PrimePowerGensPcSequence, "for group with special pcgs", true,
   [IsGroup and HasSpecialPcgs], 0,
   function (G)
      local pcgs, primes, gens, x, o, qr, r, p, f, pos, len;
         
      primes := [];
      gens := [];
      len := 0;
      pcgs := SpecialPcgs (G);
      
      # elements already have prime power order
      for x in pcgs do
         p := RelativeOrderOfPcElement (pcgs, x);
         
         pos := PositionSorted (primes, p);
         if pos <= Length (primes) and primes[pos] = p then
            Add (gens[pos], x);
         else #insert a new prime
            primes{[pos+1..len+1]} := primes{[pos..len]};
            gens{[pos+1..len+1]} := gens{[pos..len]};
            primes[pos] := p;
            gens[pos] := [x];
            len := len + 1;
         fi;
      od;
      return rec (primes := primes, generators := gens, pcgs := pcgs);
   end);
   

############################################################################
##
#M  IsNilpotentGroup
##
InstallMethod (IsNilpotentGroup, "for pcgs computable group", true,
   [IsGroup and IsFinite and CanEasilyComputePcgs], 0,
   function (G)
      local pseq, i, j;
      
      if HasSpecialPcgs (G) then
         TryNextMethod();
      fi;
      
      pseq := PrimePowerGensPcSequence (G);
      for i in [1..Length (pseq.generators)] do
         for j in [i+1..Length (pseq.generators)] do
            if ForAny (pseq.generators[i], x ->
               ForAny (pseq.generators[j], y -> x^y <> x)) then
                  return false;
            fi;
         od;
      od;
      return true;
   end);
   
      
############################################################################
##
#M  NormalGeneratorsOfNilpotentResidual
##
InstallMethod (NormalGeneratorsOfNilpotentResidual, "for pcgs computable group",
   true,
   [IsGroup and IsFinite and CanEasilyComputePcgs], 
   0,
   function (G)
      local pgens, gens, i, j, x, y, c, id;
      id := One(G);
      gens := [];
      pgens := PrimePowerGensPcSequence (G);
      for i in [1..Length (pgens.generators)] do
         for j in [i+1..Length (pgens.generators)] do
            for x in pgens.generators[i] do
               for y in pgens.generators[j] do
                  c := Comm (x, y);
                  if c <> id then
                     Add (gens, c);
                  fi;
               od;
            od;
         od;
      od;
      return gens;
   end);
   

############################################################################
##
#M  NormalGeneratorsOfNilpotentResidual
##
InstallMethod (NormalGeneratorsOfNilpotentResidual, 
   "generic method - use lower central series",
   true,
   [IsGroup], 
   0,
   function (G)
      local lcs;
      lcs := LowerCentralSeries (G);
      return GeneratorsOfGroup (lcs[Length (lcs)]);
   end);

      
###################################################################################
##
#M  IsPrimitiveSolvable
##
InstallMethod (IsPrimitiveSolvable, "for generic group", true,
   [IsGroup], 0,
   function (G)
   
      local N, ds, p, pcgs, mats, R, Q, M, m, k, q, c, i;
      
      if IsTrivial (G) then
         return false;
      fi;
      
      ds := DerivedSeries (G);
      
      if not IsTrivial (ds[Length (ds)]) then
         return false;
      fi; 
      
      N := ds[Length (ds)-1];
      
      pcgs := Pcgs (N);
      if Length (ds) = 2 then # abelian case
         if Length (pcgs) = 1 then
            SetSocle (G, G);
            SetSocleComplement (G, TrivialSubgroup (G));
            return true;
         else
            return false;
         fi;
      fi;
      
      p := RelativeOrderOfPcElement (pcgs, pcgs[1]);
      
      if ForAny (pcgs, x -> x^p <> One(G)) then
         return false;
      fi;
      
      R := ds[Length (ds)-2];
      m := ModuloPcgs (R, N);
      
      if p in RelativeOrders (m) then # N is not the Fitting subgroup of G
         return false;
      fi;
      
      # find out if N is a minimal normal subgroup of G
      mats := LinearActionLayer (G, SmallGeneratingSet (G), pcgs);

      if not MTX.IsIrreducible (GModuleByMats (mats, GF(p))) then
         return false;
      fi;
      
      # now test if N is complemented
      
      # find small Sylow subgroup of R 
      c := Collected (RelativeOrders (m));
      k := c[1][2];
      q := c[1][1];
      
      for i in [2..Length (c)] do
         if c[i][2] < k then
            k := c[i][2];
            q := c[i][1];
         fi;
      od;
      
      Q := SylowSubgroup (R, q);
      
      if IsNormal (G, Q) then
         return false;
      fi;
      
      M := NormalizerOfPronormalSubgroup (G, Q);
      
      if not IsTrivial (Core (N, M)) then
         return false;
      fi;
      
      # save some information about G
      SetSocle (G, N);
      SetFittingSubgroup (G, N);
      
      # if Q is not normal, its normalizer is a complement of N in G
      SetSocleComplement (G, M);
      return true;
   end);


###################################################################################
##
#M  SocleComplement
##
InstallMethod (SocleComplement, "for primitive solvable group", true,
   [IsGroup and IsPrimitiveSolvable], 0,
   function (G)
   
      local N, ds, p, pcgs, mats, R, Q, M, m, k, q, c, i;
      
      if IsTrivial (G) then
         Error ("G must be primitive and solvable");
      fi;
      
      ds := DerivedSeries (G);
      
      if not IsTrivial (ds[Length (ds)]) then
          Error ("G must be primitive and solvable");
      fi; 
      
      N := ds[Length (ds)-1];
      
      pcgs := Pcgs (N);
      if Length (ds) = 2 then # abelian case
         if Length (pcgs) = 1 then
            SetSocle (G, G);
            SetSocleComplement (G, TrivialSubgroup (G));
            return true;
         else
            return false;
         fi;
      fi;
      
      p := RelativeOrderOfPcElement (pcgs, pcgs[1]);
      
      if ForAny (pcgs, x -> x^p <> One(G)) then
          Error ("G must be primitive and solvable");
      fi;
      
      R := ds[Length (ds)-2];
      
      # now test if N is complemented
      
      # find small Sylow subgroup of R 
      c := Collected (RelativeOrders (m));
      k := c[1][2];
      q := c[1][1];
      
      for i in [2..Length (c)] do
         if c[i][2] < k then
            k := c[i][2];
            q := c[i][1];
         fi;
      od;
      
      Q := SylowSubgroup (R, q);
      
      if IsNormal (G, Q) then
         return false;
      fi;
      
      M := NormalizerOfPronormalSubgroup (G, Q);
      
      if not IsTrivial (Core (N, M)) then
         return false;
      fi;
      
      # save some information about G
      SetSocle (G, N);
      SetFittingSubgroup (G, N);
      
      # if Q is not normal, its normalizer is a complement of N in G
      return M;
   end);


###################################################################################
##
#F  ChiefSeriesElAbFactorUnderAction (<grp>, <M>, <N>)
##
##  computes a <grp>-chief series of the elementary abelian normal section M/N,
##  i.e. a list M = N_0 > N_1 > ... > N_r = N of subgroups of <grp> such that 
##  each N_i is normal in M and there is no <grp>-invariant subgroup between 
##  N_i and N_{i+1}.
##
InstallGlobalFunction ("ChiefSeriesElAbFactorUnderAction",
   function (act, M, N)

      local m;
      
      m := Pcgs (M) mod InducedPcgs (Pcgs (M), N);
      return List (PcgsChiefSeriesElAbModuloPcgsUnderAction (act, m),
         s -> SubgroupByPcgs (M, s));
   end);
   
      
###################################################################################
##
#F  PcgsChiefSeriesElAbModuloPcgsUnderAction (<grp>, <sec>)
##
##  computes a series of pcgs representing a <grp>-chief series of the elementary 
##  abelian normal section M/N,
##  i.e. a list M = N_0 > N_1 > ... > N_r = N of subgroups of <grp> such that 
##  each N_i is normal in M and there is no <grp>-invariant subgroup between 
##  N_i and N_{i+1}.
##
InstallGlobalFunction ("PcgsChiefSeriesElAbModuloPcgsUnderAction",
   function (act, pcgs)

      local ppcgs, bas, bases, mats, p, new, ser, b, v, gens, num, 
         y, len, depth, ddepth, pos, dp, t0, t;
      
      num := NumeratorOfModuloPcgs (pcgs);
      
      if Length (pcgs) = 0 then
         return [num];
      elif Length (pcgs) = 1 then
         return [num, DenominatorOfModuloPcgs (pcgs)];
      fi;
      
      ppcgs := ParentPcgs (num);
      p := RelativeOrderOfPcElement (pcgs, pcgs[1]);
         
      if Length (act) = 0 then
         bases := IdentityMat (Length (pcgs), GF(p));
         bas := List ([1..Length (bases)], i -> bases{[i..Length (bases)]});   
         Add (bas, []);
      else
         mats := LinearActionLayer (act, pcgs);
      
         bas := [];
      
         t0 := Runtime();
         bases := MTX.BasesCompositionSeries (GModuleByMats (mats, GF(p)));
         t := Runtime() - t0;
      
         for b in bases do
            new := MutableCopyMat (b);
            TriangulizeMat (new);
            Add (bas, new);
         od;
      fi;
      
      Sort (bas, function (a, b) return Length (a) > Length (b); end);
      
      ser := [];
      
      ddepth := List (DenominatorOfModuloPcgs (pcgs), 
         y -> DepthOfPcElement (ppcgs, y));
         
      for b in bas do
         gens := List (DenominatorOfModuloPcgs (pcgs));
         len := Length (gens);
         depth := ShallowCopy (ddepth);
         
         for v in b do
            y := PcElementByExponentsNC (pcgs, v);
            dp := DepthOfPcElement (ppcgs, y);
            pos := PositionSorted (depth, dp);
            while pos <= len and dp = depth[pos] do
               y := ReducedPcElement (ppcgs, y, gens[pos]);
               dp := DepthOfPcElement (ppcgs, y);
               pos := PositionSorted (depth, dp);
            od;
            gens{[pos+1..len+1]} := gens{[pos..len]};
            depth{[pos+1..len+1]} := depth{[pos..len]};
            gens[pos] := y;
            depth[pos] := dp;
            len := len + 1;
         od;
         Add (ser, InducedPcgsByPcSequenceNC (ppcgs, gens));
      od;
      return ser;
   end);


###################################################################################
##
#M  ChiefSeries (<grp>)
##
InstallMethod (ChiefSeries, 
   "for pcgs computable group refining PcgsElementaryAbelianSeries",
   true, [IsGroup and CanEasilyComputePcgs], 1,
   function (G)
   
      local gens, pcgs, inds, elabser, i, ser;
      
      pcgs := PcgsElementaryAbelianSeries (G);
      if pcgs = fail then
         TryNextMethod();
      fi;
      
      inds := IndicesNormalSteps (pcgs);
      elabser := List (inds, 
         i -> InducedPcgsByPcSequence (pcgs, pcgs{[i..Length (pcgs)]}));
      
      ser := [];
      for i in [1..Length (elabser)-1] do
         Append (ser, 
            PcgsChiefSeriesElAbModuloPcgsUnderAction (
               pcgs{[1..inds[i]-1]}, elabser[i] mod elabser[i+1]));
         Unbind (ser[Length (ser)]);
      od;
      
      ser := List (ser, p -> SubgroupByPcgs (G, p));
      Add (ser, TrivialSubgroup (G));
      return ser;
   end);
   

###################################################################################
##
#F  PcgsElementaryAbelianSeriesFromGenericPcgs
##

InstallGlobalFunction ("PcgsElementaryAbelianSeriesFromGenericPcgs",
   function (pcgs)
   
      local ro, p, new, i, nsteps, j, k,  n, d, 
         npcgs, dpcgs, der, depths, x, m;
      
      if IsPcgsElementaryAbelianSeries (pcgs) and HasIndicesNormalSteps (pcgs) then
         return pcgs;
      fi;
      
      ro := RelativeOrders( pcgs );
      
      i := 1;
      nsteps := [1];
      
      while i <= Length (pcgs) do      
      
         p := ro[i];
         n := DepthOfPcElement (pcgs, pcgs[i]^p);
         j := i + 1;
         
         while j < n do
         
            if ro[j] = p then
               d := DepthOfPcElement (pcgs, pcgs[j]^p);
            
               if d < n then
                  n := d;
               fi;
            
               d := Minimum (List ([i..j-1], k ->
                  DepthOfPcElement (pcgs, Comm(pcgs[j], pcgs[k]))));
               
               if d < n then
                  n := d;
               fi;
               
               j := j + 1;

            else
               n := j;
            fi;
         od;
         
         # now find smallest normal subgroup of the series containing 
         # the previously computed group
         j := 1;
         while i < n and j < n do
            k := n;
            while i < n and k <= Length (pcgs) do
               d := DepthOfPcElement (pcgs, Comm(pcgs[k], pcgs[j]));
               if d < n then
                  n := d;
               fi;
               k := k + 1;
            od;
            j := j + 1;
         od;
         
         if n < i then 
            Error ("internal error!");
         elif n = i then # no abelian normal section found - change pcgs
            Info (InfoPcGroup, 2, "changing pcgs");
            npcgs := InducedPcgsByPcSequenceNC (pcgs, pcgs{[i..Length (pcgs)]});
            der := DerivedSubgroup (GroupOfPcgs (npcgs));
            dpcgs := InducedPcgs (pcgs, der);
            m := npcgs mod dpcgs;
            dpcgs := List (dpcgs);
            depths := List (dpcgs, x -> DepthOfPcElement (pcgs, x));
            for x in Reversed (m) do
               AddPcElementToPcSequence (pcgs, dpcgs, depths, x^p);
            od;
            dpcgs := CanonicalPcgs (
               InducedPcgsByPcSequenceNC (pcgs, dpcgs));
            m := npcgs mod dpcgs;
            pcgs := PcgsByPcSequenceNC (FamilyObj (pcgs[1]), 
               Concatenation (pcgs{[1..i-1]}, m, dpcgs));
            ro := Concatenation (ro{[1..i-1]}, RelativeOrders (m), RelativeOrders (dpcgs));
            SetRelativeOrders (pcgs, ro );
            Info (InfoPcGroup, 2, "changing pcgs from ",i," ",pcgs);
            n := n + Length (m);
         else
            Info (InfoPcGroup, 2, "normal step found at ",n);
         fi;
         Add (nsteps, n);
         i := n;
      od;
      if HasIndicesNormalSteps (pcgs) and 
      	not HasIsPcgsElementaryAbelianSeries (pcgs) then
      	   pcgs := PcgsByPcSequenceNC (FamilyObj (pcgs[1]), List (pcgs)); # get a copy
      	   if HasIndicesNormalSteps (pcgs) and 
      	      not HasIsPcgsElementaryAbelianSeries (pcgs) then
      	         Error ("cannot get fresh pcgs");
      	    fi;
      fi;
      SetIsPcgsElementaryAbelianSeries (pcgs, true);
      SetIndicesNormalSteps (pcgs, nsteps);
      return pcgs;
   end);


###################################################################################
##
#M  PcgsElementaryAbelianSeries
##
InstallMethod (PcgsElementaryAbelianSeries, "for pc group", 
   true,
   [IsPcGroup and IsFinite],
   1, # this makes the priority higher than the (slow) library method which uses SpecialPcgs
   function (G)
      local pcgs;
      pcgs := Pcgs (G);
      if not IsPrimeOrdersPcgs (pcgs) then
	     TryNextMethod();
      fi;
      return PcgsElementaryAbelianSeriesFromGenericPcgs (pcgs);
   end);


###################################################################################
##
#M  PcgsElementaryAbelianSeries
##
InstallMethod (PcgsElementaryAbelianSeries, "for pc group with parent group", true,
   [IsPcGroup and IsFinite and HasParent], 
   1, # this makes the priority higher than the (slow) library method which uses SpecialPcgs
   function (G)
      local P, pcgs, ppcgs, depths, pinds, inds, i, j;
      
      P := Parent (G);
      if HasPcgsElementaryAbelianSeries (P) then
         ppcgs := PcgsElementaryAbelianSeries (P);
         pcgs := CanonicalPcgs (InducedPcgs (ppcgs, G));
         # now find an elementary abelian series
         depths := List (pcgs, x -> DepthOfPcElement (ppcgs, x));
         pinds := IndicesNormalSteps (ppcgs);
         inds := [];
         i := 1;
         for j in [1..Length(depths)] do
            if depths[j] >= pinds[i] then
               Add (inds, j);
               repeat
                  i := i + 1;
               until depths[j] < pinds[i];
            fi;
         od;
         Add (inds, Length (pcgs)+1);
         SetIndicesNormalSteps (pcgs, inds);
         return pcgs;
      else
         TryNextMethod();
      fi;
   end);
   

###################################################################################
##
#M  PcgsElementaryAbelianSeries
##
InstallMethod (PcgsElementaryAbelianSeries, "generic method", true,
   [IsGroup], 0, 
   function (G) 
      if not IsSolvable (G) then
         Error ("The group <G> must be solvable");
      elif IsPrimeOrdersPcgs (Pcgs(G)) then
         return PcgsElementaryAbelianSeriesFromGenericPcgs (Pcgs(G));
      else
         TryNextMethod();
      fi;
   end);


###################################################################################
##
#M  PcgsElementaryAbelianSeries
##
InstallMethod (PcgsElementaryAbelianSeries, "for group with parent group", true,
   [IsGroup and HasParent], 0, 
   function (G)
      local P, pcgs, ppcgs, pinds, depths, inds, i, j;
      
      P := Parent (G);
      if HasPcgsElementaryAbelianSeries (P) then
         ppcgs := PcgsElementaryAbelianSeries (P);
         pcgs := CanonicalPcgs (InducedPcgs (ppcgs, G));

         depths := List (pcgs, x -> DepthOfPcElement (ppcgs, x));
         pinds := IndicesNormalSteps (ppcgs);
         inds := [];
         i := 1;
         for j in [1..Length(depths)] do
            if depths[j] >= pinds[i] then
               Add (inds, j);
               repeat
                  i := i + 1;
               until depths[j] < pinds[i];
            fi;
         od;
         Add (inds, Length (pcgs)+1);
            SetIndicesNormalSteps (pcgs, inds);
          return pcgs;
      else
         TryNextMethod();
      fi;
   end);
   
   
#############################################################################
##
#M  InducedPcgs (<pcgs>, <grp>)
##
##  WARNING: this function replaces the standard library function - if this
##  library function changes, presumably also this function will have to be
##  changed. Also it uses the undocumented attribute HomePcgs.
##
InstallMethod (InducedPcgs, "for group which has a pcgs", IsIdenticalObj,
   [IsPcgs, IsGroup], 1, # replace library method
   function (pcgs, G)
       if IsIdenticalObj( ParentPcgs( HomePcgs( G ) ), ParentPcgs( pcgs ) )  then
           return InducedPcgsWrtHomePcgs( G );
       elif
           HasParent( G ) and HasSpecialPcgs( Parent( G ) ) 
              and IsIdenticalObj( SpecialPcgs( Parent( G ) ), 
                 ParentPcgs( pcgs ) )  then
           return InducedPcgsWrtSpecialPcgs( G );
       else
         return InducedPcgsWrtPcgs (G, ParentPcgs (pcgs));
      fi;
   end);
   

#############################################################################
##
#M  InducedPcgsWrtPcgsOp (<grp>, <pcgs>)
##
InstallMethod (InducedPcgsWrtPcgsOp, "sift existing pcgs",
   [IsGroup and HasPcgs, IsPcgs], 0,
   function (grp, pcgs)
   
      local ppcgs, seq, depths, x;
      ppcgs := ParentPcgs (pcgs);
      depths := [];
      seq := [];
      for x in Reversed (Pcgs (grp)) do
         if not AddPcElementToPcSequence (ppcgs, seq, depths, x) then
            Error ("Pcgs (grp) does not seem to be a pcgs");
         fi;
      od;
      return InducedPcgsByPcSequence (ppcgs, seq);
   end);
   
   
#############################################################################
##
#M  InducedPcgsWrtPcgsOp (<grp>, <pcgs>)
##
InstallMethod (InducedPcgsWrtPcgsOp, "generic method",
   [IsGroup, IsPcgs], 0,
   function (grp, pcgs)
   
      return InducedPcgsByGenerators (ParentPcgs (pcgs), 
         GeneratorsOfGroup (grp));
   end);
   
   
#############################################################################
##
#M  SiftedPcElementWrtPcSequence (<pcgs>, <seq>, <depths>, <x>)
##
##  sifts an element x through a list seq of elements resembling a Pcgs,
##  reducing x if it has the same depth as an element in seq
##
InstallMethod (SiftedPcElementWrtPcSequence, "generic method",
   function (fpcgs, fseq, fdepths, fx) return IsIdenticalObj (fpcgs, fseq) and 
      IsIdenticalObj (fseq, CollectionsFamily (fx));
   end,
   [IsPcgs, IsListOrCollection, IsList, IsMultiplicativeElementWithInverse], 0, 
   function (pcgs, seq, depths,  x)

   local d, pos;
      
   d := DepthOfPcElement (pcgs, x);
   pos := PositionSorted (depths, d);
   
   while pos <= Length (depths) and depths[pos] = d do
      x := ReducedPcElement (pcgs, x, seq[pos]);
      d := DepthOfPcElement (pcgs, x);
      pos := PositionSorted (depths, d);
   od;
   
   return x;
end);


#############################################################################
##
#M  SiftedPcElementWrtPcSequence (<pcgs>, <seq>, <depths>, <x>)
##
InstallMethod (SiftedPcElementWrtPcSequence, "method for an empty collection",
   function (a,b,c, d) return 
      IsIdenticalObj (a, CollectionsFamily (d));
   end,
   [IsPcgs, IsListOrCollection and IsEmpty, IsList, IsMultiplicativeElementWithInverse], 
   0, 
   function (pcgs, seq, depths, x)
      return x;
   end);
   
   
#############################################################################
##
#M  AddPcElementToPcSequence (<pcgs>, <seq>, <depths>, <x>)
##
InstallMethod (AddPcElementToPcSequence, "generic method",
   function (fpcgs, fseq, fdepths, fx) return IsIdenticalObj (fpcgs, fseq) and 
      IsIdenticalObj (fseq, CollectionsFamily (fx));
   end,
   [IsPcgs, IsListOrCollection, IsList, IsMultiplicativeElementWithInverse], 0, 
   function (pcgs, seq, depths,  x)

   local d, pos, len;
   
   d := DepthOfPcElement (pcgs, x);
   pos := PositionSorted (depths, d);
   len := Length (depths);
   
   while pos <= len and depths[pos] = d do
      x := ReducedPcElement (pcgs, x, seq[pos]);
      d := DepthOfPcElement (pcgs, x);
      pos := PositionSorted (depths, d);
   od;
   
   if d > Length (pcgs) then
      return false;
   fi;
   
   seq{[pos+1..len+1]} := seq{[pos..len]};
   depths{[pos+1..len+1]} := depths{[pos..len]};
   seq[pos] := x;
   depths[pos] := d;
   return true;
end);


#############################################################################
##
#M  AddPcElementToPcSequence (<pcgs>, <seq>, <depths>, <x>)
##
InstallMethod (AddPcElementToPcSequence, "method for an empty collection",
   function (a,b,d, c) return 
      IsIdenticalObj (a, CollectionsFamily (c));
   end,
   [IsPcgs, IsListOrCollection and IsEmpty, IsList and IsEmpty, IsMultiplicativeElementWithInverse], 
   0, 
   function (pcgs, seq, depths, x)
      local d;
      d := DepthOfPcElement (pcgs, x);
      if d > Length (pcgs) then
         return false;
      fi;
      depths[1] := d;
      seq[1] := x;
      return true;
   end);
   

############################################################################
##
#E
##
