_actionTalk = ["phobos_action_talk", "Talk", "", {
	params ["_target", "_player", "_param"];
	if (_target getVariable ["phobos_ai_friendly", false]) then {
		_target setDir (_target getRelDir _player) + (getDir _target);
		_player setDir (_player getRelDir _target) + (getDir _player);;
		_target playMoveNow "Acts_CivilTalking_2";
		_player switchMove "Acts_NATOCommanderArrival_Commander_5";

		[20, _this, {
			(_this select 0) params ["_target", "_player", "_param"];

			_zone = [getPosATL _target] call Phobos_miscGetZone;
			_target globalChat ("Good boy");

			_target switchMove "";
			_player switchMove "amovpercmstpslowwrfldnon";
		}, {
			(_this select 0) params ["_target", "_player", "_param"];
			_target switchMove "";
			_player switchMove "amovpercmstpslowwrfldnon";
		}, "Talking", {
			(_this select 0) params ["_target", "_player", "_param"];
			behaviour _target == "SAFE"
		}] call ace_common_fnc_progressBar
	} else {
		_zone = [getPosATL _target] call Phobos_miscGetZone;
		switch true do {
			case ((_zone select 2) < 0.3): {
				_target globalChat (selectRandom ["Stay away, you filthy Americans", "You are all a disgrace to god"]);
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
	behaviour _target == "SAFE" && side _target == civilian
}, {}, []] call ace_interact_menu_fnc_createAction;
["CAManBase", 0, ["ACE_Head"], _actionTalk, true] call ace_interact_menu_fnc_addActionToClass;