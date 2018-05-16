params ["_id"];

_thing = nil;

_groups = allGroups select {([_x] call Phobos_commonId) == _id};
if (count _groups > 0) then { 
	_thing = (_groups select 0);
};

_objects = (allUnits + vehicles + allDead) select {([_x] call Phobos_commonId) == _id};
if (count _objects > 0) then { 
	_thing = (_objects select 0);
};

_thing