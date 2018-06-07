params ["_type", "_pos", "_group", "_side", ["_waypoints", []], ["_variables", []]];

_unitId = phobosId;
[[_unitId, _group, _pos, [-1, []], _type, objNull, 0, 0.5, _side, "AWARE", _waypoints, _variables], {unitArray pushBack _this;}] remoteExecCall ["BIS_fnc_call", 0];
phobosId = phobosId + 1;
publicVariable "phobosId";

_unitId