if (!hasInterface) then {
	#include "config\classnames.hpp";
	#include "config\groups.hpp";
	#include "config\missions.hpp";
	#include "server\_compile.sqf";
	#include "shared\_compile.sqf";

	unitArray = [];
	unitArrayDelete = [];
	vehicleArray = [];
	vehicleArrayDelete = [];
	playerVehicleArray = [];
} else {
	#include "config\groups.hpp";
	#include "client\_compile.sqf";
	#include "shared\_compile.sqf";

	[] call Phobos_interactionInterrogate;
	[] call Phobos_interactionTalk;
	[] call Phobos_mapBaseMarkers;
	[] call Phobos_mapClick;
	//[] call Phobos_miscHeadgearEss;
	//[] call Phobos_miscHeadgearVisor;

	["InitializePlayer", [player]] call Phobos_squadmanagerDynamicGroups;

	[Phobos_miscPickup, 1] call CBA_fnc_addPerFrameHandler;

	[{
		if (time - (player getVariable ["phobos_last_fired", 0]) < 60) then {
			{
				[_x, "COMBAT"] remoteExecCall ["setBehaviour", _x]; 
			} forEach (player nearEntities 100);
		};
	}, 1] call CBA_fnc_addPerFrameHandler;
};
