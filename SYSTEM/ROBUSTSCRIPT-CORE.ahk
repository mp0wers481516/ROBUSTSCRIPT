/*
ROBUSTSCRIPT CORE 1.0
by Egor T (Mp0wers)
*/

global 1_DELAY_MS, 2_DELAY_MS, 3_DELAY_MS, RES_FACTOR, HOME_X, HOME_Y, HOME_ICON, HAND_ACTIVE_COLOR, HAND_ACTIVE_COLOR_SHADES
CoordMode, Pixel, Screen
CoordMode, Mouse, Screen
SetDefaultMouseSpeed, 0
SetMouseDelay, 25
Menu, Tray, Icon, %A_ScriptDir%\..\SYSTEM\ICONS\icon.ico
Gosub, LOAD_SETTINGS
Gosub, LOAD_UI_STYLE
Gui, New,, ROBUSTSCRIPT CORE 1.0
Gui, Add, Text, Section, CURRENT SCRIPT:
Gui, Add, Edit, ReadOnly W120 H20 ys, %CURRENT_SCRIPT%
Gui, Add, Button, Section xs, RETURN TO LAUNCHER
Gui, Add, Button, ys, RELOAD SCRIPT
Gui, Show, Minimize
return

GuiClose:
ExitApp
return

ButtonRETURNTOLAUNCHER:
Run, %A_ScriptDir%\..\ROBUSTSCRIPT-LAUNCHER.exe,, UseErrorLevel
if (ErrorLevel = 0)
{
	ExitApp
}
else
{
	MsgBox,, ERROR!, ERROR IS OCCURED WHEN RETURNING TO THE LAUNCHER!
}
return

ButtonRELOADSCRIPT:
Reload
return

LOAD_SETTINGS:
SplitPath, A_ScriptFullPath,,,, CURRENT_SCRIPT
IniRead, 1_DELAY_MS, %A_ScriptDir%\..\SYSTEM\SETTINGS.ini, ADVANCED_SETTINGS, 1_DELAY_MS
IniRead, 2_DELAY_MS, %A_ScriptDir%\..\SYSTEM\SETTINGS.ini, ADVANCED_SETTINGS, 2_DELAY_MS
IniRead, 3_DELAY_MS, %A_ScriptDir%\..\SYSTEM\SETTINGS.ini, ADVANCED_SETTINGS, 3_DELAY_MS
IniRead, UI_STYLE, %A_ScriptDir%\..\SYSTEM\SETTINGS.ini, ADVANCED_SETTINGS, UI_STYLE, MIDNIGHT
IniRead, RES_FACTOR, %A_ScriptDir%\..\SYSTEM\SETTINGS.ini, MASTER_SETTINGS, RES_FACTOR
IniRead, HOME_X, %A_ScriptDir%\..\SYSTEM\SETTINGS.ini, MASTER_SETTINGS, HOME_X
IniRead, HOME_Y, %A_ScriptDir%\..\SYSTEM\SETTINGS.ini, MASTER_SETTINGS, HOME_Y
if 1_DELAY_MS is not integer
{
	1_DELAY_MS := 200
}
else if (1_DELAY_MS < 0)
{
	1_DELAY_MS := 0
}
if 2_DELAY_MS is not integer
{
	2_DELAY_MS := 300
}
else if (2_DELAY_MS < 0)
{
	2_DELAY_MS := 0
}
if 3_DELAY_MS is not integer
{
	3_DELAY_MS := 1500
}
else if (3_DELAY_MS < 0)
{
	3_DELAY_MS := 0
}
if RES_FACTOR is not number
{
	MsgBox,, NEEDS SETUP!, PLEASE, SELECT "SETUP MASTER" FROM "ADVANCED SETTINGS" TAB.
	Gosub, ButtonRETURNTOLAUNCHER
}
if HOME_X is not integer
{
	MsgBox,, NEEDS SETUP!, PLEASE, SELECT "SETUP MASTER" FROM "ADVANCED SETTINGS" TAB.
	Gosub, ButtonRETURNTOLAUNCHER
}
if HOME_Y is not integer
{
	MsgBox,, NEEDS SETUP!, PLEASE, SELECT "SETUP MASTER" FROM "ADVANCED SETTINGS" TAB.
	Gosub, ButtonRETURNTOLAUNCHER
}
return

