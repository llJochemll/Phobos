_factionIndex = ["Faction", 0] call BIS_fnc_getParamValue;

_action = ["phobos_action_vehicle_spawner_ground", "Spawn vehicle", "", {}, {}] call ace_interact_menu_fnc_createAction;
[phobos_vehicle_spawner_ground, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;

{
	_category = "";
	switch (_foreachIndex) do {
		case 0: {
			_category = "Cars"
		};
		case 1: {
			_category = "MRAPs"
		};
		case 2: {
			_category = "APCs"
		};
		case 3: {
			_category = "IFVs"
		};
		case 0: {
			_category = "Tanks"
		};
		default { };
	};

	_action = ["phobos_action_vehicle_spawn_" + (toLower _category), _category, "", {}, {}] call ace_interact_menu_fnc_createAction;
	[phobos_vehicle_spawner_ground, 0, ["ACE_MainActions", "phobos_action_vehicle_spawner_ground"], _action] call ace_interact_menu_fnc_addActionToObject;
	
	{
		hint str _x;
		_action = ["phobos_action_vehicle_spawn_" + (toLower _category)  + (_x select 0), gettext (configfile >> "CfgVehicles" >> (_x select 0) >> "displayName"), "", {
			params ["_target", "_player", "_params"];
			_params params ["_class", "_cost", "_init"];

			_veh = createVehicle [_class, [0, 0, 10000], [], 0, "NONE"];

			_veh setPosATL getPosATL phobos_vehicle_spawn_ground;
			_veh setDir getDir phobos_vehicle_spawn_ground;
			_veh setDamage 0;
		}, {true}, {}, _x] call ace_interact_menu_fnc_createAction;
		[phobos_vehicle_spawner_ground, 0, ["ACE_MainActions", "phobos_action_vehicle_spawner_ground", "phobos_action_vehicle_spawn_" + (toLower _category)], _action] call ace_interact_menu_fnc_addActionToObject;
	} forEach _x;
} forEach (((factions select _factionIndex) select 1) select [0, 5]);