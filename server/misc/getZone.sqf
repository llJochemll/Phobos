params ["_pos"];

{
	if (_pos inArea (_x select 1)) exitWith {
		_x
	};
} forEach zones;