LOAD_UI_STYLE:
IniRead, HOME_ICON, %A_ScriptDir%\..\SYSTEM\UI_STYLES.ini, %UI_STYLE%, HOME_ICON
IniRead, HAND_ACTIVE_COLOR, %A_ScriptDir%\..\SYSTEM\UI_STYLES.ini, %UI_STYLE%, HAND_ACTIVE_COLOR
IniRead, HAND_ACTIVE_COLOR_SHADES, %A_ScriptDir%\..\SYSTEM\UI_STYLES.ini, %UI_STYLE%, HAND_ACTIVE_COLOR_SHADES
return

TARGET_CHECK()
{
	global TARGET_X, TARGET_Y
	if TARGET_X is not integer
	{
		Exit
	}
	if TARGET_Y is not integer
	{
		Exit
	}
	return
}

#IfWinActive ahk_exe dreamseeker.exe

; ROBUSTSCRIPT FUNCTIONS

MOUSE_JUMPTO(TARGET_NAME, CLICKS:="", DELAY:="")
{
	global HOME_X, HOME_Y, TARGET_X, TARGET_Y
	StringUpper, TARGET_NAME, TARGET_NAME
	StringReplace, TARGET_NAME, TARGET_NAME, _,, All
	StringReplace, TARGET_NAME, TARGET_NAME, %A_Space%,, All
	if CLICKS is not integer
	{
		CLICKS := 1
	}
	if DELAY is not integer
	{
		DELAY = %1_DELAY_MS%
	}
	else if (DELAY < 0)
	{
		DELAY := 0
	}
	if (TARGET_NAME = "OTHERHAND")
	{
		IniRead, TARGET_X, %A_ScriptDir%\..\SYSTEM\COORDS\BASIC.ini, HAND1, X
		IniRead, TARGET_Y, %A_ScriptDir%\..\SYSTEM\COORDS\BASIC.ini, HAND1, Y
		TARGET_CHECK()
		if (RES_FACTOR != 1)
		{
			BORDER_PX := Floor(RES_FACTOR / 0.5) + 1
		}
		else
		{
			BORDER_PX := 1
		}
		PixelSearch,,, Floor(HOME_X + TARGET_X * RES_FACTOR), Floor(HOME_Y + TARGET_Y * RES_FACTOR), Floor(HOME_X + TARGET_X * RES_FACTOR) + BORDER_PX, Floor(HOME_Y + TARGET_Y * RES_FACTOR) + BORDER_PX, %HAND_ACTIVE_COLOR%, %HAND_ACTIVE_COLOR_SHADES%, Fast RGB
		if (ErrorLevel = 0)
		{
			TARGET_NAME := "HAND2"
		}
		else
		{
			TARGET_NAME := "HAND1"
		}
	}
	IniRead, TARGET_X, %A_ScriptDir%\..\SYSTEM\COORDS\BASIC.ini, %TARGET_NAME%, X_CENTER
	IniRead, TARGET_Y, %A_ScriptDir%\..\SYSTEM\COORDS\BASIC.ini, %TARGET_NAME%, Y_CENTER
	TARGET_CHECK()
	if (CLICKS > 0)
	{
		Loop, %CLICKS%
		{
			MouseMove, Floor(HOME_X + TARGET_X * RES_FACTOR), Floor(HOME_Y + TARGET_Y * RES_FACTOR)
			Click
			Sleep, %DELAY%
		}
	}
	else
	{
		MouseMove, Floor(HOME_X + TARGET_X * RES_FACTOR), Floor(HOME_Y + TARGET_Y * RES_FACTOR)
		Sleep, %DELAY%
	}
	return
}

SWAP_HANDS(DELAY:="")
{
	if DELAY is not integer
	{
		DELAY = %1_DELAY_MS%
	}
	else if (DELAY < 0)
	{
		DELAY := 0
	}
	SendInput {vk58sc02D}
	Sleep, %DELAY%
	return
}

USE_HANDS(TIMES:="", DELAY:="")
{
	if TIMES is not integer
	{
		TIMES := 1
	}
	if DELAY is not integer
	{
		DELAY = %1_DELAY_MS%
	}
	else if (DELAY < 0)
	{
		DELAY := 0
	}
	Loop, %TIMES%
	{
		SendInput {vk5Asc02C}
		Sleep, %DELAY%
	}
	return
}

