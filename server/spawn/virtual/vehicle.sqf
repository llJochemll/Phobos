params ["_type", "_pos", "_dir"];

_vehicleId = phobosId;
[vehicleArray, [_vehicleId, _pos, _type, true, 0, _dir, []]] remoteExecCall ["pushBack", 0];
phobosId = phobosId + 1;

publicVariable "phobosId";

_vehicleId