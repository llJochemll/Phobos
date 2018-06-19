params ["_type", "_pos", "_dir"];

_vehicleId = [] call Phobos_commonNewId;
[[_vehicleId, _pos, _type, objNull, 0, _dir, []], {vehicleArray pushBack _this;}] remoteExecCall ["BIS_fnc_call", 0];

_vehicleId