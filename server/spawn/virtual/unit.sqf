params ["_type", "_pos", "_group", "_side"];

_unitId = phobosId;
[unitArray, [_unitId, _group, _pos, [-1, []], _type, true, 0, 0.5, _side, "AWARE", [], []]] remoteExecCall ["pushBack", 0];
phobosId = phobosId + 1;

publicVariable "phobosId";

_unitId