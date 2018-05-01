params ["_type", "_pos", "_side", ["_crew", true]];

_vehicle = createVehicle [_type, _pos, [], 0, "NONE"];

if (_crew) then {
	createVehicleCrew _vehicle;
	_group = createGroup [_side, true];
	(crew _vehicle) join _group;
};

_vehicle