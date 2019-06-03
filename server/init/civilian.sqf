_housesDense = [housesTowns + housesCapitals] call CBA_fnc_shuffle;
_housesRemote = [housesVillages + housesRemote] call CBA_fnc_shuffle;

{
	[getPosATL _x, unitsCivilian, 1, civilian] call Phobos_spawnVirtualGroup;
} forEach (_housesDense select [0, (count _housesDense) * 0.05]);

{
	[getPosATL _x, unitsCivilian, 1, civilian] call Phobos_spawnVirtualGroup;
} forEach (_housesRemote select [0, (count _housesRemote) * 0.28]);