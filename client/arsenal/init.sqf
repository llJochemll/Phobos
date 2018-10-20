{
	_actionArsenal = [format ["phobos_action_arsenal_%1", _forEachIndex], "Arsenal", "", {
		params ["_target", "_player", "_param"];

		[_target] call Phobos_arsenalOpen;
	}, {
		params ["_target", "_player", "_param"];
		
		_player getVariable ["role_index", -1] != -1 
	}] call ace_interact_menu_fnc_createAction;

	[_x, 0, ["ACE_MainActions"], _actionArsenal] call ace_interact_menu_fnc_addActionToObject;
} forEach [arsenal0];