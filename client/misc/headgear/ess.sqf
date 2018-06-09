_conditionOn = {
	(toLower (headgear _player)) find "_ess" != -1
	&& (isClass (configFile >> "CfgWeapons" >> [(toLower (headgear _player)), "_ess", ""] call TER_fnc_editString) || isClass (configFile >> "CfgWeapons" >> [(toLower (headgear _player)), "_ess", "_helmet"] call TER_fnc_editString))
};
_statementOn = {
	_newHeadGear = [(toLower (headgear _player)), "_ess", ""] call TER_fnc_editString;
	if (!isClass (configFile >> "CfgWeapons" >> _newHeadGear)) then {
		_newHeadGear = [(toLower (headgear _player)), "_ess", "_helmet"] call TER_fnc_editString;
	};
	_player setVariable ["gogglesOn", true];
	_player setVariable ["orgHeadGear", (toLower (headgear _player))];
	_player setVariable ["currHeadGear", _newHeadGear];
	removeHeadgear _player;
	_player addHeadgear _newHeadGear;
	_player addGoggles "rhs_ess_black";
};
_actionOn = ["gogglesOn","Equip goggles","",_statementOn,_conditionOn] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], _actionOn] call ace_interact_menu_fnc_addActionToObject;

_conditionOff = {
	(_player getVariable ["gogglesOn", false]) 
	&& ("rhs_ess_black" in (items _player) || (goggles _player) == "rhs_ess_black") 
	&& (_player getVariable ["currHeadGear", ""] == (toLower (headgear _player)))
};
_statementOff = {
	removeHeadgear _player;
	_player addHeadgear (_player getVariable ["orgHeadGear", ""]);
	_player setVariable ["gogglesOn", false];
	removeGoggles _player;
};
_actionOff = ["gogglesOn","Stow goggles","",_statementOff,_conditionOff] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], _actionOff] call ace_interact_menu_fnc_addActionToObject;