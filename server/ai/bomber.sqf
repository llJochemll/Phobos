params ["_unit"];

_unit setVariable ["phobos_ai_bomber", true, true];
_unit setVariable ["phobos_ai_hastask", true, true];

removeVest _unit;
_unit addVest "V_HarnessOGL_gry";
_unit addEventHandler ["Killed", {
	params ["_unit"];

	"R_80mm_HE" createVehicle (getPosATL _unit);
}];

if (side _unit != east || count (units (group _unit)) > 1) then {
	_group = createGroup east;
	[_unit] joinSilent _group;
};

{
	deleteWaypoint _x;
} forEach (waypoints _unit);

_startPos = getPosATL _unit;
while {alive _unit} do {
	_target = _unit findNearestEnemy (getPosATL _unit);
	if (!isNull _target) then {
		_unit doMove getPosATL _target;

		if ((_unit distance2D _target) < 25) exitWith {
			[[_unit], {
				params [["_unit", objNull]];
				_unit say3D "scream";
				sleep 1.1;
				_unit setDamage 1;
			}] remoteExec ["BIS_fnc_spawn", 0, true];
		};

		if ((_unit distance2D _target) < 100) then {
			_unit setSpeedMode "FULL";
		} else {
			_unit setSpeedMode "LIMITED";
		};
	} else {
		if (speed _unit < 1) then {
			_unit doMove ([_startPos, random 100, random 360] call BIS_fnc_relPos);
			_unit setBehaviour "SAFE";
			_unit setSpeedMode "LIMITED";
		};
	};
	sleep 1;
};