_house = selectRandom ((housesVillages + housesTowns + housesCapitals + housesRemote) select {count (_x buildingPos -1) > 5 && west countSide (_x nearEntities 1000) == 0});

_buildingPositions = (_house buildingPos -1) select {lineIntersects [AGLToASL _x, (AGLToASL _x) vectorAdd [0, 0, 10]]};

_cachePos = selectRandom _buildingPositions;
_cacheId = ["rhs_7ya37_1_single", _cachePos, 0] call Phobos_spawnVirtualVehicle;

//Enemies
for "_i" from 1 to 3 do {
	[getPosATL _house, unitsEnemy, 5 + (random 3), east] call Phobos_spawnVirtualGroup;
};

_marker = createMarker [format ["phobos_marker_mission_%1", [] call Phobos_commonNewId], getPosATL _house];
_marker setMarkerShape "ELLIPSE";
_marker setMarkerBrush "SolidBorder";
_marker setMarkerColor "ColorOPFOR";

_mission = [getPosATL _house, {
	params ["_cacheId"];

	_complete = false;
	_cache = [_cacheId] call Phobos_commonGet;
	if (isNil {_cache}) exitWith {_complete};

	_complete = !(alive _cache);
	_complete
}, {
	params ["_cacheId"];

	[[west, "HQ"], "Cache destroyed!"] remoteExecCall ["sideChat", -2];
	["TaskSucceeded", ["Cache destroyed!", "Cache destroyed!"]] remoteExecCall ["BIS_fnc_showNotification", -2];
}, [_cacheId], 0, 1000, _marker];
_mission