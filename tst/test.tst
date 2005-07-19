gap> LoadPackage ("crisp");
true
gap> 
gap> PRINT_METHODS := false;
false
gap> 
gap> ReadPackage ("crisp", "tst/classes.g");
true
gap> ReadPackage ("crisp", "tst/print.g");
SchunckClass (bound:=function( G ) ... end)
SchunckClass (rec (
bound := function ( G )
    return not Factors( Size( Socle( G ) ) )[1] in pi;
end))
function( a ) ... end
Intersection ([ SchunckClass (rec (
    bound := function ( G )
        return not Factors( Size( Socle( G ) ) )[1] in pi;
    end)), SchunckClass (rec (
    bound := function ( G )
        return not Factors( Size( Socle( G ) ) )[1] in pi;
    end)) ])
function( a ) ... end
Intersection ([ SchunckClass (rec (
    bound := function ( G )
        return not Factors( Size( Socle( G ) ) )[1] in pi;
    end)), SaturatedFormation (rec (
    locdef := function ( G, p )
        if p in pi  then
            return [  ];
        else
            return fail;
        fi;
        return;
    end)) ])
function( a ) ... end
Intersection ([ SchunckClass (rec (
    bound := function ( G )
        return not Factors( Size( Socle( G ) ) )[1] in pi;
    end)), GroupClass (rec (
    in := function ( G )
        return 
         IsTrivial( G ) or ForAll( Set( Factors( Size( G ) ) ), function ( p )
                  return p in pi;
              end );
    end)) ])
function( a ) ... end
Intersection ([ SchunckClass (rec (
    bound := function ( G )
        return not Factors( Size( Socle( G ) ) )[1] in pi;
    end)), OrdinaryFormation(rec (
    res := function ( G )
        local  pi;
        pi := Difference( Set( Factors( Size( G ) ) ), [ 2, 5 ] );
        return NormalClosure( G, HallSubgroup( G, pi ) );
    end)) ])
function( a ) ... end
Intersection ([ SchunckClass (rec (
    bound := function ( G )
        return not Factors( Size( Socle( G ) ) )[1] in pi;
    end)), FittingClass ( rec (rec (
    rad := function ( G )
        return Core( G, HallSubgroup( G, [ 2, 5 ] ) );
    end))) ])
function( a ) ... end
Intersection ([ SchunckClass (rec (
    bound := function ( G )
        return not Factors( Size( Socle( G ) ) )[1] in pi;
    end)), FittingClass ( rec (rec (
    inj := function ( G )
        return 
         HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( 
                  p )
                  return p in pi;
              end ) );
    end))) ])
function( a ) ... end
Intersection ([ SchunckClass (rec (
    bound := function ( G )
        return not Factors( Size( Socle( G ) ) )[1] in pi;
    end)), SchunckClass (rec (
    proj := function ( G )
        return 
         HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( 
                  p )
                  return p in pi;
              end ) );
    end)) ])
SaturatedFormation (locdef:=function( G, p ) ... end)
SaturatedFormation (rec (
locdef := function ( G, p )
    if p in pi  then
        return [  ];
    else
        return fail;
    fi;
    return;
end))
function( a ) ... end
Intersection ([ SaturatedFormation (rec (
    locdef := function ( G, p )
        if p in pi  then
            return [  ];
        else
            return fail;
        fi;
        return;
    end)), SaturatedFormation (rec (
    locdef := function ( G, p )
        if p in pi  then
            return [  ];
        else
            return fail;
        fi;
        return;
    end)) ])
function( a ) ... end
Intersection ([ SaturatedFormation (rec (
    locdef := function ( G, p )
        if p in pi  then
            return [  ];
        else
            return fail;
        fi;
        return;
    end)), GroupClass (rec (
    in := function ( G )
        return 
         IsTrivial( G ) or ForAll( Set( Factors( Size( G ) ) ), function ( p )
                  return p in pi;
              end );
    end)) ])
function( a ) ... end
Intersection ([ SaturatedFormation (rec (
    locdef := function ( G, p )
        if p in pi  then
            return [  ];
        else
            return fail;
        fi;
        return;
    end)), OrdinaryFormation(rec (
    res := function ( G )
        local  pi;
        pi := Difference( Set( Factors( Size( G ) ) ), [ 2, 5 ] );
        return NormalClosure( G, HallSubgroup( G, pi ) );
    end)) ])
function( a ) ... end
Intersection ([ SaturatedFormation (rec (
    locdef := function ( G, p )
        if p in pi  then
            return [  ];
        else
            return fail;
        fi;
        return;
    end)), FittingClass ( rec (rec (
    rad := function ( G )
        return Core( G, HallSubgroup( G, [ 2, 5 ] ) );
    end))) ])
function( a ) ... end
Intersection ([ SaturatedFormation (rec (
    locdef := function ( G, p )
        if p in pi  then
            return [  ];
        else
            return fail;
        fi;
        return;
    end)), FittingClass ( rec (rec (
    inj := function ( G )
        return 
         HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( 
                  p )
                  return p in pi;
              end ) );
    end))) ])
function( a ) ... end
Intersection ([ SaturatedFormation (rec (
    locdef := function ( G, p )
        if p in pi  then
            return [  ];
        else
            return fail;
        fi;
        return;
    end)), SchunckClass (rec (
    proj := function ( G )
        return 
         HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( 
                  p )
                  return p in pi;
              end ) );
    end)) ])
GroupClass (in:=function( G ) ... end)
GroupClass (rec (
in := function ( G )
    return 
     IsTrivial( G ) or ForAll( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end );
end))
function( a ) ... end
Intersection ([ GroupClass (rec (
    in := function ( G )
        return 
         IsTrivial( G ) or ForAll( Set( Factors( Size( G ) ) ), function ( p )
                  return p in pi;
              end );
    end)), GroupClass (rec (
    in := function ( G )
        return 
         IsTrivial( G ) or ForAll( Set( Factors( Size( G ) ) ), function ( p )
                  return p in pi;
              end );
    end)) ])
function( a ) ... end
Intersection ([ GroupClass (rec (
    in := function ( G )
        return 
         IsTrivial( G ) or ForAll( Set( Factors( Size( G ) ) ), function ( p )
                  return p in pi;
              end );
    end)), OrdinaryFormation(rec (
    res := function ( G )
        local  pi;
        pi := Difference( Set( Factors( Size( G ) ) ), [ 2, 5 ] );
        return NormalClosure( G, HallSubgroup( G, pi ) );
    end)) ])
function( a ) ... end
Intersection ([ GroupClass (rec (
    in := function ( G )
        return 
         IsTrivial( G ) or ForAll( Set( Factors( Size( G ) ) ), function ( p )
                  return p in pi;
              end );
    end)), FittingClass ( rec (rec (
    rad := function ( G )
        return Core( G, HallSubgroup( G, [ 2, 5 ] ) );
    end))) ])
