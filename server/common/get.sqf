params ["_id"];

_thing = nil;

_groups = allGroups;
_groupIndex = _groups findIf {(_x getVariable ["phobos_common_id", -1]) == _id};
if (_groupIndex != -1) then { 
	_thing = (_groups select _groupIndex);
};

_objects = (allUnits + vehicles + allDead);
_objectIndex = _objects findIf {(_x getVariable ["phobos_common_id", -1]) == _id};
if (_objectIndex != -1) then { 
	_thing = (_objects select _objectIndex);
};

_thing