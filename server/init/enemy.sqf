//Dense
_housesDense = [(housesVillages + housesTowns + housesCapitals)] call CBA_fnc_shuffle;
_housesRemote = [housesRemote] call CBA_fnc_shuffle;

{
	[getPosATL _x, unitsEnemy, 2 + (random 3), east] call Phobos_spawnVirtualGroup;
} forEach (_housesDense select [0, (count _housesDense) * 0.03]);

{
	[getPosATL _x, unitsEnemy, 3 + (random 3), east] call Phobos_spawnVirtualGroup;
} forEach (_housesRemote select [0, (count _housesRemote) * 0.05]);