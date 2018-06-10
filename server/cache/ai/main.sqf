//[vehicleId, position, class, object, damage, direction, variables]
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

{
    _id = _x;
    vehicleArray deleteAt (vehicleArray findIf {_x select 0 == _id});
    [_id, {vehicleArray deleteAt (unitArray findIf {_x select 0 == _this});}] remoteExecCall ["BIS_fnc_call", 0];
} forEach vehicleArrayDelete;
vehicleArrayDelete = [];

{
    _id = _x;
    unitArray deleteAt (unitArray findIf {_x select 0 == _id});
    [_id, {unitArray deleteAt (unitArray findIf {_x select 0 == _this});}] remoteExecCall ["BIS_fnc_call", 0];
} forEach unitArrayDelete;
unitArrayDelete = [];

_realVehicles = [];
{
    _realVehicles pushBackUnique ([_x] call Phobos_commonId);
} forEach vehicles;
_realVehicles = _realVehicles - [-1];

[0, _playerPositions, _realVehicles] call Phobos_cacheAiUnit;
[0, _playerPositions] call Phobos_cacheAiVehicle;