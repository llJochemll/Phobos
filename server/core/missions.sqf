//[pos, completeCondition, completeStatement, args, intelRadius, markerZone]
{
	_x params ["_missionType", "_count"];
	if (count (missions select _forEachIndex) < _count) then {
		(missions select _forEachIndex) pushBack (call compile (format ["[] call Phobos_mission%1", _missionType]));
	};
} forEach missionTypes;

{
	_mission = _x;
	_missionType = (missionTypes select _forEachIndex) select 0;
	{
		_x params ["_pos", "_completeCondition", "_completeStatement", "_args", "_intelRadius", "_markerZone"];
		if (_args call _completeCondition) then {
			_args call _completeStatement;

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
			_markerZone setMarkerText _missionType;
			_markerZone setMarkerShape "ICON";
		};
	} forEach _mission;
} forEach missions;