function( a ) ... end
Intersection ([ GroupClass (rec (
    in := function ( G )
        return 
         IsTrivial( G ) or ForAll( Set( Factors( Size( G ) ) ), function ( p )
                  return p in pi;
              end );
    end)), FittingClass ( rec (rec (
    inj := function ( G )
        return 
         HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( 
                  p )
                  return p in pi;
              end ) );
    end))) ])
function( a ) ... end
Intersection ([ GroupClass (rec (
    in := function ( G )
        return 
         IsTrivial( G ) or ForAll( Set( Factors( Size( G ) ) ), function ( p )
                  return p in pi;
              end );
    end)), SchunckClass (rec (
    proj := function ( G )
        return 
         HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( 
                  p )
                  return p in pi;
              end ) );
    end)) ])
OrdinaryFormation (res:=function( G ) ... end)
OrdinaryFormation(rec (
res := function ( G )
    local  pi;
    pi := Difference( Set( Factors( Size( G ) ) ), [ 2, 5 ] );
    return NormalClosure( G, HallSubgroup( G, pi ) );
end))
function( a ) ... end
Intersection ([ OrdinaryFormation(rec (
    res := function ( G )
        local  pi;
        pi := Difference( Set( Factors( Size( G ) ) ), [ 2, 5 ] );
        return NormalClosure( G, HallSubgroup( G, pi ) );
    end)), OrdinaryFormation(rec (
    res := function ( G )
        local  pi;
        pi := Difference( Set( Factors( Size( G ) ) ), [ 2, 5 ] );
        return NormalClosure( G, HallSubgroup( G, pi ) );
    end)) ])
function( a ) ... end
Intersection ([ OrdinaryFormation(rec (
    res := function ( G )
        local  pi;
        pi := Difference( Set( Factors( Size( G ) ) ), [ 2, 5 ] );
        return NormalClosure( G, HallSubgroup( G, pi ) );
    end)), FittingClass ( rec (rec (
    rad := function ( G )
        return Core( G, HallSubgroup( G, [ 2, 5 ] ) );
    end))) ])
function( a ) ... end
Intersection ([ OrdinaryFormation(rec (
    res := function ( G )
        local  pi;
        pi := Difference( Set( Factors( Size( G ) ) ), [ 2, 5 ] );
        return NormalClosure( G, HallSubgroup( G, pi ) );
    end)), FittingClass ( rec (rec (
    inj := function ( G )
        return 
         HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( 
                  p )
                  return p in pi;
              end ) );
    end))) ])
function( a ) ... end
Intersection ([ OrdinaryFormation(rec (
    res := function ( G )
        local  pi;
        pi := Difference( Set( Factors( Size( G ) ) ), [ 2, 5 ] );
        return NormalClosure( G, HallSubgroup( G, pi ) );
    end)), SchunckClass (rec (
    proj := function ( G )
        return 
         HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( 
                  p )
                  return p in pi;
              end ) );
    end)) ])
FittingClass (rad:=function( G ) ... end)
FittingClass ( rec (rec (
rad := function ( G )
    return Core( G, HallSubgroup( G, [ 2, 5 ] ) );
end)))
function( a ) ... end
Intersection ([ FittingClass ( rec (rec (
    rad := function ( G )
        return Core( G, HallSubgroup( G, [ 2, 5 ] ) );
    end))), FittingClass ( rec (rec (
    rad := function ( G )
        return Core( G, HallSubgroup( G, [ 2, 5 ] ) );
    end))) ])
function( a ) ... end
Intersection ([ FittingClass ( rec (rec (
    rad := function ( G )
        return Core( G, HallSubgroup( G, [ 2, 5 ] ) );
    end))), FittingClass ( rec (rec (
    inj := function ( G )
        return 
         HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( 
                  p )
                  return p in pi;
              end ) );
    end))) ])
function( a ) ... end
Intersection ([ FittingClass ( rec (rec (
    rad := function ( G )
        return Core( G, HallSubgroup( G, [ 2, 5 ] ) );
    end))), SchunckClass (rec (
    proj := function ( G )
        return 
         HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( 
                  p )
                  return p in pi;
              end ) );
    end)) ])
FittingClass (inj:=function( G ) ... end)
FittingClass ( rec (rec (
inj := function ( G )
    return 
     HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end ) );
end)))
function( a ) ... end
Intersection ([ FittingClass ( rec (rec (
    inj := function ( G )
        return 
         HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( 
                  p )
                  return p in pi;
              end ) );
    end))), FittingClass ( rec (rec (
    inj := function ( G )
        return 
         HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( 
                  p )
                  return p in pi;
              end ) );
    end))) ])
function( a ) ... end
Intersection ([ FittingClass ( rec (rec (
    inj := function ( G )
        return 
         HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( 
                  p )
                  return p in pi;
              end ) );
    end))), SchunckClass (rec (
    proj := function ( G )
        return 
         HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( 
                  p )
                  return p in pi;
              end ) );
    end)) ])
SchunckClass (proj:=function( G ) ... end)
SchunckClass (rec (
proj := function ( G )
    return 
     HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end ) );
end))
function( a ) ... end
Intersection ([ SchunckClass (rec (
    proj := function ( G )
        return 
         HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( 
                  p )
                  return p in pi;
              end ) );
    end)), SchunckClass (rec (
    proj := function ( G )
        return 
         HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( 
                  p )
                  return p in pi;
              end ) );
    end)) ])
