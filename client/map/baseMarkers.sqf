baseMarkers = [["temp_marker_freedom", ["temp_marker_freedom_supply", "temp_marker_freedom_spawn", "temp_marker_freedom_spawn_plane"]]];

[{
	_control = (findDisplay 12) displayCtrl 51;

	if (ctrlMapScale _control > 0.13) then {
		{
			(_x select 0) setMarkerAlpha 1;

			{
				_x setMarkerAlpha 0;
			} forEach (_x select 1);
		} forEach baseMarkers;
	} else {
		if (ctrlMapScale _control < 0.03) then {
			{
				(_x select 0) setMarkerAlpha 0;

				{
					_x setMarkerAlpha 1;
				} forEach (_x select 1);
			} forEach baseMarkers;
		} else {
			{
				(_x select 0) setMarkerAlpha (1 - ((0.13 - (ctrlMapScale _control)) * 10));

				{
					_x setMarkerAlpha ((0.13 - (ctrlMapScale _control)) * 10);
				} forEach (_x select 1);
			} forEach baseMarkers;
		}
	};
}] call CBA_fnc_addPerFrameHandler