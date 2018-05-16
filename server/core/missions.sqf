//[pos, completeCondition, completeStatement, args, intelRadius, markerZone]
{
	_x params ["_missionName", "_count"];
	if (count (missions select _forEachIndex) < _count) then {
		(missions select _forEachIndex) pushBack (call compile (format ["[] call Phobos_mission%1", _missionName]));
	};
} forEach missionTypes;

{
	_mission = _x;
	_missionName = (missionTypes select _forEachIndex) select 0;
	{
		_x params ["_pos", "_completeCondition", "_completeStatement", "_args", "_intelRadius", "_markerZone"];
		if (_args call _completeCondition) then {
			_args call _completeStatement;

			//Set approval and morale
			_zone = [_pos] call Phobos_miscGetZone;
			_zone set [2, (_zone select 2) + 0.05];
		_zone set [3, _morale - (0.002 * (count _playersInZone))];

			deleteMarker _markerZone;
			_mission deleteAt _forEachIndex;
		};

		if (_intelRadius > 100 || _intelRadius < 0) then {
			if ((getMarkerSize _markerZone) select 0 != _intelRadius) then {
				_markerZone setMarkerPos (_pos getPos [random _intelRadius, random 360]);
				_markerZone setMarkerSize [_intelRadius, _intelRadius];
			};
		} else {
			_markerZone setMarkerPos _pos;
			_markerZone setMarkerSize [1, 1];
			_markerZone setMarkerType "mil_objective";
			_markerZone setMarkerText _missionName;
			_markerZone setMarkerShape "ICON";
		};
	} forEach _mission;
} forEach missions;