CHEM_DISPENSER(PARAM1, PARAM2:="", PARAM3:="")
{
	global TARGET_X, TARGET_Y
	static DEVICESCREEN_UID := "", LAST_PLUS_UNITS := 0
	Gosub, CHEM_DISPENSER_CHECK
	if PARAM1 is not integer
	{
		StringUpper, PARAM1, PARAM1
		StringReplace, PARAM1, PARAM1, _,, All
		StringReplace, PARAM1, PARAM1, %A_Space%,, All
		if ((PARAM1 = "EJECT") OR (PARAM1 = "CLOSE"))
		{
			if ((PARAM2 != 0) AND (PARAM2 != 1))
			{
				if (PARAM1 = "EJECT")
				{
					PARAM2 := 0
				}
				else if (PARAM1 = "CLOSE")
				{
					PARAM2 := 1
				}
			}
			if PARAM3 is not integer
			{
				DELAY = %2_DELAY_MS%
			}
			else
			{
				DELAY = %PARAM3%
			}
			Gosub, CHEM_DISPENSER_EJECTCLOSE
		}
		else
		{
			CHEM_NAME = %PARAM1%
			if PARAM2 is not integer
			{
				UNITS := 0
			}
			else
			{
				UNITS = %PARAM2%
			}
			if PARAM3 is not integer
			{
				DELAY = %2_DELAY_MS%
			}
			else
			{
				DELAY = %PARAM3%
			}
			Gosub, CHEM_DISPENSER_PROCESS
		}
	}
	else
	{
		UNITS = %PARAM1%
		if PARAM2 is not integer
		{
			CHEM_NAME = %PARAM2%
			if PARAM3 is not integer
			{
				DELAY = %2_DELAY_MS%
			}
			else
			{
				DELAY = %PARAM3%
			}
		}
		else
		{
			CHEM_NAME := ""
			DELAY = %PARAM2%
		}
		Gosub, CHEM_DISPENSER_PROCESS
	}
	return
	
	CHEM_DISPENSER_CHECK:
	Loop, 10
	{
		IfWinNotExist, ahk_id %DEVICESCREEN_UID%
		{
			MouseMove, A_ScreenWidth / 2, A_ScreenHeight / 2
			MouseGetPos,,, DEVICESCREEN_UID
		}
		WinGetPos, DEVICESCREEN_X, DEVICESCREEN_Y,,, ahk_id %DEVICESCREEN_UID%
		IniRead, TARGET_X, %A_ScriptDir%\..\SYSTEM\COORDS\CHEM_DISPENSER\CHEMICALS.ini, ALUMINIUM, X
		IniRead, TARGET_Y, %A_ScriptDir%\..\SYSTEM\COORDS\CHEM_DISPENSER\CHEMICALS.ini, ALUMINIUM, Y
		TARGET_CHECK()
		PixelSearch,,, DEVICESCREEN_X + TARGET_X + 2, DEVICESCREEN_Y + TARGET_Y + 2, DEVICESCREEN_X + TARGET_X + 2, DEVICESCREEN_Y + TARGET_Y + 2, 0x40628a, 32, Fast RGB
		if (ErrorLevel = 0)
		{
			PixelSearch,,, DEVICESCREEN_X + TARGET_X, DEVICESCREEN_Y + TARGET_Y, DEVICESCREEN_X + TARGET_X + 10, DEVICESCREEN_Y + TARGET_Y + 10, 0xffffff,, Fast RGB
			if (ErrorLevel = 0)
			{
				IniRead, TARGET_X, %A_ScriptDir%\..\SYSTEM\COORDS\CHEM_DISPENSER_BROKEN\CHEMICALS.ini, SODIUM, X
				IniRead, TARGET_Y, %A_ScriptDir%\..\SYSTEM\COORDS\CHEM_DISPENSER_BROKEN\CHEMICALS.ini, SODIUM, Y
				TARGET_CHECK()
				PixelSearch,,, DEVICESCREEN_X + TARGET_X + 2, DEVICESCREEN_Y + TARGET_Y + 2, DEVICESCREEN_X + TARGET_X + 2, DEVICESCREEN_Y + TARGET_Y + 2, 0x40628a, 32, Fast RGB
				if (ErrorLevel = 0)
				{
					PATH_SUFFIX := "_BROKEN"
				}
				else
				{
					PATH_SUFFIX := ""
				}
				break
			}
		}
		DEVICESCREEN_UID := ""
		if (A_Index = 10)
		{
			Exit
		}
		Sleep, 250
	}
	BEAKERS_READY := "100 50 30"
	CURRENT_BEAKER := 0
	Loop, Parse, BEAKERS_READY, %A_Space%
	{
		IniRead, TARGET_X, %A_ScriptDir%\..\SYSTEM\COORDS\CHEM_DISPENSER%PATH_SUFFIX%\BEAKER_%A_LoopField%.ini, MINUS5, X
		IniRead, TARGET_Y, %A_ScriptDir%\..\SYSTEM\COORDS\CHEM_DISPENSER%PATH_SUFFIX%\BEAKER_%A_LoopField%.ini, MINUS5, Y
		TARGET_CHECK()
		PixelSearch,,, DEVICESCREEN_X + TARGET_X + 2, DEVICESCREEN_Y + TARGET_Y + 2, DEVICESCREEN_X + TARGET_X + 2, DEVICESCREEN_Y + TARGET_Y + 2, 0x40628a, 32, Fast RGB
		if (ErrorLevel = 0)
		{
			CURRENT_BEAKER = %A_LoopField%
			if (CURRENT_BEAKER = 100)
			{
				UNITS_READY := "100 50 30 25 20 15 10 5"
			}
			else if (CURRENT_BEAKER = 50)
			{
				UNITS_READY := "50 30 25 20 15 10 5"
			}
			else if (CURRENT_BEAKER = 30)
			{
				UNITS_READY := "30 25 15 10 5"
			}
			break
		}
	}
	return
	
	CHEM_DISPENSER_EJECTCLOSE:
	if (DELAY < 0)
	{
		DELAY := 0
	}
	if (PARAM1 = "EJECT")
	{
		IniRead, TARGET_X, %A_ScriptDir%\..\SYSTEM\COORDS\CHEM_DISPENSER%PATH_SUFFIX%\CHEMICALS.ini, EJECT, X_CENTER
		IniRead, TARGET_Y, %A_ScriptDir%\..\SYSTEM\COORDS\CHEM_DISPENSER%PATH_SUFFIX%\CHEMICALS.ini, EJECT, Y_CENTER
		TARGET_CHECK()
		MouseMove, DEVICESCREEN_X + TARGET_X, DEVICESCREEN_Y + TARGET_Y
		Click
		Sleep, %DELAY%
		if (PARAM2 = 1)
		{
			WinKill, ahk_id %DEVICESCREEN_UID%
			Sleep, %DELAY%
		}
	}
	else if (PARAM1 = "CLOSE")
	{
		if (PARAM2 = 1)
		{
			IniRead, TARGET_X, %A_ScriptDir%\..\SYSTEM\COORDS\CHEM_DISPENSER%PATH_SUFFIX%\CHEMICALS.ini, EJECT, X_CENTER
			IniRead, TARGET_Y, %A_ScriptDir%\..\SYSTEM\COORDS\CHEM_DISPENSER%PATH_SUFFIX%\CHEMICALS.ini, EJECT, Y_CENTER
			TARGET_CHECK()
			MouseMove, DEVICESCREEN_X + TARGET_X, DEVICESCREEN_Y + TARGET_Y
			Click
			Sleep, %DELAY%
		}
		WinKill, ahk_id %DEVICESCREEN_UID%
		Sleep, %DELAY%
	}
	return
	
	CHEM_DISPENSER_PROCESS:
	if (DELAY < 0)
	{
		DELAY := 0
	}
	StringUpper, CHEM_NAME, CHEM_NAME
	StringReplace, CHEM_NAME, CHEM_NAME, _,, All
	StringReplace, CHEM_NAME, CHEM_NAME, %A_Space%,, All
	if (UNITS > 0)
	{
		UNITS_TYPE := "PLUS"
	}
	else if (UNITS < 0)
	{
		UNITS_TYPE := "MINUS"
		UNITS := (UNITS) * (-1)
		CHEM_NAME := ""
	}
	if (UNITS != 0)
	{
		if (CURRENT_BEAKER != 0)
		{
			if ((UNITS_TYPE = "MINUS") AND (UNITS > CURRENT_BEAKER))
			{
				UNITS = %CURRENT_BEAKER%
			}
			Loop
			{
				UNITS_NOW := 0
				Loop, Parse, UNITS_READY, %A_Space%
				{
					if ((UNITS / A_LoopField) >= 1)
					{
						UNITS_NOW = %A_LoopField%
						break
					}
				}
				if (UNITS_NOW != 0)
				{
					if ((UNITS_NOW = LAST_PLUS_UNITS) AND (CHEM_NAME != ""))
					{
						IniRead, TARGET_X, %A_ScriptDir%\..\SYSTEM\COORDS\CHEM_DISPENSER%PATH_SUFFIX%\CHEMICALS.ini, %CHEM_NAME%, X_CENTER
						IniRead, TARGET_Y, %A_ScriptDir%\..\SYSTEM\COORDS\CHEM_DISPENSER%PATH_SUFFIX%\CHEMICALS.ini, %CHEM_NAME%, Y_CENTER
						TARGET_CHECK()
						MouseMove, DEVICESCREEN_X + TARGET_X, DEVICESCREEN_Y + TARGET_Y
						Click
						UNITS := UNITS - UNITS_NOW
						Sleep, %DELAY%
					}
					else
					{
						IniRead, TARGET_X, %A_ScriptDir%\..\SYSTEM\COORDS\CHEM_DISPENSER%PATH_SUFFIX%\BEAKER_%CURRENT_BEAKER%.ini, %UNITS_TYPE%%UNITS_NOW%, X_CENTER
						IniRead, TARGET_Y, %A_ScriptDir%\..\SYSTEM\COORDS\CHEM_DISPENSER%PATH_SUFFIX%\BEAKER_%CURRENT_BEAKER%.ini, %UNITS_TYPE%%UNITS_NOW%, Y_CENTER
						TARGET_CHECK()
						MouseMove, DEVICESCREEN_X + TARGET_X, DEVICESCREEN_Y + TARGET_Y
						Click
						if (CHEM_NAME = "")
						{
							UNITS := UNITS - UNITS_NOW
						}
						if (UNITS_TYPE = "PLUS")
						{
							LAST_PLUS_UNITS = %UNITS_NOW%
						}
						Sleep, %DELAY%
						if (CHEM_NAME != "")
						{
							IniRead, TARGET_X, %A_ScriptDir%\..\SYSTEM\COORDS\CHEM_DISPENSER%PATH_SUFFIX%\CHEMICALS.ini, %CHEM_NAME%, X_CENTER
							IniRead, TARGET_Y, %A_ScriptDir%\..\SYSTEM\COORDS\CHEM_DISPENSER%PATH_SUFFIX%\CHEMICALS.ini, %CHEM_NAME%, Y_CENTER
							TARGET_CHECK()
							MouseMove, DEVICESCREEN_X + TARGET_X, DEVICESCREEN_Y + TARGET_Y
							Click
							UNITS := UNITS - UNITS_NOW
							Sleep, %DELAY%
						}
					}
				}
				else
				{
					break
				}
			}
		}
		else
		{
			Exit
		}
	}
	else if (CHEM_NAME != "")
	{
		if (CURRENT_BEAKER != 0)
		{
			IniRead, TARGET_X, %A_ScriptDir%\..\SYSTEM\COORDS\CHEM_DISPENSER%PATH_SUFFIX%\CHEMICALS.ini, %CHEM_NAME%, X_CENTER
			IniRead, TARGET_Y, %A_ScriptDir%\..\SYSTEM\COORDS\CHEM_DISPENSER%PATH_SUFFIX%\CHEMICALS.ini, %CHEM_NAME%, Y_CENTER
			TARGET_CHECK()
			MouseMove, DEVICESCREEN_X + TARGET_X, DEVICESCREEN_Y + TARGET_Y
			Click
			Sleep, %DELAY%
		}
		else
		{
			Exit
		}
	}
	else
	{
		LAST_PLUS_UNITS := 0
		if (CURRENT_BEAKER != 0)
		{
			Loop, Parse, UNITS_READY, %A_Space%
			{
				IniRead, TARGET_X, %A_ScriptDir%\..\SYSTEM\COORDS\CHEM_DISPENSER%PATH_SUFFIX%\BEAKER_%CURRENT_BEAKER%.ini, PLUS%A_LoopField%, X
				IniRead, TARGET_Y, %A_ScriptDir%\..\SYSTEM\COORDS\CHEM_DISPENSER%PATH_SUFFIX%\BEAKER_%CURRENT_BEAKER%.ini, PLUS%A_LoopField%, Y
				TARGET_CHECK()
				PixelSearch,,, DEVICESCREEN_X + TARGET_X + 2, DEVICESCREEN_Y + TARGET_Y + 2, DEVICESCREEN_X + TARGET_X + 2, DEVICESCREEN_Y + TARGET_Y + 2, 0x2f943c,, Fast RGB
				if (ErrorLevel = 0)
				{
					LAST_PLUS_UNITS = %A_LoopField%
					break
				}
			}
		}
	}
	return
}