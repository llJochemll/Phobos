_factionIndex = ["Faction", 0] call BIS_fnc_getParamValue;

_action = ["phobos_action_vehicle_spawner_heli", "Spawn helicopter", "", {}, {}] call ace_interact_menu_fnc_createAction;
[phobos_vehicle_spawner_heli, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;

{
	_action = ["phobos_action_vehicle_heli_" + (_x select 0), gettext (configfile >> "CfgVehicles" >> (_x select 0) >> "displayName"), "", {
		params ["_target", "_player", "_params"];
		_params params ["_class", "_cost", "_init"];

		_veh = createVehicle [_class, [0, 0, 10000], [], 0, "NONE"];

		_veh setPosATL getPosATL phobos_vehicle_spawn_heli;
		_veh setDir getDir phobos_vehicle_spawn_heli;
		_veh setDamage 0;
	}, {true}, {}, _x] call ace_interact_menu_fnc_createAction;
	[phobos_vehicle_spawner_heli, 0, ["ACE_MainActions", "phobos_action_vehicle_spawner_heli"], _action] call ace_interact_menu_fnc_addActionToObject;
} forEach (((factions select _factionIndex) select 1) select 5);