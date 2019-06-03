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
				if (abs ((abs ((player getRelDir _x) - 180)) - 180) < 45 && (count (weapons _x) == 0 || east countSide (_x nearEntities 100) < 3) && side _x != west) then {
					if (random 1 > 0.7) then {
						_x allowFleeing 0;

						[_x] spawn {
							params ["_unit"];

							_unit setSpeedMode "FULL";

							while {alive _unit} do {
								_target = _unit findNearestEnemy (getPosATL _unit);

								if (!isNull _target) then {
									_unit doMove getPosATL _target;

									if ((_unit distance2D _target) < 25) exitWith {
										[[_unit], {
											params [["_unit", objNull]];
											_unit say3D "scream";

											_grenade = "GrenadeHand" createVehicle (getPosATL _unit); 
											_grenade attachTo [_unit, [0,0,0]];
										}] remoteExec ["BIS_fnc_spawn", 0, true];
									};
								};
							};
						};
					} else {
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
		};

		//Reveal to enemy
		if (side _x == east) then {
			_x reveal [player, 4];
		};
	} forEach ((player nearEntities 50) select {[objNull, "VIEW"] checkVisibility [eyePos player, eyePos _x] > 0.5});
}, [], 10, true, false, "", "isNull (objectParent _this)"];