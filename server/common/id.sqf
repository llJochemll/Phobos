params ["_thing", ["_newId", -1]];

if (isNull _thing) exitWith { -1 };

if (_newId != -1) then {
	_thing setVariable ["phobos_common_id", _newId, true];
};

_thingId = _thing getVariable ["phobos_common_id", -1];
if (_thingId == -1) then {
	_thing setVariable ["phobos_common_id", [] call Phobos_commonNewId, true];
};

_thingId