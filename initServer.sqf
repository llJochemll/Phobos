#include "config\classnames.hpp";
#include "server\_compile.sqf";

phobosId = 0;
unitArray = [];
vehicleArray = [];
playerVehicleArray = [];

[] call Phobos_initZones;
[] call Phobos_initHouses;
[] call Phobos_initEnemy;
[] call Phobos_initCivilian;

[Phobos_cacheAi, 10] call CBA_fnc_addPerFrameHandler;
//[Phobos_coreZones, 60] call CBA_fnc_addPerFrameHandler;