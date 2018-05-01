params ["_pos", "_pool", "_count", "_side"];

_group = createGroup [_side, true];

for "_i" from 1 to _count do {
	[selectRandom _pool, _pos, _group] call Phobos_spawnRealUnit;
};

_group