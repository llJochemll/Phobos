_housesDense = [(housesVillages + housesTowns + housesCapitals)] call CBA_fnc_shuffle;
_housesRemote = [housesRemote] call CBA_fnc_shuffle;

{
	switch (_forEachIndex) do {
		//Civilian
        case 0: {
			if ((unitArrayRespawn select 0) > 0) then {
				if (random 8 > 7) then {
					[getPosATL (selectRandom _housesDense), unitsCivilian, 1, civilian] call Phobos_spawnVirtualGroup;
				} else {
					[getPosATL (selectRandom _housesRemote), unitsCivilian, 1, civilian] call Phobos_spawnVirtualGroup;
				};

				unitArrayRespawn set [0, (unitArrayRespawn select 0) - 1];
			};
        };
		//East
        case 1: {
            if ((unitArrayRespawn select 1) > 5) then {
				_count = 0;
				if (random 10 > 7) then {
					_count = round (2 + (random 3));
					[getPosATL (_housesDense select (_housesDense findIf {([getPosATL _x] call Phobos_miscGetZone) select 2 <= 0.6})), unitsEnemy, _count, east] call Phobos_spawnVirtualGroup;
				} else {
					_count = round (3 + (random 3));
					[getPosATL (_housesRemote select (_housesRemote findIf {([getPosATL _x] call Phobos_miscGetZone) select 2 <= 0.6})), unitsEnemy, _count, east] call Phobos_spawnVirtualGroup;
				};

				unitArrayRespawn set [1, (unitArrayRespawn select 1) - _count];
			};
        };
		//Independent
        case 2: {
			
        };
		//West
        case 3: {
            //unitArrayRespawn set [3, (unitArrayRespawn select 3) + 1];
        };
        default { };
    };
	
} forEach unitArrayRespawn;
