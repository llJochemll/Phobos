if (count (zones select {(_x select 2) < 0.3}) == 0) exitWith {};

_location = locationNull;
_locations = nearestLocations [[worldSize / 2, worldSize / 2], ["NameVillage", "NameCity", "NameCityCapital"], worldSize*2.0^0.5];
while {isNull _locations} do {
	_location = selectRandom _locations;

	if (([getPos _location] call Phobos_miscGetZone) select 2 >= 0.3) then {
		_location = locationNull;
	};
};
_buildingPositions = (_house buildingPos -1) select {lineIntersects [AGLToASL _x, (AGLToASL _x) vectorAdd [0, 0, 10]]};

//Patrolling enemies
for "_i" from 1 to 7 do {
	[(getPos _location) getPos [random 500, random 360], unitsEnemy, 5 + (random 3), east] call Phobos_spawnVirtualGroup;
};

_marker = createMarker [format ["phobos_marker_mission_%1", phobosId], getPosATL _house];
_marker setMarkerShape "ELLIPSE";
_marker setMarkerBrush "SolidBorder";
_marker setMarkerColor "ColorOPFOR";

_mission = [getPosATL _house, {
	params ["_location"];

	_complete = west countSide ((getPos _location) nearEntities 500) > 0 && east countSide ((getPos _location) nearEntities 500) < 4;
	_complete
}, {
	[[west, "HQ"], "Town cleared!"] remoteExecCall ["sideChat", -2];
}, [_location], 0, 1000, _marker];
_mission