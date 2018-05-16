["phobos_mapclick", "onMapSingleClick", {
	params ["_units", "_pos", "_alt", "_shift"];
	
	{
		_missionType = (missionTypes select _forEachIndex) select 0;
		{
			if (_pos inArea (_x select 5)) then {
				hint _missionType;
			};
		} forEach _x;
	} forEach missions;
}] call BIS_fnc_addStackedEventHandler;