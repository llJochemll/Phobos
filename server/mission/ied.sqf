_house = selectRandom ((housesVillages + housesTowns + housesCapitals) select {count (_x nearRoads 400) > 0});

_roads = _house nearRoads 400;
_roads = [_roads] call CBA_fnc_shuffle;
_centerPos = getPosATL (selectRandom _roads);
_roads = _centerPos nearRoads 50;
_roads = [_roads] call CBA_fnc_shuffle;

_iedIds = [];
for "_i" from 0 to (count _roads) - 1 do {
	_pos = (getPos (_roads select _i)) getPos [random 10, random 360];
	_iedIds pushBack ([selectRandom ieds, _pos, 0] call Phobos_spawnVirtualVehicle);
};

[getPosATL _house, unitsEnemy, 5 + (random 3), east] call Phobos_spawnVirtualGroup;

_marker = createMarker [format ["phobos_marker_mission_%1", phobosId], _centerPos];
_marker setMarkerShape "ELLIPSE";
_marker setMarkerBrush "SolidBorder";
_marker setMarkerColor "ColorOPFOR";

_mission = [_centerPos, {
	params ["_iedIds"];

	_complete = (vehicleArray findIf {(_x select 0) in _iedIds}) == -1;
	_complete
}, {
	[[west, "HQ"], "All ieds dismantled!"] remoteExecCall ["sideChat", -2];
	["TaskSucceeded", ["All ieds dismantled!", "All ieds dismantled!"]] remoteExecCall ["BIS_fnc_showNotification", -2];
}, [_iedIds], 0, 200, _marker];
_mission