FormationProduct (SaturatedFormation (bound:=function( G ) ... end), Saturated\
Formation (bound:=function( G ) ... end))
FormationProduct (SaturatedFormation (rec (
bound := function ( G )
    return not Factors( Size( Socle( G ) ) )[1] in pi;
end)), SaturatedFormation (rec (
bound := function ( G )
    return not Factors( Size( Socle( G ) ) )[1] in pi;
end)))
FormationProduct (SaturatedFormation (bound:=function( G ) ... end), Saturated\
Formation (locdef:=function( G, p ) ... end))
FormationProduct (SaturatedFormation (rec (
bound := function ( G )
    return not Factors( Size( Socle( G ) ) )[1] in pi;
end)), SaturatedFormation (rec (
locdef := function ( G, p )
    if p in pi  then
        return [  ];
    else
        return fail;
    fi;
    return;
end)))
FormationProduct (SaturatedFormation (bound:=function( G ) ... end), OrdinaryF\
ormation (in:=function( G ) ... end))
FormationProduct (SaturatedFormation (rec (
bound := function ( G )
    return not Factors( Size( Socle( G ) ) )[1] in pi;
end)), OrdinaryFormation(rec (
in := function ( G )
    return 
     IsTrivial( G ) or ForAll( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end );
end)))
FormationProduct (SaturatedFormation (bound:=function( G ) ... end), OrdinaryF\
ormation (res:=function( G ) ... end))
FormationProduct (SaturatedFormation (rec (
bound := function ( G )
    return not Factors( Size( Socle( G ) ) )[1] in pi;
end)), OrdinaryFormation(rec (
res := function ( G )
    local  pi;
    pi := Difference( Set( Factors( Size( G ) ) ), [ 2, 5 ] );
    return NormalClosure( G, HallSubgroup( G, pi ) );
end)))
FormationProduct (SaturatedFormation (bound:=function( G ) ... end), FittingFo\
rmation (rad:=function( G ) ... end))
FormationProduct (SaturatedFormation (rec (
bound := function ( G )
    return not Factors( Size( Socle( G ) ) )[1] in pi;
end)), FittingFormation ( rec (
rad := function ( G )
    return Core( G, HallSubgroup( G, [ 2, 5 ] ) );
end)))
FormationProduct (SaturatedFormation (bound:=function( G ) ... end), FittingFo\
rmation (inj:=function( G ) ... end))
FormationProduct (SaturatedFormation (rec (
bound := function ( G )
    return not Factors( Size( Socle( G ) ) )[1] in pi;
end)), FittingFormation ( rec (
inj := function ( G )
    return 
     HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end ) );
end)))
FormationProduct (SaturatedFormation (bound:=function( G ) ... end), Saturated\
Formation (proj:=function( G ) ... end))
FormationProduct (SaturatedFormation (rec (
bound := function ( G )
    return not Factors( Size( Socle( G ) ) )[1] in pi;
end)), SaturatedFormation (rec (
proj := function ( G )
    return 
     HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end ) );
end)))
FormationProduct (SaturatedFormation (locdef:=function( G, p ) ... end), Satur\
atedFormation (bound:=function( G ) ... end))
FormationProduct (SaturatedFormation (rec (
locdef := function ( G, p )
    if p in pi  then
        return [  ];
    else
        return fail;
    fi;
    return;
end)), SaturatedFormation (rec (
bound := function ( G )
    return not Factors( Size( Socle( G ) ) )[1] in pi;
end)))
FormationProduct (SaturatedFormation (locdef:=function( G, p ) ... end), Satur\
atedFormation (locdef:=function( G, p ) ... end))
FormationProduct (SaturatedFormation (rec (
locdef := function ( G, p )
    if p in pi  then
        return [  ];
    else
        return fail;
    fi;
    return;
end)), SaturatedFormation (rec (
locdef := function ( G, p )
    if p in pi  then
        return [  ];
    else
        return fail;
    fi;
    return;
end)))
FormationProduct (SaturatedFormation (locdef:=function( G, p ) ... end), Ordin\
aryFormation (in:=function( G ) ... end))
FormationProduct (SaturatedFormation (rec (
locdef := function ( G, p )
    if p in pi  then
        return [  ];
    else
        return fail;
    fi;
    return;
end)), OrdinaryFormation(rec (
in := function ( G )
    return 
     IsTrivial( G ) or ForAll( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end );
end)))
FormationProduct (SaturatedFormation (locdef:=function( G, p ) ... end), Ordin\
aryFormation (res:=function( G ) ... end))
FormationProduct (SaturatedFormation (rec (
locdef := function ( G, p )
    if p in pi  then
        return [  ];
    else
        return fail;
    fi;
    return;
end)), OrdinaryFormation(rec (
res := function ( G )
    local  pi;
    pi := Difference( Set( Factors( Size( G ) ) ), [ 2, 5 ] );
    return NormalClosure( G, HallSubgroup( G, pi ) );
end)))
FormationProduct (SaturatedFormation (locdef:=function( G, p ) ... end), Fitti\
ngFormation (rad:=function( G ) ... end))
FormationProduct (SaturatedFormation (rec (
locdef := function ( G, p )
    if p in pi  then
        return [  ];
    else
        return fail;
    fi;
    return;
end)), FittingFormation ( rec (
rad := function ( G )
    return Core( G, HallSubgroup( G, [ 2, 5 ] ) );
end)))
FormationProduct (SaturatedFormation (locdef:=function( G, p ) ... end), Fitti\
ngFormation (inj:=function( G ) ... end))
FormationProduct (SaturatedFormation (rec (
locdef := function ( G, p )
    if p in pi  then
        return [  ];
    else
        return fail;
    fi;
    return;
end)), FittingFormation ( rec (
inj := function ( G )
    return 
     HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end ) );
end)))
FormationProduct (SaturatedFormation (locdef:=function( G, p ) ... end), Satur\
atedFormation (proj:=function( G ) ... end))
FormationProduct (SaturatedFormation (rec (
locdef := function ( G, p )
    if p in pi  then
        return [  ];
    else
        return fail;
    fi;
    return;
end)), SaturatedFormation (rec (
proj := function ( G )
    return 
     HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end ) );
end)))
FormationProduct (OrdinaryFormation (in:=function( G ) ... end), SaturatedForm\
ation (bound:=function( G ) ... end))
FormationProduct (OrdinaryFormation(rec (
in := function ( G )
    return 
     IsTrivial( G ) or ForAll( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end );
end)), SaturatedFormation (rec (
bound := function ( G )
    return not Factors( Size( Socle( G ) ) )[1] in pi;
end)))
FormationProduct (OrdinaryFormation (in:=function( G ) ... end), SaturatedForm\
ation (locdef:=function( G, p ) ... end))
FormationProduct (OrdinaryFormation(rec (
in := function ( G )
    return 
     IsTrivial( G ) or ForAll( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end );
end)), SaturatedFormation (rec (
locdef := function ( G, p )
    if p in pi  then
        return [  ];
    else
        return fail;
    fi;
    return;
end)))
FormationProduct (OrdinaryFormation (in:=function( G ) ... end), OrdinaryForma\
tion (in:=function( G ) ... end))
FormationProduct (OrdinaryFormation(rec (
in := function ( G )
    return 
     IsTrivial( G ) or ForAll( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end );
end)), OrdinaryFormation(rec (
in := function ( G )
    return 
     IsTrivial( G ) or ForAll( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end );
end)))
FormationProduct (OrdinaryFormation (in:=function( G ) ... end), OrdinaryForma\
tion (res:=function( G ) ... end))
FormationProduct (OrdinaryFormation(rec (
in := function ( G )
    return 
     IsTrivial( G ) or ForAll( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end );
end)), OrdinaryFormation(rec (
res := function ( G )
    local  pi;
    pi := Difference( Set( Factors( Size( G ) ) ), [ 2, 5 ] );
    return NormalClosure( G, HallSubgroup( G, pi ) );
end)))
FormationProduct (OrdinaryFormation (in:=function( G ) ... end), FittingFormat\
ion (rad:=function( G ) ... end))
FormationProduct (OrdinaryFormation(rec (
in := function ( G )
    return 
     IsTrivial( G ) or ForAll( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end );
end)), FittingFormation ( rec (
rad := function ( G )
    return Core( G, HallSubgroup( G, [ 2, 5 ] ) );
end)))
FormationProduct (OrdinaryFormation (in:=function( G ) ... end), FittingFormat\
ion (inj:=function( G ) ... end))
FormationProduct (OrdinaryFormation(rec (
in := function ( G )
    return 
     IsTrivial( G ) or ForAll( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end );
end)), FittingFormation ( rec (
inj := function ( G )
    return 
     HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end ) );
end)))
FormationProduct (OrdinaryFormation (in:=function( G ) ... end), SaturatedForm\
ation (proj:=function( G ) ... end))
FormationProduct (OrdinaryFormation(rec (
in := function ( G )
    return 
     IsTrivial( G ) or ForAll( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end );
end)), SaturatedFormation (rec (
proj := function ( G )
    return 
     HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end ) );
end)))
FormationProduct (OrdinaryFormation (res:=function( G ) ... end), SaturatedFor\
mation (bound:=function( G ) ... end))
FormationProduct (OrdinaryFormation(rec (
res := function ( G )
    local  pi;
    pi := Difference( Set( Factors( Size( G ) ) ), [ 2, 5 ] );
    return NormalClosure( G, HallSubgroup( G, pi ) );
end)), SaturatedFormation (rec (
bound := function ( G )
    return not Factors( Size( Socle( G ) ) )[1] in pi;
end)))
FormationProduct (OrdinaryFormation (res:=function( G ) ... end), SaturatedFor\
mation (locdef:=function( G, p ) ... end))
FormationProduct (OrdinaryFormation(rec (
res := function ( G )
    local  pi;
    pi := Difference( Set( Factors( Size( G ) ) ), [ 2, 5 ] );
    return NormalClosure( G, HallSubgroup( G, pi ) );
end)), SaturatedFormation (rec (
locdef := function ( G, p )
    if p in pi  then
        return [  ];
    else
        return fail;
    fi;
    return;
end)))
FormationProduct (OrdinaryFormation (res:=function( G ) ... end), OrdinaryForm\
ation (in:=function( G ) ... end))
FormationProduct (OrdinaryFormation(rec (
res := function ( G )
    local  pi;
    pi := Difference( Set( Factors( Size( G ) ) ), [ 2, 5 ] );
    return NormalClosure( G, HallSubgroup( G, pi ) );
end)), OrdinaryFormation(rec (
in := function ( G )
    return 
     IsTrivial( G ) or ForAll( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end );
end)))
FormationProduct (OrdinaryFormation (res:=function( G ) ... end), OrdinaryForm\
ation (res:=function( G ) ... end))
FormationProduct (OrdinaryFormation(rec (
res := function ( G )
    local  pi;
    pi := Difference( Set( Factors( Size( G ) ) ), [ 2, 5 ] );
    return NormalClosure( G, HallSubgroup( G, pi ) );
end)), OrdinaryFormation(rec (
res := function ( G )
    local  pi;
    pi := Difference( Set( Factors( Size( G ) ) ), [ 2, 5 ] );
    return NormalClosure( G, HallSubgroup( G, pi ) );
end)))
FormationProduct (OrdinaryFormation (res:=function( G ) ... end), FittingForma\
tion (rad:=function( G ) ... end))
FormationProduct (OrdinaryFormation(rec (
res := function ( G )
    local  pi;
    pi := Difference( Set( Factors( Size( G ) ) ), [ 2, 5 ] );
    return NormalClosure( G, HallSubgroup( G, pi ) );
end)), FittingFormation ( rec (
rad := function ( G )
    return Core( G, HallSubgroup( G, [ 2, 5 ] ) );
end)))
FormationProduct (OrdinaryFormation (res:=function( G ) ... end), FittingForma\
tion (inj:=function( G ) ... end))
FormationProduct (OrdinaryFormation(rec (
res := function ( G )
    local  pi;
    pi := Difference( Set( Factors( Size( G ) ) ), [ 2, 5 ] );
    return NormalClosure( G, HallSubgroup( G, pi ) );
end)), FittingFormation ( rec (
inj := function ( G )
    return 
     HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end ) );
end)))
FormationProduct (OrdinaryFormation (res:=function( G ) ... end), SaturatedFor\
mation (proj:=function( G ) ... end))
FormationProduct (OrdinaryFormation(rec (
res := function ( G )
    local  pi;
    pi := Difference( Set( Factors( Size( G ) ) ), [ 2, 5 ] );
    return NormalClosure( G, HallSubgroup( G, pi ) );
end)), SaturatedFormation (rec (
proj := function ( G )
    return 
     HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end ) );
end)))
FormationProduct (FittingFormation (rad:=function( G ) ... end), SaturatedForm\
ation (bound:=function( G ) ... end))
FormationProduct (FittingFormation ( rec (
rad := function ( G )
    return Core( G, HallSubgroup( G, [ 2, 5 ] ) );
end)), SaturatedFormation (rec (
bound := function ( G )
    return not Factors( Size( Socle( G ) ) )[1] in pi;
end)))
FormationProduct (FittingFormation (rad:=function( G ) ... end), SaturatedForm\
ation (locdef:=function( G, p ) ... end))
FormationProduct (FittingFormation ( rec (
rad := function ( G )
    return Core( G, HallSubgroup( G, [ 2, 5 ] ) );
end)), SaturatedFormation (rec (
locdef := function ( G, p )
    if p in pi  then
        return [  ];
    else
        return fail;
    fi;
    return;
end)))
FormationProduct (FittingFormation (rad:=function( G ) ... end), OrdinaryForma\
tion (in:=function( G ) ... end))
FormationProduct (FittingFormation ( rec (
rad := function ( G )
    return Core( G, HallSubgroup( G, [ 2, 5 ] ) );
end)), OrdinaryFormation(rec (
in := function ( G )
    return 
     IsTrivial( G ) or ForAll( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end );
end)))
FormationProduct (FittingFormation (rad:=function( G ) ... end), OrdinaryForma\
tion (res:=function( G ) ... end))
FormationProduct (FittingFormation ( rec (
rad := function ( G )
    return Core( G, HallSubgroup( G, [ 2, 5 ] ) );
end)), OrdinaryFormation(rec (
res := function ( G )
    local  pi;
    pi := Difference( Set( Factors( Size( G ) ) ), [ 2, 5 ] );
    return NormalClosure( G, HallSubgroup( G, pi ) );
end)))
FittingFormationProduct (FittingFormation (rad:=function( G ) ... end), Fittin\
gFormation (rad:=function( G ) ... end))
FittingFormationProduct (FittingFormation ( rec (
rad := function ( G )
    return Core( G, HallSubgroup( G, [ 2, 5 ] ) );
end)), FittingFormation ( rec (
rad := function ( G )
    return Core( G, HallSubgroup( G, [ 2, 5 ] ) );
end)))
FittingFormationProduct (FittingFormation (rad:=function( G ) ... end), Fittin\
gFormation (inj:=function( G ) ... end))
FittingFormationProduct (FittingFormation ( rec (
rad := function ( G )
    return Core( G, HallSubgroup( G, [ 2, 5 ] ) );
end)), FittingFormation ( rec (
inj := function ( G )
    return 
     HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end ) );
end)))
FormationProduct (FittingFormation (rad:=function( G ) ... end), SaturatedForm\
ation (proj:=function( G ) ... end))
FormationProduct (FittingFormation ( rec (
rad := function ( G )
    return Core( G, HallSubgroup( G, [ 2, 5 ] ) );
end)), SaturatedFormation (rec (
proj := function ( G )
    return 
     HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end ) );
end)))
FormationProduct (FittingFormation (inj:=function( G ) ... end), SaturatedForm\
ation (bound:=function( G ) ... end))
FormationProduct (FittingFormation ( rec (
inj := function ( G )
    return 
     HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end ) );
end)), SaturatedFormation (rec (
bound := function ( G )
    return not Factors( Size( Socle( G ) ) )[1] in pi;
end)))
FormationProduct (FittingFormation (inj:=function( G ) ... end), SaturatedForm\
ation (locdef:=function( G, p ) ... end))
FormationProduct (FittingFormation ( rec (
inj := function ( G )
    return 
     HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end ) );
end)), SaturatedFormation (rec (
locdef := function ( G, p )
    if p in pi  then
        return [  ];
    else
        return fail;
    fi;
    return;
end)))
FormationProduct (FittingFormation (inj:=function( G ) ... end), OrdinaryForma\
tion (in:=function( G ) ... end))
FormationProduct (FittingFormation ( rec (
inj := function ( G )
    return 
     HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end ) );
end)), OrdinaryFormation(rec (
in := function ( G )
    return 
     IsTrivial( G ) or ForAll( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end );
end)))
FormationProduct (FittingFormation (inj:=function( G ) ... end), OrdinaryForma\
tion (res:=function( G ) ... end))
FormationProduct (FittingFormation ( rec (
inj := function ( G )
    return 
     HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end ) );
end)), OrdinaryFormation(rec (
res := function ( G )
    local  pi;
    pi := Difference( Set( Factors( Size( G ) ) ), [ 2, 5 ] );
    return NormalClosure( G, HallSubgroup( G, pi ) );
end)))
FittingFormationProduct (FittingFormation (inj:=function( G ) ... end), Fittin\
gFormation (rad:=function( G ) ... end))
FittingFormationProduct (FittingFormation ( rec (
inj := function ( G )
    return 
     HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end ) );
end)), FittingFormation ( rec (
rad := function ( G )
    return Core( G, HallSubgroup( G, [ 2, 5 ] ) );
end)))
FittingFormationProduct (FittingFormation (inj:=function( G ) ... end), Fittin\
gFormation (inj:=function( G ) ... end))
FittingFormationProduct (FittingFormation ( rec (
inj := function ( G )
    return 
     HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end ) );
end)), FittingFormation ( rec (
inj := function ( G )
    return 
     HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end ) );
