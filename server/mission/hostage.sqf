if (count (zones select {(_x select 2) < 0.3}) == 0) exitWith {};

_house = objNull;
_houses = ((housesVillages + housesTowns + housesCapitals + housesRemote) select {count (_x buildingPos -1) > 20 && west countSide (_x nearEntities 1000) == 0});
while {isNull _house} do {
	_house = selectRandom _houses;

	if (([getPosATL _house] call Phobos_miscGetZone) select 2 >= 0.3) then {
		_house = objNull;
	};
};
_buildingPositions = (_house buildingPos -1) select {lineIntersects [AGLToASL _x, (AGLToASL _x) vectorAdd [0, 0, 10]]};

//Spawn officer and guard
_hostageGroupId = [] call Phobos_commonNewId;
_hostagePos = selectRandom _buildingPositions;
_hostageId = [selectRandom unitsHostage, _hostagePos, _hostageGroupId, civilian, [], [["phobos_ai_garrison", true], ["phobos_ai_hastask", true], ["phobos_ai_hostage", true]]] call Phobos_spawnVirtualUnit;

_garrisonGroupId = [] call Phobos_commonNewId;
for "_i" from 1 to 5 do {
	[selectRandom unitsEnemy, selectRandom _buildingPositions, _garrisonGroupId, east, [], [["phobos_ai_garrison", true], ["phobos_ai_hastask", true]]] call Phobos_spawnVirtualUnit;
};

//Patrolling enemies
for "_i" from 1 to 2 do {
	[getPosATL _house, unitsEnemy, 5 + (random 3), east] call Phobos_spawnVirtualGroup;
};

_marker = createMarker [format ["phobos_marker_mission_%1", [] call Phobos_commonNewId], getPosATL _house];
_marker setMarkerShape "ELLIPSE";
_marker setMarkerBrush "SolidBorder";
_marker setMarkerColor "ColorOPFOR";

_mission = [getPosATL _house, {
	params ["_hostageId"];

	_complete = false;
	_hostage = [_hostageId] call Phobos_commonGet;
	if (isNil {_hostage}) exitWith {_complete};

	_complete = !(alive _hostage) || _hostage inArea phobos_trigger_prison;
	_complete
}, {
	params ["_officerId"];

	_hostage = [_hostageId] call Phobos_commonGet;
	if (isNil {_hostage} || !(alive _hostage)) then {
		[[west, "HQ"], "Hostage killed!"] remoteExecCall ["sideChat", -2];
		["TaskFailed", ["Hostage killed!", "Hostage killed!"]] remoteExecCall ["BIS_fnc_showNotification", -2];
	} else {
		[[west, "HQ"], "Hostage rescued!"] remoteExecCall ["sideChat", -2];
		["TaskSucceeded", ["Hostage rescued!", "Hostage rescued!"]] remoteExecCall ["BIS_fnc_showNotification", -2]; 
	};
}, [_hostageId], 0, 1000, _marker];
_mission