_actionTalk = ["phobos_action_talk", "Talk", "", {
	params ["_target", "_player", "_param"];

	if (_target getVariable ["phobos_ai_friendly", false]) then {
		if (_target getVariable ["phobos_ai_intel", true]) then {
			[_target, (_target getRelDir _player) + (getDir _target)] remoteExecCall ["setDir", _target];
			_player setDir (_player getRelDir _target) + (getDir _player);
			[_target, "Acts_CivilTalking_2"] remoteExecCall ["playMoveNow", _target];
			_player switchMove "Acts_NATOCommanderArrival_Commander_5";

			[20, _this, {
				(_this select 0) params ["_target", "_player", "_param"];

				[random 5, getPosATL _target] remoteExecCall ["Phobos_intelAdd", 2]; 
				_target setVariable ["phobos_ai_intel", false, true];

				[_target, ""] remoteExecCall ["switchMove", _target];
				_player switchMove "amovpercmstpslowwrfldnon";
			}, {
				(_this select 0) params ["_target", "_player", "_param"];

				[_target, ""] remoteExecCall ["switchMove", _target];
				_player switchMove "amovpercmstpslowwrfldnon";
			}, "Talking", {
				(_this select 0) params ["_target", "_player", "_param"];
				
				behaviour _target == "SAFE" && alive _target
			}] call ace_common_fnc_progressBar;
		} else {
			_target globalChat (selectRandom ["I have already told you what I know", "You already know everthing"]);
		};
	} else {
		_zone = [getPosATL _target] call Phobos_miscGetZone;
		switch true do {
			case ((_zone select 2) < 0.3): {
				_target globalChat (selectRandom ["Stay away, you filthy Americans", "You are all a disgrace to Allah"]);
			};
			case ((_zone select 2) < 0.6): {
				_target globalChat (selectRandom ["Leave me alone", "Go away"]);
			};
			default {
				_target globalChat (selectRandom ["I have nothing to tell you", "I know nothing"]);
			};
		};
	};
}, {
	params ["_target", "_player", "_param"];

	alive _target && behaviour _target == "SAFE" && _target getVariable ["phobos_ai_side", civilian] == civilian
}, {}, []] call ace_interact_menu_fnc_createAction;
["CAManBase", 0, ["ACE_Head"], _actionTalk, true] call ace_interact_menu_fnc_addActionToClass;