end)))
FormationProduct (FittingFormation (inj:=function( G ) ... end), SaturatedForm\
ation (proj:=function( G ) ... end))
FormationProduct (FittingFormation ( rec (
inj := function ( G )
    return 
     HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end ) );
end)), SaturatedFormation (rec (
proj := function ( G )
    return 
     HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end ) );
end)))
FormationProduct (SaturatedFormation (proj:=function( G ) ... end), SaturatedF\
ormation (bound:=function( G ) ... end))
FormationProduct (SaturatedFormation (rec (
proj := function ( G )
    return 
     HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end ) );
end)), SaturatedFormation (rec (
bound := function ( G )
    return not Factors( Size( Socle( G ) ) )[1] in pi;
end)))
FormationProduct (SaturatedFormation (proj:=function( G ) ... end), SaturatedF\
ormation (locdef:=function( G, p ) ... end))
FormationProduct (SaturatedFormation (rec (
proj := function ( G )
    return 
     HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end ) );
end)), SaturatedFormation (rec (
locdef := function ( G, p )
    if p in pi  then
        return [  ];
    else
        return fail;
    fi;
    return;
end)))
FormationProduct (SaturatedFormation (proj:=function( G ) ... end), OrdinaryFo\
rmation (in:=function( G ) ... end))
FormationProduct (SaturatedFormation (rec (
proj := function ( G )
    return 
     HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end ) );
end)), OrdinaryFormation(rec (
in := function ( G )
    return 
     IsTrivial( G ) or ForAll( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end );
end)))
FormationProduct (SaturatedFormation (proj:=function( G ) ... end), OrdinaryFo\
rmation (res:=function( G ) ... end))
FormationProduct (SaturatedFormation (rec (
proj := function ( G )
    return 
     HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end ) );
end)), OrdinaryFormation(rec (
res := function ( G )
    local  pi;
    pi := Difference( Set( Factors( Size( G ) ) ), [ 2, 5 ] );
    return NormalClosure( G, HallSubgroup( G, pi ) );
end)))
FormationProduct (SaturatedFormation (proj:=function( G ) ... end), FittingFor\
mation (rad:=function( G ) ... end))
FormationProduct (SaturatedFormation (rec (
proj := function ( G )
    return 
     HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end ) );
end)), FittingFormation ( rec (
rad := function ( G )
    return Core( G, HallSubgroup( G, [ 2, 5 ] ) );
end)))
FormationProduct (SaturatedFormation (proj:=function( G ) ... end), FittingFor\
mation (inj:=function( G ) ... end))
FormationProduct (SaturatedFormation (rec (
proj := function ( G )
    return 
     HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end ) );
end)), FittingFormation ( rec (
inj := function ( G )
    return 
     HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end ) );
