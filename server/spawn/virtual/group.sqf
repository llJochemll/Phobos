params ["_pos", "_pool", "_count", "_side"];

_groupId = phobosId;
phobosId = phobosId + 1;

for "_i" from 1 to _count do {
	[selectRandom _pool, _pos, _groupId, _side] call Phobos_spawnVirtualUnit;
};

publicVariable "phobosId";