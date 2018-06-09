_conditionOn = {
	!(_player getVariable ["visorOn", true])
	&& (_player getVariable ["currHeadGear", ""] == (toLower (headgear _player)))
};
_statementOn = {
	removeHeadgear _player;
	_player addHeadgear (_player getVariable ["orgHeadGear", ""]);
	_player setVariable ["visorOn", true];
	removeGoggles _player;
};
_actionOn = ["visorOn","Lower visor","",_statementOn,_conditionOn] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], _actionOn] call ace_interact_menu_fnc_addActionToObject;

_conditionOff = {
	(toLower (headgear _player)) find "_visor" != -1
	&& isClass (configFile >> "CfgWeapons" >> [(toLower (headgear _player)), "_visor", ""] call TER_fnc_editString)
};
_statementOff = {
	_newHeadGear = [(toLower (headgear _player)), "_visor", ""] call TER_fnc_editString;
	_player setVariable ["visorOn", false];
	_player setVariable ["orgHeadGear", (toLower (headgear _player))];
	_player setVariable ["currHeadGear", _newHeadGear];
	removeHeadgear _player;
	_player addHeadgear _newHeadGear;
};
_actionOff = ["visorOff","Retract visor","",_statementOff,_conditionOff] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], _actionOff] call ace_interact_menu_fnc_addActionToObject;