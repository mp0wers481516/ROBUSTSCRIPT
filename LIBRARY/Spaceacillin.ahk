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
Spaceacillin

Hotkey-Mode must be on (TAB)

Inventory Assignment:

ACTIVE HAND = large beaker
*/

NumpadDiv:: ;STARTUP BUTTON (NUMPAD/)
MOUSE_JUMPTO("PLAYER UP", 2) ;not case sensitive
CHEM_DISPENSER(0) ;set chem dispenser static variables to defaults
CHEM_DISPENSER(-100) ;clear beaker
CHEM_DISPENSER(+10, "Welding Fuel") ;not case sensitive
CHEM_DISPENSER(+10, "Carbon")
CHEM_DISPENSER(+10, "Hydrogen")
CHEM_DISPENSER(+15, "Welding Fuel")
CHEM_DISPENSER(+15, "Oxygen")
CHEM_DISPENSER(+15, "Water")
CHEM_DISPENSER(+15, "Chlorine")
CHEM_DISPENSER(-30, "Acetone & Phenol") ;"Acetone & Phenol" can be omitted
CHEM_DISPENSER(+15, "Ethanol")
CHEM_DISPENSER(+15, "Hydrogen")
CHEM_DISPENSER(+5, "Nitrogen")
CHEM_DISPENSER(-45, "Acetone & Phenol & Diethylamine")
CHEM_DISPENSER(+15, "Oxygen")
CHEM_DISPENSER(+15, "Chlorine")
CHEM_DISPENSER(+15, "Hydrogen")
CHEM_DISPENSER(-45, "Epinephrine")
CHEM_DISPENSER(+15, "Oxygen")
CHEM_DISPENSER(+15, "Potassium")
CHEM_DISPENSER(+15, "Sugar")
CHEM_DISPENSER("CLOSE") ;not case sensitive
return