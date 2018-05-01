//Dense
_housesDense = [(housesVillages + housesTowns + housesCapitals)] call CBA_fnc_shuffle;
_housesRemote = [housesRemote] call CBA_fnc_shuffle;

{
	[getPosASL _x, unitsCivilian, 2, civilian] call Phobos_spawnVirtualGroup;
} forEach (_housesDense select [0, (count _housesDense) * 0.10]);

{
	[getPosASL _x, unitsCivilian, 3, civilian] call Phobos_spawnVirtualGroup;
} forEach (_housesRemote select [0, (count _housesRemote) * 0.3]);