end)))
FormationProduct (SaturatedFormation (proj:=function( G ) ... end), SaturatedF\
ormation (proj:=function( G ) ... end))
FormationProduct (SaturatedFormation (rec (
proj := function ( G )
    return 
     HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end ) );
end)), SaturatedFormation (rec (
proj := function ( G )
    return 
     HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end ) );
end)))
FittingProduct (SchunckClass (bound:=function( G ) ... end), SchunckClass (bou\
nd:=function( G ) ... end))
FittingProduct (SchunckClass (rec (
bound := function ( G )
    return not Factors( Size( Socle( G ) ) )[1] in pi;
end)), SchunckClass (rec (
bound := function ( G )
    return not Factors( Size( Socle( G ) ) )[1] in pi;
end)))
FittingProduct (SchunckClass (bound:=function( G ) ... end), SaturatedFittingF\
ormation (locdef:=function( G, p ) ... end))
FittingProduct (SchunckClass (rec (
bound := function ( G )
    return not Factors( Size( Socle( G ) ) )[1] in pi;
end)), SaturatedFittingFormation (rec (
locdef := function ( G, p )
    if p in pi  then
        return [  ];
    else
        return fail;
    fi;
    return;
end)))
FittingProduct (SchunckClass (bound:=function( G ) ... end), FittingClass (in:\
=function( G ) ... end))
FittingProduct (SchunckClass (rec (
bound := function ( G )
    return not Factors( Size( Socle( G ) ) )[1] in pi;
end)), FittingClass ( rec (rec (
in := function ( G )
    return 
     IsTrivial( G ) or ForAll( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end );
end))))
FittingProduct (SchunckClass (bound:=function( G ) ... end), FittingFormation \
(res:=function( G ) ... end))
FittingProduct (SchunckClass (rec (
bound := function ( G )
    return not Factors( Size( Socle( G ) ) )[1] in pi;
end)), FittingFormation ( rec (
res := function ( G )
    local  pi;
    pi := Difference( Set( Factors( Size( G ) ) ), [ 2, 5 ] );
    return NormalClosure( G, HallSubgroup( G, pi ) );
end)))
FittingProduct (SchunckClass (bound:=function( G ) ... end), FittingClass (rad\
:=function( G ) ... end))
FittingProduct (SchunckClass (rec (
bound := function ( G )
    return not Factors( Size( Socle( G ) ) )[1] in pi;
end)), FittingClass ( rec (rec (
rad := function ( G )
    return Core( G, HallSubgroup( G, [ 2, 5 ] ) );
end))))
FittingProduct (SchunckClass (bound:=function( G ) ... end), FittingClass (inj\
:=function( G ) ... end))
FittingProduct (SchunckClass (rec (
bound := function ( G )
    return not Factors( Size( Socle( G ) ) )[1] in pi;
end)), FittingClass ( rec (rec (
inj := function ( G )
    return 
     HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end ) );
end))))
FittingProduct (SchunckClass (bound:=function( G ) ... end), SchunckClass (pro\
j:=function( G ) ... end))
FittingProduct (SchunckClass (rec (
bound := function ( G )
    return not Factors( Size( Socle( G ) ) )[1] in pi;
end)), SchunckClass (rec (
proj := function ( G )
    return 
     HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end ) );
end)))
FittingProduct (SaturatedFittingFormation (locdef:=function( G, p ) ... end), \
SchunckClass (bound:=function( G ) ... end))
FittingProduct (SaturatedFittingFormation (rec (
locdef := function ( G, p )
    if p in pi  then
        return [  ];
    else
        return fail;
    fi;
    return;
end)), SchunckClass (rec (
bound := function ( G )
    return not Factors( Size( Socle( G ) ) )[1] in pi;
end)))
FittingFormationProduct (SaturatedFittingFormation (locdef:=function( G, p ) .\
.. end), SaturatedFittingFormation (locdef:=function( G, p ) ... end))
FittingFormationProduct (SaturatedFittingFormation (rec (
locdef := function ( G, p )
    if p in pi  then
        return [  ];
    else
        return fail;
    fi;
    return;
end)), SaturatedFittingFormation (rec (
locdef := function ( G, p )
    if p in pi  then
        return [  ];
    else
        return fail;
    fi;
    return;
end)))
FittingProduct (SaturatedFittingFormation (locdef:=function( G, p ) ... end), \
FittingClass (in:=function( G ) ... end))
FittingProduct (SaturatedFittingFormation (rec (
locdef := function ( G, p )
    if p in pi  then
        return [  ];
    else
        return fail;
    fi;
    return;
end)), FittingClass ( rec (rec (
in := function ( G )
    return 
     IsTrivial( G ) or ForAll( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end );
end))))
FittingFormationProduct (SaturatedFittingFormation (locdef:=function( G, p ) .\
.. end), FittingFormation (res:=function( G ) ... end))
FittingFormationProduct (SaturatedFittingFormation (rec (
locdef := function ( G, p )
    if p in pi  then
        return [  ];
    else
        return fail;
    fi;
    return;
end)), FittingFormation ( rec (
res := function ( G )
    local  pi;
    pi := Difference( Set( Factors( Size( G ) ) ), [ 2, 5 ] );
    return NormalClosure( G, HallSubgroup( G, pi ) );
end)))
FittingProduct (SaturatedFittingFormation (locdef:=function( G, p ) ... end), \
FittingClass (rad:=function( G ) ... end))
FittingProduct (SaturatedFittingFormation (rec (
locdef := function ( G, p )
    if p in pi  then
        return [  ];
    else
        return fail;
    fi;
    return;
end)), FittingClass ( rec (rec (
rad := function ( G )
    return Core( G, HallSubgroup( G, [ 2, 5 ] ) );
end))))
FittingProduct (SaturatedFittingFormation (locdef:=function( G, p ) ... end), \
FittingClass (inj:=function( G ) ... end))
FittingProduct (SaturatedFittingFormation (rec (
locdef := function ( G, p )
    if p in pi  then
        return [  ];
    else
        return fail;
    fi;
    return;
end)), FittingClass ( rec (rec (
inj := function ( G )
    return 
     HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end ) );
end))))
FittingProduct (SaturatedFittingFormation (locdef:=function( G, p ) ... end), \
SchunckClass (proj:=function( G ) ... end))
FittingProduct (SaturatedFittingFormation (rec (
locdef := function ( G, p )
    if p in pi  then
        return [  ];
    else
        return fail;
    fi;
    return;
end)), SchunckClass (rec (
proj := function ( G )
    return 
     HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end ) );
end)))
FittingProduct (FittingClass (in:=function( G ) ... end), SchunckClass (bound:\
=function( G ) ... end))
FittingProduct (FittingClass ( rec (rec (
in := function ( G )
    return 
     IsTrivial( G ) or ForAll( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end );
end))), SchunckClass (rec (
bound := function ( G )
    return not Factors( Size( Socle( G ) ) )[1] in pi;
end)))
FittingProduct (FittingClass (in:=function( G ) ... end), SaturatedFittingForm\
ation (locdef:=function( G, p ) ... end))
FittingProduct (FittingClass ( rec (rec (
in := function ( G )
    return 
     IsTrivial( G ) or ForAll( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end );
end))), SaturatedFittingFormation (rec (
locdef := function ( G, p )
    if p in pi  then
        return [  ];
    else
        return fail;
    fi;
    return;
end)))
FittingProduct (FittingClass (in:=function( G ) ... end), FittingClass (in:=fu\
nction( G ) ... end))
FittingProduct (FittingClass ( rec (rec (
in := function ( G )
    return 
     IsTrivial( G ) or ForAll( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end );
end))), FittingClass ( rec (rec (
in := function ( G )
    return 
     IsTrivial( G ) or ForAll( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end );
end))))
FittingProduct (FittingClass (in:=function( G ) ... end), FittingFormation (re\
s:=function( G ) ... end))
FittingProduct (FittingClass ( rec (rec (
in := function ( G )
    return 
     IsTrivial( G ) or ForAll( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end );
end))), FittingFormation ( rec (
res := function ( G )
    local  pi;
    pi := Difference( Set( Factors( Size( G ) ) ), [ 2, 5 ] );
    return NormalClosure( G, HallSubgroup( G, pi ) );
end)))
FittingProduct (FittingClass (in:=function( G ) ... end), FittingClass (rad:=f\
unction( G ) ... end))
FittingProduct (FittingClass ( rec (rec (
in := function ( G )
    return 
     IsTrivial( G ) or ForAll( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end );
end))), FittingClass ( rec (rec (
rad := function ( G )
    return Core( G, HallSubgroup( G, [ 2, 5 ] ) );
end))))
FittingProduct (FittingClass (in:=function( G ) ... end), FittingClass (inj:=f\
unction( G ) ... end))
FittingProduct (FittingClass ( rec (rec (
in := function ( G )
    return 
     IsTrivial( G ) or ForAll( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end );
end))), FittingClass ( rec (rec (
inj := function ( G )
    return 
     HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end ) );
end))))
FittingProduct (FittingClass (in:=function( G ) ... end), SchunckClass (proj:=\
function( G ) ... end))
FittingProduct (FittingClass ( rec (rec (
in := function ( G )
    return 
     IsTrivial( G ) or ForAll( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end );
end))), SchunckClass (rec (
proj := function ( G )
    return 
     HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end ) );
end)))
FittingProduct (FittingFormation (res:=function( G ) ... end), SchunckClass (b\
ound:=function( G ) ... end))
FittingProduct (FittingFormation ( rec (
res := function ( G )
    local  pi;
    pi := Difference( Set( Factors( Size( G ) ) ), [ 2, 5 ] );
    return NormalClosure( G, HallSubgroup( G, pi ) );
end)), SchunckClass (rec (
bound := function ( G )
    return not Factors( Size( Socle( G ) ) )[1] in pi;
end)))
FittingFormationProduct (FittingFormation (res:=function( G ) ... end), Satura\
tedFittingFormation (locdef:=function( G, p ) ... end))
FittingFormationProduct (FittingFormation ( rec (
res := function ( G )
    local  pi;
    pi := Difference( Set( Factors( Size( G ) ) ), [ 2, 5 ] );
    return NormalClosure( G, HallSubgroup( G, pi ) );
end)), SaturatedFittingFormation (rec (
locdef := function ( G, p )
    if p in pi  then
        return [  ];
    else
        return fail;
    fi;
    return;
end)))
FittingProduct (FittingFormation (res:=function( G ) ... end), FittingClass (i\
n:=function( G ) ... end))
FittingProduct (FittingFormation ( rec (
res := function ( G )
    local  pi;
    pi := Difference( Set( Factors( Size( G ) ) ), [ 2, 5 ] );
    return NormalClosure( G, HallSubgroup( G, pi ) );
end)), FittingClass ( rec (rec (
in := function ( G )
    return 
     IsTrivial( G ) or ForAll( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end );
end))))
FittingFormationProduct (FittingFormation (res:=function( G ) ... end), Fittin\
gFormation (res:=function( G ) ... end))
FittingFormationProduct (FittingFormation ( rec (
res := function ( G )
    local  pi;
    pi := Difference( Set( Factors( Size( G ) ) ), [ 2, 5 ] );
    return NormalClosure( G, HallSubgroup( G, pi ) );
end)), FittingFormation ( rec (
res := function ( G )
    local  pi;
    pi := Difference( Set( Factors( Size( G ) ) ), [ 2, 5 ] );
    return NormalClosure( G, HallSubgroup( G, pi ) );
end)))
FittingProduct (FittingFormation (res:=function( G ) ... end), FittingClass (r\
ad:=function( G ) ... end))
FittingProduct (FittingFormation ( rec (
res := function ( G )
    local  pi;
    pi := Difference( Set( Factors( Size( G ) ) ), [ 2, 5 ] );
    return NormalClosure( G, HallSubgroup( G, pi ) );
end)), FittingClass ( rec (rec (
rad := function ( G )
    return Core( G, HallSubgroup( G, [ 2, 5 ] ) );
end))))
FittingProduct (FittingFormation (res:=function( G ) ... end), FittingClass (i\
nj:=function( G ) ... end))
FittingProduct (FittingFormation ( rec (
res := function ( G )
    local  pi;
    pi := Difference( Set( Factors( Size( G ) ) ), [ 2, 5 ] );
    return NormalClosure( G, HallSubgroup( G, pi ) );
end)), FittingClass ( rec (rec (
inj := function ( G )
    return 
     HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end ) );
end))))
FittingProduct (FittingFormation (res:=function( G ) ... end), SchunckClass (p\
roj:=function( G ) ... end))
FittingProduct (FittingFormation ( rec (
res := function ( G )
    local  pi;
    pi := Difference( Set( Factors( Size( G ) ) ), [ 2, 5 ] );
    return NormalClosure( G, HallSubgroup( G, pi ) );
end)), SchunckClass (rec (
proj := function ( G )
    return 
     HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end ) );
end)))
FittingProduct (FittingClass (rad:=function( G ) ... end), SchunckClass (bound\
:=function( G ) ... end))
FittingProduct (FittingClass ( rec (rec (
rad := function ( G )
    return Core( G, HallSubgroup( G, [ 2, 5 ] ) );
end))), SchunckClass (rec (
bound := function ( G )
    return not Factors( Size( Socle( G ) ) )[1] in pi;
end)))
FittingProduct (FittingClass (rad:=function( G ) ... end), SaturatedFittingFor\
mation (locdef:=function( G, p ) ... end))
FittingProduct (FittingClass ( rec (rec (
rad := function ( G )
    return Core( G, HallSubgroup( G, [ 2, 5 ] ) );
end))), SaturatedFittingFormation (rec (
locdef := function ( G, p )
    if p in pi  then
        return [  ];
    else
        return fail;
    fi;
    return;
end)))
FittingProduct (FittingClass (rad:=function( G ) ... end), FittingClass (in:=f\
unction( G ) ... end))
FittingProduct (FittingClass ( rec (rec (
rad := function ( G )
    return Core( G, HallSubgroup( G, [ 2, 5 ] ) );
end))), FittingClass ( rec (rec (
in := function ( G )
    return 
     IsTrivial( G ) or ForAll( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end );
end))))
FittingProduct (FittingClass (rad:=function( G ) ... end), FittingFormation (r\
es:=function( G ) ... end))
FittingProduct (FittingClass ( rec (rec (
rad := function ( G )
    return Core( G, HallSubgroup( G, [ 2, 5 ] ) );
end))), FittingFormation ( rec (
res := function ( G )
    local  pi;
    pi := Difference( Set( Factors( Size( G ) ) ), [ 2, 5 ] );
    return NormalClosure( G, HallSubgroup( G, pi ) );
end)))
FittingProduct (FittingClass (rad:=function( G ) ... end), FittingClass (rad:=\
function( G ) ... end))
FittingProduct (FittingClass ( rec (rec (
rad := function ( G )
    return Core( G, HallSubgroup( G, [ 2, 5 ] ) );
end))), FittingClass ( rec (rec (
rad := function ( G )
    return Core( G, HallSubgroup( G, [ 2, 5 ] ) );
end))))
FittingProduct (FittingClass (rad:=function( G ) ... end), FittingClass (inj:=\
function( G ) ... end))
FittingProduct (FittingClass ( rec (rec (
rad := function ( G )
    return Core( G, HallSubgroup( G, [ 2, 5 ] ) );
end))), FittingClass ( rec (rec (
inj := function ( G )
    return 
     HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end ) );
end))))
FittingProduct (FittingClass (rad:=function( G ) ... end), SchunckClass (proj:\
=function( G ) ... end))
FittingProduct (FittingClass ( rec (rec (
rad := function ( G )
    return Core( G, HallSubgroup( G, [ 2, 5 ] ) );
end))), SchunckClass (rec (
proj := function ( G )
    return 
     HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end ) );
end)))
FittingProduct (FittingClass (inj:=function( G ) ... end), SchunckClass (bound\
:=function( G ) ... end))
FittingProduct (FittingClass ( rec (rec (
inj := function ( G )
    return 
     HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end ) );
end))), SchunckClass (rec (
bound := function ( G )
    return not Factors( Size( Socle( G ) ) )[1] in pi;
end)))
FittingProduct (FittingClass (inj:=function( G ) ... end), SaturatedFittingFor\
mation (locdef:=function( G, p ) ... end))
FittingProduct (FittingClass ( rec (rec (
inj := function ( G )
    return 
     HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end ) );
end))), SaturatedFittingFormation (rec (
locdef := function ( G, p )
    if p in pi  then
        return [  ];
    else
        return fail;
    fi;
    return;
end)))
FittingProduct (FittingClass (inj:=function( G ) ... end), FittingClass (in:=f\
unction( G ) ... end))
FittingProduct (FittingClass ( rec (rec (
inj := function ( G )
    return 
     HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end ) );
end))), FittingClass ( rec (rec (
in := function ( G )
    return 
     IsTrivial( G ) or ForAll( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end );
end))))
FittingProduct (FittingClass (inj:=function( G ) ... end), FittingFormation (r\
es:=function( G ) ... end))
FittingProduct (FittingClass ( rec (rec (
inj := function ( G )
    return 
     HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end ) );
end))), FittingFormation ( rec (
res := function ( G )
    local  pi;
    pi := Difference( Set( Factors( Size( G ) ) ), [ 2, 5 ] );
    return NormalClosure( G, HallSubgroup( G, pi ) );
end)))
FittingProduct (FittingClass (inj:=function( G ) ... end), FittingClass (rad:=\
function( G ) ... end))
FittingProduct (FittingClass ( rec (rec (
inj := function ( G )
    return 
     HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end ) );
end))), FittingClass ( rec (rec (
rad := function ( G )
    return Core( G, HallSubgroup( G, [ 2, 5 ] ) );
end))))
FittingProduct (FittingClass (inj:=function( G ) ... end), FittingClass (inj:=\
function( G ) ... end))
FittingProduct (FittingClass ( rec (rec (
inj := function ( G )
    return 
     HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end ) );
end))), FittingClass ( rec (rec (
inj := function ( G )
    return 
     HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end ) );
end))))
FittingProduct (FittingClass (inj:=function( G ) ... end), SchunckClass (proj:\
=function( G ) ... end))
FittingProduct (FittingClass ( rec (rec (
inj := function ( G )
    return 
     HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end ) );
end))), SchunckClass (rec (
proj := function ( G )
    return 
     HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end ) );
