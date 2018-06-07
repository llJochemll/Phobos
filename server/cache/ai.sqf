/////////////////////////
//Script made by Jochem//
/////////////////////////
//virtualizing
//[unitId, groupId, position, vehicle, class, object, damage, skill, side, behaviour, waypoints, variables]
//[vehicleId, position, class, object, damage, direction, variables]
_playerPositions = [];
{
    _pos = getPosATL _x;
    if (count (_playerPositions select {_x distance2D _pos < 100}) == 0) then {
        _playerPositions pushBack _pos;
    };
} forEach (allPlayers select {typeOf (vehicle _x) != "plane"});

{
    vehicleArray deleteAt _x;
    [_x, {vehicleArray deleteAt _this;}] remoteExecCall ["BIS_fnc_call", -clientOwner];
} forEach vehicleArrayDelete;
vehicleArrayDelete = [];

{
    unitArray deleteAt _x;
    [_x, {unitArray deleteAt _this;}] remoteExecCall ["BIS_fnc_call", -clientOwner];
} forEach unitArrayDelete;
unitArrayDelete = [];

//vehicleArray
{
    _pos = _x select 1;
    if (isNull (_x select 3)) then {
        if (count (_playerPositions select {_x distance2D _pos < 1100}) != 0) then {
            _vehicle = createVehicle [_x select 2, _x select 1, [], 0, "CAN_COLLIDE"];
            [_vehicle, _x select 0] call Phobos_commonId;
            _vehicle setPosATL (_x select 1);
            _vehicle setDamage (_x select 4);
            _vehicle setDir (_x select 5);
            _x set [3, _vehicle];
            
            [[_forEachIndex, _x], {vehicleArray set [_this select 0, _this select 1];}] remoteExecCall ["BIS_fnc_call", 0];
        };
    } else {
        _id = _x select 0;
        _vehicle = _x select 3;
        if (alive _vehicle) then {
            _x set [1, getPosATL _vehicle];
            _x set [4, damage _vehicle];
            _x set [5, getDir _vehicle];
            if (count (_playerPositions select {_x distance2D _pos < 1100}) == 0) then {
                _x set [2, typeOf _vehicle];
                deleteVehicle _vehicle;
            };

            [[_forEachIndex, _x], {vehicleArray set [_this select 0, _this select 1];}] remoteExecCall ["BIS_fnc_call", 0];
        } else {
            vehicleArrayDelete pushBack _forEachIndex;
        };
    };
} forEach vehicleArray;

