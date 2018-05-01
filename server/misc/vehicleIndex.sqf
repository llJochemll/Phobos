params["_unit"];

_vehicle = vehicle _unit;

_index = [-1,0];

if (!isNull objectParent _unit) then {
    switch((assignedVehicleRole _unit) select 0)do{
        case "Driver": { 
            _index set [0,0];
        };
        case "Commander": { 
            _index set [0,1];
        };
        case "Gunner": { 
            _index set [0,2];
        };
        case "Turret": { 
            _index set [0,3];
            _index set [1,(assignedVehicleRole _unit )select 1];
        };
        default{
            _index = [5,0];
        };
    };
};

_index