_house = selectRandom ((housesVillages + housesTowns + housesCapitals + housesRemote) select {count (_x buildingPos -1) > 5});

_buildingPositions = (_house buildingPos -1) select {lineIntersects [AGLToASL _x, (AGLToASL _x) vectorAdd [0,0,10]]};

_cachePos = selectRandom _buildingPositions;
_cacheId = ["rhs_7ya37_1_single", _cachePos, 0] call Phobos_spawnVirtualVehicle;

//Enemies
for "_i" from 1 to 3 do {
	[_cachePos, unitsEnemy, 5 + (random 3), east] call Phobos_spawnVirtualGroup;
};

_mission = [_cachePos, {
	params ["_cacheId"];

	_complete = false;
	_cache = [_cacheId] call Phobos_commonGet;
	if (isNil {_cache}) exitWith {_complete};

	_complete = !(alive _cache);
	_complete
}, [_cacheId], -1];
_mission