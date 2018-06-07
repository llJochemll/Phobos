//Exported via Arma Dialog Creator (https://github.com/kayler-renslow/arma-dialog-creator)

class PhobosVehicleSpawnerDialog
{
	idd = -1;
	
	class ControlsBackground
	{
		
	};
	class Controls
	{
		class PhobosVehicleSpawnerTypeSelectListBox
		{
			type = 5;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.00375;
			y = safeZoneY + safeZoneH * 0.01444445;
			w = safeZoneW * 0.2125;
			h = safeZoneH * 0.19555556;
			style = 16;
			colorBackground[] = {0.6,0.6,0.6,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorSelect[] = {1,0,0,1};
			colorText[] = {0,0,0,1};
			font = "PuristaMedium";
			maxHistoryDelay = 0;
			rowHeight = 0;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundSelect[] = {"\A3\ui_f\data\sound\RscListbox\soundSelect",0.09,1.0};
			onLBDrop = "";
			onLBSelChanged = "_this call Phobos_vehicleSpawnerSelectType";
			class ListScrollBar
			{
				color[] = {1,1,1,1};
				thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
				border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
				
			};
			
		};
		class PhobosVehicleSpawnerSpawnButton
		{
			type = 1;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.00375;
			y = safeZoneY + safeZoneH * 0.92444445;
			w = safeZoneW * 0.1025;
			h = safeZoneH * 0.06;
			style = 0;
			text = "Spawn";
			borderSize = 0;
			colorBackground[] = {0,0.75,0,1};
			colorBackgroundActive[] = {0,0.2,0,1};
			colorBackgroundDisabled[] = {0.2,0.2,0.2,1};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0.2,0.2,0.2,1};
			colorShadow[] = {0,0,0,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			offsetPressedX = 0;
			offsetPressedY = 0;
			offsetX = 0.01;
			offsetY = 0.01;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 2);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			onButtonClick = "_this call Phobos_vehicleSpawnerSpawn";
			
		};
		class PhobosVehicleSpawnerRotateSlider
		{
			type = 43;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.11375;
			y = safeZoneY + safeZoneH * 0.92444445;
			w = safeZoneW * 0.7725;
			h = safeZoneH * 0.05555556;
			style = 1024;
			arrowEmpty = "\A3\ui_f\data\GUI\Cfg\Slider\arrowEmpty_ca.paa";
			arrowFull = "\A3\ui_f\data\GUI\Cfg\Slider\arrowFull_ca.paa";
			border = "\A3\ui_f\data\GUI\Cfg\Slider\border_ca.paa";
			color[] = {0.3804,0.5255,0.5843,1};
			colorActive[] = {1,1,1,1};
			thumb = "\A3\ui_f\data\GUI\Cfg\Slider\thumb_ca.paa";
			onSliderPosChanged = "_this call Phobos_vehicleSpawnerRotate";
			
		};
		class PhobosVehicleSpawnerCancelButton
		{
			type = 1;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.89375;
			y = safeZoneY + safeZoneH * 0.92444445;
			w = safeZoneW * 0.1025;
			h = safeZoneH * 0.06;
			style = 0;
			text = "Cancel";
			borderSize = 0;
			colorBackground[] = {0.75,0,0,1};
			colorBackgroundActive[] = {0.6,0,0,1};
			colorBackgroundDisabled[] = {0.2,0.2,0.2,1};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0.2,0.2,0.2,1};
			colorShadow[] = {0,0,0,1};
			colorText[] = {0,0,0,1};
			font = "PuristaMedium";
			offsetPressedX = 0;
			offsetPressedY = 0;
			offsetX = 0.01;
			offsetY = 0.01;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 2);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			
		};
		class PhobosVehicleSpawnerClassSelectListBox
		{
			type = 5;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.00375;
			y = safeZoneY + safeZoneH * 0.22444445;
			w = safeZoneW * 0.2125;
			h = safeZoneH * 0.68555556;
			style = 16;
			colorBackground[] = {0.6,0.6,0.6,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorSelect[] = {1,0,0,1};
			colorText[] = {0,0,0,1};
			font = "PuristaMedium";
			maxHistoryDelay = 0;
			rowHeight = 0;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundSelect[] = {"\A3\ui_f\data\sound\RscListbox\soundSelect",0.09,1.0};
			onLBSelChanged = "_this call Phobos_vehicleSpawnerSelectClass";
			class ListScrollBar
			{
				color[] = {1,1,1,1};
				thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
				border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
				
			};
			
		};
		class PhobosVehicleSpawnerVehicleSelectListBox
		{
			type = 5;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.78375;
			y = safeZoneY + safeZoneH * 0.01444445;
			w = safeZoneW * 0.2125;
			h = safeZoneH * 0.89555556;
			style = 16;
			colorBackground[] = {0.6,0.6,0.6,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorSelect[] = {1,0,0,1};
			colorText[] = {0,0,0,1};
			font = "PuristaMedium";
			maxHistoryDelay = 0;
			rowHeight = 0;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundSelect[] = {"\A3\ui_f\data\sound\RscListbox\soundSelect",0.09,1.0};
			onLBSelChanged = "_this call Phobos_vehicleSpawnerSelectVehicle";
			class ListScrollBar
			{
				color[] = {1,1,1,1};
				thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
				border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
				
			};
			
		};
		
	};
	
};
