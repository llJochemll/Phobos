//zone = [center, marker, approval, morale]
zones = [];

for "_yCor" from 500 to worldSize + 500 step 1000 do {
	for "_xCor" from 500 to worldSize + 500 step 1000 do {
		_markerName = format ["zone_%1:%2", _xCor, _yCor];
		createMarker [_markerName, [_xCor, _yCor]];
		_markerName setMarkerShape "RECTANGLE";
		_markerName setMarkerSize [500, 500];
		_markerName setMarkerColor "ColorUNKNOWN";
		_markerName setMarkerBrush "Solid";

		zones pushBack [[_xCor, _yCor], _markerName, (floor (random 11)) / 10, 0.5];
	};
};

