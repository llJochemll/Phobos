//[pos, completeCondition, completeStatement, args, intelRadius, markerZone]
{
	
	[{
		params ["_index"];
		_mission = missions select _index;
		_missionType = (missionTypes select _index) select 0;
		{
			_x params ["_pos", "_completeCondition", "_completeStatement", "_args", "_intelRadius", "_maxIntelRadius", "_markerZone"];
			
			if (_args call _completeCondition) then {
				_args call _completeStatement;

				deleteMarker _markerZone;
				_mission deleteAt _forEachIndex;
			};

			if (_intelRadius > 100 || _intelRadius <= 0) then {
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
	}, [_forEachIndex], (10 / (count missions)) * _forEachIndex] call CBA_fnc_waitAndExecute;
} forEach missions;

{
	_x params ["_missionType", "_count"];
	if (count (missions select _forEachIndex) < _count) then {
		(missions select _forEachIndex) pushBack (call compile (format ["[] call Phobos_mission%1", _missionType]));
	};
} forEach missionTypes;

publicVariable "missions";