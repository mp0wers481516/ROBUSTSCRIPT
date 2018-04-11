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
Krokodil

Hotkey-Mode must be on (TAB)

Inventory Assignment:

ACTIVE HAND = large beaker
POCKET 1 = cheap lighter or Zippo lighter (off)
POCKET 2 = morphine bottle (transfer amount is set to 15 units)
*/

NumpadDiv:: ;STARTUP BUTTON (NUMPAD/)
MOUSE_JUMPTO("PLAYER UP", 2) ;not case sensitive
CHEM_DISPENSER(0) ;set chem dispenser static variables to defaults
CHEM_DISPENSER(-100) ;clear beaker
CHEM_DISPENSER(+5, "Nitrogen") ;not case sensitive
CHEM_DISPENSER(+15, "Hydrogen")
CHEM_DISPENSER(+15, "Ethanol")
CHEM_DISPENSER(-15, "Diethylamine") ;"Diethylamine" can be omitted
CHEM_DISPENSER(+15, "Bromine")
CHEM_DISPENSER(+15, "Ethanol")
CHEM_DISPENSER(+20, "Carbon")
CHEM_DISPENSER(+5, "Welding Fuel")
CHEM_DISPENSER(+5, "Hydrogen")
CHEM_DISPENSER(-30, "Diphenhydramine")
CHEM_DISPENSER(+5, "Nitrogen")
CHEM_DISPENSER(+15, "Hydrogen")
CHEM_DISPENSER(+15, "Water")
CHEM_DISPENSER(-30, "Diphenhydramine & Space Cleaner")
CHEM_DISPENSER(+15, "Potassium")
CHEM_DISPENSER(+15, "Phosphorus")
CHEM_DISPENSER(+15, "Welding Fuel")
CHEM_DISPENSER("CLOSE") ;not case sensitive
SWAP_HANDS()
MOUSE_JUMPTO("POCKET 2")
MOUSE_JUMPTO("OTHER HAND") ;not case sensitive
MOUSE_JUMPTO("POCKET 2")
MOUSE_JUMPTO("POCKET 1")
USE_HANDS()
MOUSE_JUMPTO("OTHER HAND", 5)
USE_HANDS()
MOUSE_JUMPTO("POCKET 1")
SWAP_HANDS()
return