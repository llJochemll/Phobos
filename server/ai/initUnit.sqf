params ["_unit"];

_zone = [getPos _unit] call Phobos_miscGetZone;

if (_unit getVariable ["phobos_ai_garrison", false]) then {
    doStop _unit;
};

if (random 10 + 0.3 <= 1 - (_zone select 2)) then {
    [_unit] spawn Phobos_aiBomber;
};

_unit setVariable ["phobos_ai_friendly", random 1 < (_zone select 2), true];