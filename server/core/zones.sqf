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

	//Keep approval and morale between 0 and 1
	if ((_zone select 2) > 1) then {
		_zone set [2, 1];
	};
	if ((_zone select 3) > 1) then {
		_zone set [3, 1];
	};
	if ((_zone select 2) < 0) then {
		_zone set [2, 0];
	};
	if ((_zone select 2) < 0) then {
		_zone set [3, 0];
	};

	//Change colors
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
} forEach (zones select {markerColor (_x select 1) != "ColorCIV"});