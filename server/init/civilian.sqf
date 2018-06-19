_housesDense = [(housesVillages + housesTowns + housesCapitals)] call CBA_fnc_shuffle;
_housesRemote = [housesRemote] call CBA_fnc_shuffle;

{
	[getPosATL _x, unitsCivilian, 1, civilian] call Phobos_spawnVirtualGroup;
} forEach (_housesDense select [0, (count _housesDense) * 0.04]);

{
	[getPosATL _x, unitsCivilian, 1, civilian] call Phobos_spawnVirtualGroup;
} forEach (_housesRemote select [0, (count _housesRemote) * 0.28]);