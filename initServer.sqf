#include "config\classnames.hpp";
#include "config\groups.hpp";
#include "config\missions.hpp";
#include "server\_compile.sqf";
#include "shared\_compile.sqf";

phobosId = 0;
unitArray = [];
unitArrayDelete = [];
unitArrayRespawn = [0,0,0,0];
vehicleArray = [];
vehicleArrayDelete = [];
playerVehicleArray = [];

[] call Phobos_initHouses;
[] call Phobos_initEnemy;
[] call Phobos_initCivilian;
[] call Phobos_initMissions;
[] call Phobos_initZones;

unitArray = [unitArray] call CBA_fnc_shuffle;
vehicleArray = [vehicleArray] call CBA_fnc_shuffle;

["Initialize", [false, 5, true]] call Phobos_squadmanagerDynamicGroups;

[Phobos_cacheAi, 5] call CBA_fnc_addPerFrameHandler;
[Phobos_coreMissions, 1] call CBA_fnc_addPerFrameHandler;
[Phobos_corePopulation, 60] call CBA_fnc_addPerFrameHandler;
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
		[_x, _x, 50, 5, "MOVE", "SAFE", "YELLOW", "LIMITED"] call CBA_fnc_taskPatrol;
		{
			_x setVariable ["phobos_ai_hastask", true, true];
		} forEach (units _x);
	} forEach (allGroups select {side _x == civilian && !((leader _x) getVariable ["phobos_ai_hastask", false])});
}, 10] call CBA_fnc_addPerFrameHandler;