//unitArray
for "_i" from 0 to (count unitArray) step 100 do {
    [{
        params [""];
        {
            deleteGroup _x;
        } forEach (allGroups select {count (units _x) == 0 && side _x != west});

        _playerPositions = [];
        {
            _pos = getPosATL _x;
            if (count (_playerPositions select {_x distance2D _pos < 100}) == 0) then {
                _playerPositions pushBack _pos;
            };
        } forEach (allPlayers select {typeOf (vehicle _x) != "plane"});

        _realVehicles = [];
        {
            _realVehicles pushBackUnique ([_x] call Phobos_commonId);
        } forEach vehicles;
        _realVehicles = _realVehicles - [-1];
        
        {
            _pos = _x select 2;
            if (isNull (_x select 5)) then {
                if (count (_playerPositions select {_x distance2D _pos < 1100}) != 0 || (((_x select 3) select 0) in _realVehicles && ((_x select 3) select 0) != -1)) then {
                    _group = grpNull;
                    if (isNil {[_x select 1] call Phobos_commonGet}) then {
                        _group = createGroup (_x select 8);
                        [_group, _x select 1] call Phobos_commonId;

                        {
                            _waypoint = _group addWaypoint [_x select 12, _x select 4];
                            if (_x select 0 != -1) then {
                                _waypoint waypointAttachObject [_x select 0] call Phobos_commonGet;
                            };
                            if (_x select 1 != -1) then {
                                _waypoint waypointAttachVehicle [_x select 1] call Phobos_commonGet;
                            };
                            _waypoint setWaypointBehaviour (_x select 2); 
                            _waypoint setWaypointCombatMode (_x select 3); 
                            _waypoint setWaypointCompletionRadius (_x select 4);
                            _waypoint setWaypointDescription (_x select 5);
                            _waypoint setWaypointForceBehaviour (_x select 6);
                            _waypoint setWaypointFormation (_x select 7);
                            _waypoint setWaypointHousePosition (_x select 8);
                            _waypoint setWaypointLoiterRadius (_x select 9);
                            _waypoint setWaypointLoiterType (_x select 10);
                            _waypoint setWaypointName (_x select 11);
                            _waypoint setWaypointPosition [(_x select 12), 0];
                            _waypoint setWaypointScript (_x select 13);
                            _waypoint setWaypointSpeed (_x select 14);
                            _waypoint setWaypointStatements (_x select 15);
                            _waypoint setWaypointTimeout (_x select 16);
                            _waypoint setWaypointType (_x select 17);
                            _waypoint setWaypointVisible (_x select 18);
                        } forEach (_x select 10);
                    } else {
                        _group = [_x select 1] call Phobos_commonGet;
                    };

                    //Create unit
                    _unit = _group createUnit [_x select 4, [0, 0, 0], [], 0, "CAN_COLLIDE"];
                    [_unit, _x select 0] call Phobos_commonId;
                    [_unit] joinSilent _group;
                    _unit setPosATL (_x select 2);
                    _unit setDamage (_x select 6);

                    {
                        _unit setVariable [_x select 0, _x select 1, true];
                    } forEach (_x select 11);
                    
                    _x set [5, _unit];

                    //Vehicle (0:driver 1:commander 2:gunner)
                    if (((_x select 3) select 0) in _realVehicles) then {
                        _vehicle = [(_x select 3) select 0] call Phobos_commonGet;
                        switch(((_x select 3) select 1) select 0)do{
                            case 0:{
                                _unit assignAsDriver _vehicle;
                                _unit moveInDriver _vehicle;
                            };
                            case 1:{
                                _unit assignAsCommander _vehicle;
                                _unit moveInCommander _vehicle;
                            };
                            case 2:{
                                _unit assignAsGunner _vehicle;
                                _unit moveInGunner _vehicle;
                            };
                            case 3:{
                                _unit assignAsTurret [_vehicle, ((_x select 3) select 1) select 1];
                                _unit moveInTurret [_vehicle, ((_x select 3) select 1) select 1];
                            };
                            case 4:{
                                _unit assignAsCargo _vehicle;
                                _unit moveInCargo [_vehicle, ((_x select 3) select 1) select 1];
                            };
                            case 5:{
                                _unit moveInAny _vehicle;
                            };
                            default {
                                _unit moveInAny _vehicle;
                            };
                        };
                    };

                    [_unit] call Phobos_aiInitUnit;

                    [[_forEachIndex + (_this select 1), _x], {unitArray set [(_this select 0), _this select 1];}] remoteExecCall ["BIS_fnc_call", 0];
                };
            } else {
                _unit = _x select 5;
                if (alive _unit) then {
                    _x set [1, [group _unit] call Phobos_commonId];
                    _x set [2, getPosATL _unit];
                    if (!isNull objectParent _unit) then {
                        _x set [3, [[vehicle _unit] call Phobos_commonId, [_unit] call Phobos_miscVehicleIndex]];
                    };

                    _x set [6, damage _unit];
                    _x set [7, skill _unit];
                    _x set [8, side _unit];
                    _x set [9, behaviour _unit];
                    _waypoints = [];
                    if (count (waypoints _unit) > 1) then {
                        {
                            _waypoints pushBack [
                                [waypointAttachedObject _x] call Phobos_commonId,
                                [waypointAttachedVehicle _x] call Phobos_commonId,
                                waypointBehaviour _x, 
                                waypointCombatMode _x, 
                                waypointCompletionRadius _x,
                                waypointDescription _x,
                                waypointForceBehaviour _x,
                                waypointFormation _x,
                                waypointHousePosition _x,
                                waypointLoiterRadius _x,
                                waypointLoiterType _x,
                                waypointName _x,
                                waypointPosition _x,
                                waypointScript _x,
                                waypointSpeed _x,
                                waypointStatements _x,
                                waypointTimeout _x,
                                waypointType _x,
                                waypointVisible _x
                            ];
                        } forEach ((waypoints _unit) select [1, count (waypoints _unit)]);
                    };
                    _x set [10, _waypoints];

                    _variables = [];
                    {
                        _variables pushBack [_x, _unit getVariable [_x, nil]];
                    } forEach (allVariables _unit);
                    _x set [11, _variables];

                    if (count (_playerPositions select {_x distance2D _pos < 1100}) == 0 && !(((_x select 3) select 0) in _realVehicles)) then {
                        _x set [4, typeOf _unit];
                        deleteVehicle _unit;
                    };

                    [[_forEachIndex + (_this select 1), _x], {unitArray set [(_this select 0), _this select 1];}] remoteExecCall ["BIS_fnc_call", 0];
                } else {
                    unitArrayDelete pushBack (_forEachIndex + (_this select 1));
                };    
            };
        } forEach (_this select 0);
        //hint (format ["%1=%2",(_this select 1), count (_this select 0)]);
    }, [unitArray select [_i, 100], _i], _i / 100] call CBA_fnc_waitAndExecute;
};
