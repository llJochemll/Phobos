params ["_index", "_playerPositions"];

_array = vehicleArray select _index;

_pos = _array select 1;
if (isNull (_array select 3)) then {
	if (count (_playerPositions select {_x distance2D _pos < 1100}) != 0) then {
		_vehicle = createVehicle [_array select 2, _array select 1, [], 0, "CAN_COLLIDE"];
		[_vehicle, _array select 0] call Phobos_commonId;
		_vehicle setPosATL (_array select 1);
		_vehicle setDamage (_array select 4);
		_vehicle setDir (_array select 5);
		_array set [3, _vehicle];
		
		[[_index, _array], {vehicleArray set [_this select 0, _this select 1];}] remoteExecCall ["BIS_fnc_call", 0];
	};
} else {
	_id = _array select 0;
	_vehicle = _array select 3;
	if (alive _vehicle) then {
		_array set [1, getPosATL _vehicle];
		_array set [4, damage _vehicle];
		_array set [5, getDir _vehicle];
		if (count (_playerPositions select {_x distance2D _pos < 1100}) == 0) then {
			_array set [2, typeOf _vehicle];
			deleteVehicle _vehicle;
		};

		[[_index, _array], {vehicleArray set [_this select 0, _this select 1];}] remoteExecCall ["BIS_fnc_call", 0];
	} else {
		if (isNull (_array select 3)) then {
			vehicleArrayDelete pushBack _id;
		};
	};
};

if (_index + 1 < count vehicleArray) then {
	[Phobos_cacheAiVehicle, [_index + 1, _playerPositions], 5 / (count vehicleArray)] call CBA_fnc_waitAndExecute
};