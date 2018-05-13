//[pos, completeCondition, args, intelRadius]
{
	_x params ["_missionName", "_count"];
	if (count (missions select _forEachIndex) < _count) then {
		(missions select _forEachIndex) pushBack (call compile (format ["[] call Phobos_mission%1", _missionName]));
	};
} forEach missionTypes;

{
	{

	} forEach _x;
} forEach missions;