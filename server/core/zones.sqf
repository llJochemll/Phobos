{
	_zone = _x;

	_newApproval = (_zone select 2) - 0.005;
	_newMorale = (_zone select 3) + 0.005;
	for "_yCor" from ((_zone select 0) select 1) - 1000 to ((_zone select 0) select 1) + 1000 step 1000 do {
		for "_xCor" from ((_zone select 0) select 0) - 1000 to ((_zone select 0) select 0) + 1000 step 1000 do {
			_markerName = format ["zone_%1:%2", _xCor, _yCor];
			_selectedZone = (zones select {(_x select 1 == _markerName)}) select 0;
			_newApproval = _newApproval + (((_zone select 2) - (_selectedZone select 2)) / 10);
			_newMorale = _newMorale + (((_zone select 3) - (_selectedZone select 3)) / 10);
		};
	};
	_zone set [2, _newApproval];
	_zone set [3, _newMorale];

	switch true do {
		case (count (unitArray select {_x select 2 inArea (_zone select 1) && (_x select 8) == civilian}) == 0): {
			(_zone select 1) setMarkerColor "ColorCIV";
		};
		case ((_zone select 2) < 0.3): {
			(_zone select 1) setMarkerColor "ColorRed";
		};
		case ((_zone select 2) < 0.6): {
			(_zone select 1) setMarkerColor "ColorYellow";
		};
		default {
			(_zone select 1) setMarkerColor "ColorGreen";
		};
	};
} forEach zones;