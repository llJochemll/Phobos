player addAction ["<t color='#DD2222'>Stop</t>", {
	{
		//Stop units
		if (_x getVariable ["phobos_ai_officer", false] && abs ((abs ((player getRelDir _x) - 180)) - 180) < 45) then {
			if (random 1 > 0.1) then {
				doStop _x;
				["ACE_captives_setSurrendered", [_x, true], _x] call CBA_fnc_targetEvent;
				[{
					params ["_unit"];
					abs ((abs ((player getRelDir _unit) - 180)) - 180) > 45
				}, {
					params ["_unit"];
					[_unit, leader (group _unit)] remoteExecCall ["doFollow", _unit];
					["ACE_captives_setSurrendered", [_unit, false], _unit] call CBA_fnc_targetEvent;
				}, [_x]] call CBA_fnc_waitUntilAndExecute;
			};
		} else {
			if (side _x == civilian) then {
				if (behaviour _x != "COMBAT" || abs ((abs ((player getRelDir _x) - 180)) - 180) < 45) then {
					doStop _x;
					[{
						params ["_unit"];
						player distance2D _unit > 50 || (behaviour _unit == "COMBAT" && abs ((abs ((player getRelDir _unit) - 180)) - 180) > 45)
					}, {
						params ["_unit"];
						[_unit, leader (group _unit)] remoteExecCall ["doFollow", _unit];
					}, [_x]] call CBA_fnc_waitUntilAndExecute;
				};
			} else {
				if (abs ((abs ((player getRelDir _x) - 180)) - 180) < 45 && (count (weapons _x) == 0 || random 1 > 0.95) && side _x != west) then {
					doStop _x;
					["ACE_captives_setSurrendered", [_x, true], _x] call CBA_fnc_targetEvent;
					[{
						params ["_unit"];
						abs ((abs ((player getRelDir _unit) - 180)) - 180) > 45
					}, {
						params ["_unit"];
						[_unit, leader (group _unit)] remoteExecCall ["doFollow", _unit];
						["ACE_captives_setSurrendered", [_unit, false], _unit] call CBA_fnc_targetEvent;
					}, [_x]] call CBA_fnc_waitUntilAndExecute;
				};
			};
		};

		//Reveal to enemy
		if (side _x == east) then {
			_x reveal [player, 4];
		};
	} forEach ((player nearEntities 50) select {[objNull, "VIEW"] checkVisibility [eyePos player, eyePos _x] > 0.5});
}, [], 10];