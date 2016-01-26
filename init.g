############################################################################
##
##  init.g                          CRISP                   Burkhard Höfling
##
##  Copyright (C) 2000, 2016 by Burkhard Höfling
##

BindGlobal ("CRISP_Read", function (path)
    if not ReadPackage("crisp", path) then
        Error("CRISP package: Can't read file ",path, ". The package may be damaged");
    fi;
end);

CRISP_Read("lib/classes.gd");
CRISP_Read("lib/grpclass.gd");
CRISP_Read("lib/fitting.gd");
CRISP_Read("lib/schunck.gd");
CRISP_Read("lib/form.gd");
CRISP_Read("lib/projector.gd");
CRISP_Read("lib/injector.gd");
CRISP_Read("lib/normpro.gd");
CRISP_Read("lib/solveeq.gd");
CRISP_Read("lib/compl.gd");
CRISP_Read("lib/radical.gd");
CRISP_Read("lib/residual.gd");
CRISP_Read("lib/util.gd");
CRISP_Read("lib/samples.gd");
CRISP_Read("lib/socle.gd");


############################################################################
##
#E
##