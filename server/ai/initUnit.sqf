params ["_unit"];

_zone = [getPosATL _unit] call Phobos_miscGetZone;

if (_unit getVariable ["phobos_ai_garrison", false]) then {
    doStop _unit;
};

if ((side _unit == civilian && random 10 + 0.3 <= 1 - (_zone select 2)) || _unit getVariable ["phobos_ai_bomber", false]) then {
    [_unit] spawn Phobos_aiBomber;
};

if (_unit getVariable ["phobos_ai_hostage", false]) then {
    ["ACE_captives_setHandcuffed", [_unit, true], _unit] call CBA_fnc_targetEvent;
};

if (_unit getVariable ["phobos_ai_officer", false]) then {
    removeGoggles _unit;
    _unit addGoggles "G_Aviator";
};

if (side _unit == civilian) then {
    _unit setVariable ["phobos_ai_intel", true, true];
    _unit setVariable ["phobos_ai_friendly", random 1 < (_zone select 2), true];
};

_unit setVariable ["phobos_ai_side", side _unit];

//Event handler for "respawning"
_unit addEventHandler ["Killed", {
    params ["_unit", "_killer", "_instigator", "_useEffects"];

    switch (_unit getVariable ["phobos_ai_side", civilian]) do {
        case civilian: {
            unitArrayRespawn set [0, (unitArrayRespawn select 0) + 1];
        };
        case east: {
            unitArrayRespawn set [1, (unitArrayRespawn select 1) + 1];
        };
        case independent: {
            unitArrayRespawn set [2, (unitArrayRespawn select 2) + 1];
        };
        case west: {
            unitArrayRespawn set [3, (unitArrayRespawn select 3) + 1];
        };
        default { };
    };
}];