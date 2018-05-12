housesNormal = [];
housesBlack = [];
housesSafe = [];
housesVillages = [];
housesTowns = [];
housesCapitals = [];
housesRemote = [];

//Strategic compounds
strategic = nearestObjects [[worldSize/2,worldSize/2], ["Land_BagBunker_Small_F","Land_Cargo_House_V1_F","Land_Cargo_House_V2_F","Land_Cargo_House_V3_F","Land_BagBunker_Large_F","Land_BagBunker_Tower_F",
"Land_Cargo_HQ_V1_F","Land_Cargo_HQ_V2_F","Land_Cargo_HQ_V3_F","Land_Cargo_Patrol_V1_F","Land_Cargo_Patrol_V2_F","Land_Cargo_Patrol_V3_F","Land_Cargo_Tower_V1_F","Land_Cargo_Tower_V1_No1_F","Land_Cargo_Tower_V1_No2_F",
"Land_Cargo_Tower_V1_No3_F","Land_Cargo_Tower_V1_No4_F","Land_Cargo_Tower_V1_No5_F","Land_Cargo_Tower_V1_No6_F","Land_Cargo_Tower_V1_No7_F","Land_Cargo_Tower_V2_F","Land_Cargo_Tower_V3_F"], (worldSize*2^0.5)];

//Houses
_housesBlacklist = nearestObjects [[worldSize/2,worldSize/2], ["Land_MilOffices_V1_F","Land_nav_pier_m_F","Land_Pier_addon","Land_Pier_Box_F","Land_Pier_F","Land_Pier_small_F","Land_Pier_wall_F"], (worldSize*2^0.5)];
_houses = ((nearestObjects [[worldSize/2,worldSize/2], ["house"], (worldSize*2^0.5)]) - strategic - _housesBlacklist);

{
    if (count (_x buildingPos -1) > 3) then {
        _x setVehicleVarName format["house_%1", _forEachIndex];
        if ((getPosWorld _x) inArea "mrk_base_0" || (getPosWorld _x) inArea "mrk_base_1" || (getPosWorld _x) inArea "mrk_base_2" || (getPosWorld _x) inArea "mrk_base_3") then {
            housesBlack pushBack _x;
        } else {
            if ((getPosWorld _x) inArea "mrk_safeZone") then {
                housesSafe pushBack _x;
            } else {
                housesNormal pushBack _x;
            };
        };
    };
} forEach _houses;

villages = nearestLocations [[worldSize/2,worldSize/2], ["NameVillage"], (worldSize*2^0.5)];
towns = nearestLocations [[worldSize/2,worldSize/2], ["NameCity","NameLocal"], (worldSize*2^0.5)];
capitals = nearestLocations [[worldSize/2,worldSize/2], ["NameCityCapital"], (worldSize*2^0.5)];

{
    _house = _x;
    {
        if ((getPos _x) distance2D _house < 100) then {
            housesVillages pushBack _house;
        };
    } forEach villages;

    {
        if ((getPos _x) distance2D _house < 200) then {
            housesTowns pushBack _house;
        };
    } forEach towns;

    {
        if ((getPos _x) distance2D _house < 300) then {
            housesCapitals pushBack _house;
        };
    } forEach capitals;

    //House damage decreases approval
    _house addEventHandler ["Dammaged", {
	    params ["_house", "_selection", "_damage", "_hitIndex", "_hitPoint", "_shooter", "_projectile"];

        if (damage _house > 0.5) then {
            _zone = (zones select {_house inArea (_x select 1)}) select 0;
            _zone set [2, (_zone select 2) - 0.01];
        };
    }];
} forEach housesNormal + housesSafe;

housesRemote = housesNormal - (housesVillages + housesTowns + housesCapitals);