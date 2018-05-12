{
	_x params ["_center", "_marker", "_approval", "_morale"];
	_zone = _x;

	_playersInZone = (allPlayers select {_x inArea _marker});
	if (count _playersInZone > 0) then {
		_zone set [2, _approval + (0.002 * (count _playersInZone))];
		_zone set [3, _morale - (0.002 * (count _playersInZone))];
	} else {
		_zone set [2, _approval + 0.001];
		_zone set [3, _morale - 0.001];
	};

	switch true do {
		case (_approval < 0.3): {
			_marker setMarkerColor "ColorRed";
		};
		case (_approval < 0.6): {
			_marker setMarkerColor "ColorYellow";
		};
		default {
			_marker setMarkerColor "ColorGreen";
		};
	};
} forEach zones;