end)))
FittingProduct (SchunckClass (proj:=function( G ) ... end), SchunckClass (boun\
d:=function( G ) ... end))
FittingProduct (SchunckClass (rec (
proj := function ( G )
    return 
     HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end ) );
end)), SchunckClass (rec (
bound := function ( G )
    return not Factors( Size( Socle( G ) ) )[1] in pi;
end)))
FittingProduct (SchunckClass (proj:=function( G ) ... end), SaturatedFittingFo\
rmation (locdef:=function( G, p ) ... end))
FittingProduct (SchunckClass (rec (
proj := function ( G )
    return 
     HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end ) );
end)), SaturatedFittingFormation (rec (
locdef := function ( G, p )
    if p in pi  then
        return [  ];
    else
        return fail;
    fi;
    return;
end)))
FittingProduct (SchunckClass (proj:=function( G ) ... end), FittingClass (in:=\
function( G ) ... end))
FittingProduct (SchunckClass (rec (
proj := function ( G )
    return 
     HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end ) );
end)), FittingClass ( rec (rec (
in := function ( G )
    return 
     IsTrivial( G ) or ForAll( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end );
end))))
FittingProduct (SchunckClass (proj:=function( G ) ... end), FittingFormation (\
res:=function( G ) ... end))
FittingProduct (SchunckClass (rec (
proj := function ( G )
    return 
     HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end ) );
end)), FittingFormation ( rec (
res := function ( G )
    local  pi;
    pi := Difference( Set( Factors( Size( G ) ) ), [ 2, 5 ] );
    return NormalClosure( G, HallSubgroup( G, pi ) );
end)))
FittingProduct (SchunckClass (proj:=function( G ) ... end), FittingClass (rad:\
=function( G ) ... end))
FittingProduct (SchunckClass (rec (
proj := function ( G )
    return 
     HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end ) );
end)), FittingClass ( rec (rec (
rad := function ( G )
    return Core( G, HallSubgroup( G, [ 2, 5 ] ) );
end))))
FittingProduct (SchunckClass (proj:=function( G ) ... end), FittingClass (inj:\
=function( G ) ... end))
FittingProduct (SchunckClass (rec (
proj := function ( G )
    return 
     HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end ) );
end)), FittingClass ( rec (rec (
inj := function ( G )
    return 
     HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end ) );
end))))
FittingProduct (SchunckClass (proj:=function( G ) ... end), SchunckClass (proj\
:=function( G ) ... end))
FittingProduct (SchunckClass (rec (
proj := function ( G )
    return 
     HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end ) );
end)), SchunckClass (rec (
proj := function ( G )
    return 
     HallSubgroup( G, Filtered( Set( Factors( Size( G ) ) ), function ( p )
              return p in pi;
          end ) );
end)))
true
gap> ReadPackage ("crisp", "tst/basis.g");
true
gap> ReadPackage ("crisp", "tst/boundary.g");
true
gap> ReadPackage ("crisp", "tst/char.g");
true
gap> ReadPackage ("crisp", "tst/in.g");
true
gap> ReadPackage ("crisp", "tst/injectors.g");
true
gap> ReadPackage ("crisp", "tst/normals.g");
true
gap> ReadPackage ("crisp", "tst/projectors.g");
true
gap> ReadPackage ("crisp", "tst/radicals.g");
true
gap> ReadPackage ("crisp", "tst/residuals.g");
true
gap> ReadPackage ("crisp", "tst/socle.g");
true
