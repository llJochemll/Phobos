params ["_pos", "_pool", "_count", "_side"];

_groupId = [] call Phobos_commonNewId;

_unitIds = [];

for "_i" from 1 to _count do {
	_unitIds pushBack ([selectRandom _pool, _pos, _groupId, _side] call Phobos_spawnVirtualUnit);
};;

_unitIds