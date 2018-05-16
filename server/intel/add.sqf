params ["_value", ["_pos", [0, 0, 0]]];

if (_pos isEqualTo [0, 0, 0]) then {
	for "_i" from 1 to _value do {
		_typeIndex = floor (random (count missions));
		_missionIndex = floor (random (count (missions select _typeIndex)));
		if ((((missions select _typeIndex) select _missionIndex) select 4) == -1) then {
			((missions select _typeIndex) select _missionIndex) set [4, 1000];
		} else {
			((missions select _typeIndex) select _missionIndex) set [4, (((missions select _typeIndex) select _missionIndex) select 4) / 2];
		};
	};
} else {
	_allMissions = [];
	{
		_typeIndex = _forEachIndex;
		{
			_allMissions pushBack [_x, [_typeIndex, _forEachIndex]];
		} forEach _x;
	} forEach missions;

	_nearMissions = _allMissions select {((_x select 0) select 0) distance2D _pos < 2000};
	if (count _nearMissions == 0) then {
		[_value] call Phobos_intelAdd;
	} else {
		for "_i" from 1 to _value do {
			_mission = selectRandom _nearMissions;

			if (((_mission select 0) select 4) == -1) then {
				((missions select ((_mission select 1) select 0)) select ((_mission select 1) select 1)) set [4, 1000];
			} else {
				((missions select ((_mission select 1) select 0)) select ((_mission select 1) select 1)) set [4, ((_mission select 0) select 4) / 2];
			};
		};
	};
};