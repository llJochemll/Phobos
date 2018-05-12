#include "config\classnames.hpp";
#include "config\missions.hpp";
#include "server\_compile.sqf";

phobosId = 0;
unitArray = [];
vehicleArray = [];
playerVehicleArray = [];

[] call Phobos_initHouses;
[] call Phobos_initEnemy;
[] call Phobos_initCivilian;
[] call Phobos_initMissions;
[] call Phobos_initZones;

[Phobos_cacheAi, 10] call CBA_fnc_addPerFrameHandler;
[Phobos_coreMissions, 10] call CBA_fnc_addPerFrameHandler;
[Phobos_coreZones, 10] call CBA_fnc_addPerFrameHandler;

//Temp
[{
	{
		[_x, _x, 100, 3, 0.5, 0.5] call CBA_fnc_taskDefend;
		{
			_x setVariable ["phobos_ai_hastask", true, true];
		} forEach (units _x);
	} forEach (allGroups select {side _x == east && !((leader _x) getVariable ["phobos_ai_hastask", false])});

	{
		[_x, _x, 50, 10, "MOVE", "SAFE", "YELLOW", "LIMITED"] call CBA_fnc_taskPatrol;
		{
			_x setVariable ["phobos_ai_hastask", true, true];
		} forEach (units _x);
	} forEach (allGroups select {side _x == civilian && !((leader _x) getVariable ["phobos_ai_hastask", false])});
}, 10] call CBA_fnc_addPerFrameHandler;