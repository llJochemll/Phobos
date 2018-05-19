params ["_type", "_pos", "_dir"];

_vehicleId = phobosId;
[vehicleArray, [_vehicleId, _pos, _type, true, 0, _dir, []]] remoteExecCall ["pushBack", 0];
[[_vehicleId, _pos, _type, true, 0, _dir, []], {vehicleArray pushBack _this;}] remoteExecCall ["BIS_fnc_call", 0];
phobosId = phobosId + 1;

publicVariable "phobosId";

_vehicleId