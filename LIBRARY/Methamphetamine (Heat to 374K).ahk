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
Methamphetamine (Heat to 374K)

Hotkey-Mode must be on (TAB)

Inventory Assignment:

ACTIVE HAND = large beaker
POCKET 1 = cheap lighter or Zippo lighter (off)
*/

NumpadDiv:: ;STARTUP BUTTON (NUMPAD/)
MOUSE_JUMPTO("PLAYER UP", 2) ;not case sensitive
CHEM_DISPENSER(0) ;set chem dispenser static variables to defaults
CHEM_DISPENSER(-100) ;clear beaker
CHEM_DISPENSER(+5, "Nitrogen") ;not case sensitive
CHEM_DISPENSER(+15, "Ethanol")
CHEM_DISPENSER(+10, "Welding Fuel")
CHEM_DISPENSER(+10, "Carbon")
CHEM_DISPENSER(+25, "Hydrogen")
CHEM_DISPENSER(-10, "Diethylamine & Oil") ;"Diethylamine & Oil" can be omitted
CHEM_DISPENSER(+25, "Sugar")
CHEM_DISPENSER(+25, "Hydrogen")
CHEM_DISPENSER(-75, "Ephedrine")
CHEM_DISPENSER(+25, "Iodine")
CHEM_DISPENSER(+25, "Phosphorus")
CHEM_DISPENSER(+25, "Hydrogen")
CHEM_DISPENSER("CLOSE") ;not case sensitive
SWAP_HANDS()
MOUSE_JUMPTO("POCKET 1")
USE_HANDS()
MOUSE_JUMPTO("OTHER HAND", 3) ;not case sensitive
USE_HANDS()
MOUSE_JUMPTO("POCKET 1")
SWAP_HANDS()
return