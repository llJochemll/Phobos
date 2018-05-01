[{
	{
		_holder = _x;

		for "_i" from 0 to 999 do {
			[_holder, 0, ["ACE_MainActions", "pickup" + str _i]] call ace_interact_menu_fnc_removeActionFromObject;
		};
		
		{
			if (_forEachIndex > 999) exitWith {};
			[_holder, 0, ["ACE_MainActions", "pickup" + str _forEachIndex]] call ace_interact_menu_fnc_removeActionFromObject;

			_action = ["pickup" + str _forEachIndex, "Pickup " + getText (configfile >> "CfgWeapons" >> _x >> "displayName"), "", {
				params ["_target", "_player", "_param"];
				_player action ["TakeWeapon", _target, _param];
			}, {true}, {}, _x] call ace_interact_menu_fnc_createAction;
			[_holder, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;	
		} forEach ((getWeaponCargo _x) select 0);
	} forEach ((player nearSupplies 10) select {_x isKindOf "WeaponHolder"});
}, 1] call CBA_fnc_addPerFrameHandler;