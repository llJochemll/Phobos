_actionInterrogate = ["phobos_action_interrogate", "Interrogate", "", {
	params ["_target", "_player", "_param"];

	if (_target getVariable ["phobos_ai_intel", true]) then {
		[_target, (_target getRelDir _player) + (getDir _target)] remoteExecCall ["setDir", _target];
		_player setDir (_player getRelDir _target) + (getDir _player);
		_player switchMove "Acts_NATOCommanderArrival_Commander_5";

		[60, _this, {
			(_this select 0) params ["_target", "_player", "_param"];

			_multiplier = 1;

			if (_target inArea phobos_trigger_prison) then {
				_multiplier = _multiplier * 2;
			};

			_target setVariable ["phobos_ai_intel", false, true];
			if (_target getVariable ["phobos_ai_officer", false]) then {
				[(10 + random 20) * _multiplier, getPosATL _target] remoteExecCall ["Phobos_intelAdd", 2];
			} else {
				[(1 + random 5) * _multiplier, getPosATL _target] remoteExecCall ["Phobos_intelAdd", 2];
			};

			_player switchMove "amovpercmstpslowwrfldnon";
		}, {
			(_this select 0) params ["_target", "_player", "_param"];

			_player switchMove "amovpercmstpslowwrfldnon";
		}, "Interrogating", {
			(_this select 0) params ["_target", "_player", "_param"];

			alive _target;
		}] call ace_common_fnc_progressBar;
	} else {
		_target globalChat (selectRandom ["I have nothing more to tell you, you filthy infidel"]);
	};
}, {
	params ["_target", "_player", "_param"];

	side _target == east
}, {}, []] call ace_interact_menu_fnc_createAction;
["CAManBase", 0, ["ACE_Head"], _actionInterrogate, true] call ace_interact_menu_fnc_addActionToClass;