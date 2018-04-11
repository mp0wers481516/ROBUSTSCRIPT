#Include %A_ScriptDir%\..\SYSTEM\ROBUSTSCRIPT-CORE.ahk
return

/*
ROBUSTSCRIPT Functions:

MOUSE_JUMPTO("TARGET_NAME" [, CLICKS=1, DELAY=%1_DELAY_MS%])
	MOUSE_JUMPTO("OTHER HAND" [, CLICKS=1, DELAY=%1_DELAY_MS%])
SWAP_HANDS([DELAY=%1_DELAY_MS%])
USE_HANDS([TIMES=1, DELAY=%1_DELAY_MS%])
CHEM_DISPENSER(PARAM1 [, PARAM2, PARAM3])
	CHEM_DISPENSER(0)
	CHEM_DISPENSER("EJECT" [, CLOSE=0, DELAY=%2_DELAY_MS%])
	CHEM_DISPENSER("CLOSE" [, EJECT=1, DELAY=%2_DELAY_MS%])
	CHEM_DISPENSER("CHEM NAME" [, UNITS=0, DELAY=%2_DELAY_MS%])
	CHEM_DISPENSER(UNITS [, "CHEM NAME", DELAY=%2_DELAY_MS%])
	CHEM_DISPENSER(UNITS [, DELAY=%2_DELAY_MS%])
*/

NumpadSub:: ;PANIC BUTTON (NUMPAD-)
Reload
return

/*
BurnBrute Patch

Hotkey-Mode must be on (TAB)

Inventory Assignment:

ACTIVE HAND = large beaker
*/

NumpadDiv:: ;STARTUP BUTTON (NUMPAD/)
MOUSE_JUMPTO("PLAYER UP", 2) ;not case sensitive
CHEM_DISPENSER(0) ;set chem dispenser static variables to defaults
CHEM_DISPENSER(-100) ;clear beaker
CHEM_DISPENSER(+5, "Nitrogen") ;not case sensitive
CHEM_DISPENSER(+15, "Hydrogen")
CHEM_DISPENSER(+15, "Silver")
CHEM_DISPENSER(+15, "Sulfur")
CHEM_DISPENSER(+15, "Oxygen")
CHEM_DISPENSER(+15, "Chlorine")
CHEM_DISPENSER(-35, "Silver Sulfadiazine") ;"Silver Sulfadiazine" can be omitted
CHEM_DISPENSER(+10, "Aluminium")
CHEM_DISPENSER(+10, "Hydrogen")
CHEM_DISPENSER(+10, "Oxygen")
CHEM_DISPENSER(+10, "Sulphuric Acid")
CHEM_DISPENSER("CLOSE") ;not case sensitive
return