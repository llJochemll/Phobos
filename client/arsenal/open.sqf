params ["_box"];

_groupIndex = player getVariable ["group_index", -1];
_roleIndex = player getVariable ["role_index", -1];
_factionIndex = ["Faction", 0] call BIS_fnc_getParamValue;

if (_groupIndex == -1 || _roleIndex == -1) exitWith {};

_roleType = playerGroups select _groupIndex select 4 select _roleIndex select 4;

_items = [];

_arsenalConfig = factions select _factionIndex select 0;

{
	{
		_items pushBackUnique _x;
	} forEach _x;
} forEach ((_arsenalConfig select 0) + (_arsenalConfig select 1 select _roleType));

[_box, true, false] call ace_arsenal_fnc_removeVirtualItems;
[_box, _items, false] call ace_arsenal_fnc_addVirtualItems;

[_box, player, false] call ace_arsenal_fnc_openBox;