_house = selectRandom ((housesVillages + housesTowns + housesCapitals + housesRemote) select {count (_x buildingPos -1) > 10 && west countSide (_x nearEntities 1000) == 0});

_buildingPositions = (_house buildingPos -1) select {lineIntersects [AGLToASL _x, (AGLToASL _x) vectorAdd [0, 0, 10]]};

//Spawn officer and guard
_groupId = phobosId;
phobosId = phobosId + 1;
_officerPos = selectRandom _buildingPositions;
_officerId = [selectRandom unitsOfficer, _officerPos, _groupId, east, [], [["phobos_ai_garrison", true], ["phobos_ai_hastask", true], ["phobos_ai_officer", true]]] call Phobos_spawnVirtualUnit;
for "_i" from 1 to 5 do {
	[selectRandom unitsEnemy, selectRandom _buildingPositions, _groupId, east, [], [["phobos_ai_garrison", true], ["phobos_ai_hastask", true]]] call Phobos_spawnVirtualUnit;
};

//Patrolling enemies
for "_i" from 1 to 2 do {
	[getPosATL _house, unitsEnemy, 5 + (random 3), east] call Phobos_spawnVirtualGroup;
};

_marker = createMarker [format ["phobos_marker_mission_%1", phobosId], getPosATL _house];
_marker setMarkerShape "ELLIPSE";
_marker setMarkerBrush "SolidBorder";
_marker setMarkerColor "ColorOPFOR";

_mission = [getPosATL _house, {
	params ["_officerId"];

	_complete = false;
	_officer = [_officerId] call Phobos_commonGet;
	if (isNil {_officer}) exitWith {_complete};

	_complete = !(alive _officer) || _officer inArea phobos_trigger_prison;
	_complete
}, {
	params ["_officerId"];

	_officer = [_officerId] call Phobos_commonGet;
	if (isNil {_officer} || !(alive _officer)) then {
		[[west, "HQ"], "HVT killed!"] remoteExecCall ["sideChat", -2];
		["TaskSucceeded", ["HVT killed!", "HVT killed!"]] remoteExecCall ["BIS_fnc_showNotification", -2];
	} else {
		[[west, "HQ"], "HVT Captured!"] remoteExecCall ["sideChat", -2];
		["TaskSucceeded", ["HVT Captured!", "HVT Captured!"]] remoteExecCall ["BIS_fnc_showNotification", -2];
		[random 5 + 5] remoteExecCall ["Phobos_intelAdd", 2]; 
	};
}, [_officerId], -1, _marker];
_mission