params [["_index", 0], "_playerPositions", "_realVehicles"];

if (_index mod 100 == 0) then {
	_playerPositions = [];
	{
		_pos = eyePos _x;
		if (count (_playerPositions select {_x distance2D _pos < 100}) == 0) then {
			_playerPositions pushBack [player, _pos];
		};
	} forEach (allPlayers select {typeOf (vehicle _x) != "plane"});

	_realVehicles = [];
	{
		_realVehicles pushBackUnique ([_x] call Phobos_commonId);
	} forEach vehicles;
	_realVehicles = _realVehicles - [-1];
};

if (count unitArray <= _index) exitWith { };

_array = unitArray select _index;

_pos = AGLToASL (_array select 2);
_pos = [_pos select 0, _pos select 1, (_pos select 2) + 1.8];
if (isNull (_array select 5) && (_array select 1) >= 0) then {
	if (count (_playerPositions select {(_x select 1) distance2D _pos < 500}) != 0
		|| count (_playerPositions select {(_x select 1) distance2D _pos < 1000 && count (lineIntersectsSurfaces [(_x select 1), _pos, (_x select 0), objNull, true, 2]) < 2}) != 0 
		|| (((_array select 3) select 0) in _realVehicles && ((_array select 3) select 0) != -1)) then {
		_group = grpNull;
		if (isNil {[_array select 1] call Phobos_commonGet}) then {
			_group = createGroup (_array select 8);
			[_group, _array select 1] call Phobos_commonId;

			{
				_waypoint = _group addWaypoint [_x select 12, _x select 4];
				if (_x select 0 != -1) then {
					_waypoint waypointAttachObject [_x select 0] call Phobos_commonGet;
				};
				if (_x select 1 != -1) then {
					_waypoint waypointAttachVehicle [_x select 1] call Phobos_commonGet;
				};
				_waypoint setWaypointBehaviour (_x select 2); 
				_waypoint setWaypointCombatMode (_x select 3); 
				_waypoint setWaypointCompletionRadius (_x select 4);
				_waypoint setWaypointDescription (_x select 5);
				_waypoint setWaypointForceBehaviour (_x select 6);
				_waypoint setWaypointFormation (_x select 7);
				_waypoint setWaypointHousePosition (_x select 8);
				_waypoint setWaypointLoiterRadius (_x select 9);
				_waypoint setWaypointLoiterType (_x select 10);
				_waypoint setWaypointName (_x select 11);
				_waypoint setWaypointPosition [(_x select 12), 0];
				_waypoint setWaypointScript (_x select 13);
				_waypoint setWaypointSpeed (_x select 14);
				_waypoint setWaypointStatements (_x select 15);
				_waypoint setWaypointTimeout (_x select 16);
				_waypoint setWaypointType (_x select 17);
				_waypoint setWaypointVisible (_x select 18);
			} forEach (_array select 10);
		} else {
			_group = [_array select 1] call Phobos_commonGet;
		};

		_unit = _group createUnit [_array select 4, [0, 0, 0], [], 0, "CAN_COLLIDE"];
		_array set [5, _unit];
		[_unit, _array select 0] call Phobos_commonId;
		[_unit] joinSilent _group;
		_unit setPosATL (_array select 2);
		_unit setDamage (_array select 6);

		{
			_unit setVariable [_x select 0, _x select 1, true];
		} forEach (_array select 11);

		//Vehicle (0:driver 1:commander 2:gunner)
		if (((_array select 3) select 0) in _realVehicles) then {
			_vehicle = [(_array select 3) select 0] call Phobos_commonGet;
			switch(((_array select 3) select 1) select 0)do{
				case 0:{
					_unit assignAsDriver _vehicle;
					_unit moveInDriver _vehicle;
				};
				case 1:{
					_unit assignAsCommander _vehicle;
					_unit moveInCommander _vehicle;
				};
				case 2:{
					_unit assignAsGunner _vehicle;
					_unit moveInGunner _vehicle;
				};
				case 3:{
					_unit assignAsTurret [_vehicle, ((_array select 3) select 1) select 1];
					_unit moveInTurret [_vehicle, ((_array select 3) select 1) select 1];
				};
				case 4:{
					_unit assignAsCargo _vehicle;
					_unit moveInCargo [_vehicle, ((_array select 3) select 1) select 1];
				};
				case 5:{
					_unit moveInAny _vehicle;
				};
				default {
					_unit moveInAny _vehicle;
				};
			};
		};

		[_unit] call Phobos_aiInitUnit;

		[[_index, _array], {unitArray set [(_this select 0), _this select 1];}] remoteExecCall ["BIS_fnc_call", 0];
	};
} else {
	_unit = _array select 5;
	if (alive _unit) then {
		_array set [1, [group _unit] call Phobos_commonId];
		_array set [2, getPosATL _unit];
		if (!isNull objectParent _unit) then {
			_array set [3, [[vehicle _unit] call Phobos_commonId, [_unit] call Phobos_miscVehicleIndex]];
		};

		_array set [6, damage _unit];
		_array set [7, skill _unit];
		if (!(captive _unit)) then {
			_array set [8, side _unit];
		};
		_array set [9, behaviour _unit];
		_waypoints = [];
		if (count (waypoints _unit) > 1) then {
			{
				_waypoints pushBack [
					[waypointAttachedObject _x] call Phobos_commonId,
					[waypointAttachedVehicle _x] call Phobos_commonId,
					waypointBehaviour _x, 
					waypointCombatMode _x, 
					waypointCompletionRadius _x,
					waypointDescription _x,
					waypointForceBehaviour _x,
					waypointFormation _x,
					waypointHousePosition _x,
					waypointLoiterRadius _x,
					waypointLoiterType _x,
					waypointName _x,
					waypointPosition _x,
					waypointScript _x,
					waypointSpeed _x,
					waypointStatements _x,
					waypointTimeout _x,
					waypointType _x,
					waypointVisible _x
				];
			} forEach ((waypoints _unit) select [1, count (waypoints _unit)]);
		};
		_array set [10, _waypoints];

		_variables = [];
		{
			_variables pushBack [_x, _unit getVariable [_x, nil]];
		} forEach (allVariables _unit);
		_array set [11, _variables];

		if (!(count (_playerPositions select {(_x select 1) distance2D _pos < 500}) != 0
			|| count (_playerPositions select {(_x select 1) distance2D _pos < 1000 && (count (lineIntersectsSurfaces [(_x select 1), _pos, (_x select 0), _unit, true, 2]) < 2 || behaviour _unit == "COMBAT")}) != 0 
			|| (((_array select 3) select 0) in _realVehicles && ((_array select 3) select 0) != -1))) then {
			_group = group _unit;
			deleteVehicle _unit;

			if (count (units _group) == 0) then {
				deleteGroup _group;
			};
		};

		[[_index, _array], {unitArray set [(_this select 0), _this select 1];}] remoteExecCall ["BIS_fnc_call", 0];
	} else {
		if (!(count (_playerPositions select {(_x select 1) distance2D _pos < 500}) != 0
			|| count (_playerPositions select {(_x select 1) distance2D _pos < 1000 && (count (lineIntersectsSurfaces [(_x select 1), _pos, (_x select 0), _unit, true, 2]) < 2 || behaviour _unit == "COMBAT")}) != 0 
			|| (((_array select 3) select 0) in _realVehicles && ((_array select 3) select 0) != -1))) then {
			_group = group _unit;
			deleteVehicle _unit;

			if (count (units _group) == 0) then {
				deleteGroup _group;
			};

			unitArrayDelete pushBack (_array select 0);
		};
	};    
};

if (_index + 1 < count unitArray) then {
	[Phobos_cacheAiUnit, [_index + 1, _playerPositions, _realVehicles], 5 / (count unitArray)] call CBA_fnc_waitAndExecute
};