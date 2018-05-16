params ["_unit"];

_zone = [getPosATL _unit] call Phobos_miscGetZone;

if (_unit getVariable ["phobos_ai_garrison", false]) then {
    doStop _unit;
};

if ((side _unit == civilian && random 10 + 0.3 <= 1 - (_zone select 2)) || _unit getVariable ["phobos_ai_bomber", false]) then {
    [_unit] spawn Phobos_aiBomber;
};

_unit setVariable ["phobos_ai_friendly", random 1 < (_zone select 2), true];