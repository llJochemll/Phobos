_buildOjects = [
	[
		"Cargo",
		[
			["Land_Cargo_House_V3_F", 1, [0, 9, 1]],
			["Land_Cargo_House_V1_F", 1, [0, 9, 1]],
			["Land_Medevac_house_V1_F", 1, [0, 9, 1]],
			["Land_Cargo_House_V2_F", 1, [0, 9, 1]],
			["Land_Cargo_Patrol_V3_F", 1, [0, 9, 1]],
			["Land_Cargo_Patrol_V1_F", 1, [0, 9, 1]],
			["Land_Cargo_Patrol_V2_F", 1, [0, 9, 1]]
		]
	],
	[
		"H-Barrier",
		[
			["Land_HBarrier_3_F", 1],
			["Land_HBarrier_5_F", 1],
			["Land_HBarrier_Big_F", 1],
			["Land_HBarrier_1_F", 1],
			["Land_HBarrierWall_corridor_F", 1],
			["Land_HBarrierWall_corner_F", 1],
			["Land_HBarrierWall6_F", 1],
			["Land_HBarrierWall4_F", 1],
			["Land_HBarrierTower_F", 1, [0, 9, 1]]
		]
	],
	[
		"Sandbag",
		[
			["Land_BagFence_Corner_F", 1],
			["Land_BagFence_End_F", 1],
			["Land_BagFence_Long_F", 1],
			["Land_BagFence_Round_F", 1],
			["Land_BagFence_Short_F", 1],
			["Land_SandbagBarricade_01_half_F", 1],
			["Land_SandbagBarricade_01_F", 1],
			["Land_SandbagBarricade_01_hole_F", 1],
			["Land_BagFence_01_corner_green_F", 1],
			["Land_BagFence_01_end_green_F", 1],
			["Land_BagFence_01_long_green_F", 1],
			["Land_BagFence_01_round_green_F", 1],
			["Land_BagFence_01_short_green_F", 1]
		]
	]
];


//Create main action
_action = ["phobos_action_logistics_spawn", "Spawn object", "", {}, {
	params ["_target", "_player", "_params"];

	_player getVariable ["ACE_IsEngineer", false] && 
	(_target getVariable ["phobos_logistics_points", 50]) > 0
}] call ace_interact_menu_fnc_createAction;
["B_Slingload_01_Cargo_F", 0, ["ACE_MainActions"], _action, true] call ace_interact_menu_fnc_addActionToClass;

//Create subactions
{
	_category = _x select 0;
	
	_action = ["phobos_action_logistics_spawn_" + _category, _category, "", {}, {}] call ace_interact_menu_fnc_createAction;
	["B_Slingload_01_Cargo_F", 0, ["ACE_MainActions", "phobos_action_logistics_spawn"], _action, true] call ace_interact_menu_fnc_addActionToClass;
	
	{
		_action = ["phobos_action_logistics_spawn_" + _category  + (_x select 0), gettext (configfile >> "CfgVehicles" >> (_x select 0) >> "displayName"), "", {
			params ["_target", "_player", "_params"];
			_params params ["_class", "_cost", ["_offset", [0, 4, 1]]];

			_points = _target getVariable ["phobos_logistics_points", 50];
			_target setVariable ["phobos_logistics_points", _points - _cost, true];

			_object = createVehicle [_class, [0,0,0], [], 0, "NONE"];
			[_object, true, _offset, 0] call ace_dragging_fnc_setCarryable;

			[_player, _object] call ace_dragging_fnc_carryObject;
		}, {
			params ["_target", "_player", "_params"];

			(_target getVariable ["phobos_logistics_points", 50]) >= 0
		}, {}, _x] call ace_interact_menu_fnc_createAction;
		["B_Slingload_01_Cargo_F", 0, ["ACE_MainActions", "phobos_action_logistics_spawn", "phobos_action_logistics_spawn_" + _category], _action, true] call ace_interact_menu_fnc_addActionToClass;
	} forEach (_x select 1);
} forEach _buildOjects;