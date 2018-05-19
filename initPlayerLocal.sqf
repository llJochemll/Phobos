#include "config\groups.hpp";
#include "client\_compile.sqf";
#include "shared\_compile.sqf";

[] call Phobos_coreTalk;
[] call Phobos_mapClick;
[] call Phobos_miscShout;

["InitializePlayer", [player]] call Phobos_squadmanagerDynamicGroups;

[Phobos_miscPickup, 1] call CBA_fnc_addPerFrameHandler;