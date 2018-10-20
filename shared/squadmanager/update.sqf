{
	_groupIndex = _forEachIndex;
	if (isNull (_x select 2)) then {
		_grp = createGroup [west,false];
		_grp setGroupId [_x select 0];
		_grp setVariable ["BIS_dg_ins", _x select 1, true];
		_grp setVariable ["max_units", _x select 3, true];
		_leader = leader _grp;
		_data = [_x select 1, _x select 0, false];
		playerGroups select _forEachIndex set [2, _grp];

		["RegisterGroup", [_grp, _leader, _data]] call Phobos_squadmanagerDynamicGroups;
	};

	/*_grp = (_x select 2);
	{
		_index = _forEachIndex;
		if(isNull (_x select 2))then{
			_unit = _grp createUnit["B_soldier_F",[100,100,0],[],0,"CAN_COLLIDE"];
			_unit setName "open";
			_unit allowDamage false;
			_unit enableSimulationGlobal false;
			_unit hideObjectGlobal true;
			_unit setVariable["role_index",_forEachIndex,true];
			_unit setVariable["group_index",_groupIndex,true];
			_x set[2,_unit];
		}else{
			if(!isPlayer (_x select 2))then{
				(_x select 2) setName "open";
			};
		};
	} forEach (_x select 4);*/
} forEach playerGroups;

remoteExecutedOwner publicVariableClient "playerGroups";