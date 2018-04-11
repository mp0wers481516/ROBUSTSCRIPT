/*
ROBUSTSCRIPT LAUNCHER 1.0
by Egor T (Mp0wers)
*/

CoordMode, Pixel, Screen
CoordMode, Mouse, Screen
SetDefaultMouseSpeed, 0
SetMouseDelay, 25
Gosub, LOAD_SETTINGS
Gosub, GET_LIBRARY_CONTENTS
Gosub, GET_UI_STYLES
Gui, New,, ROBUSTSCRIPT LAUNCHER 1.0
Gui, Add, Tab3,, BASIC SETTINGS|ADVANCED SETTINGS|CALC COORDS
Gui, Tab, 1
Gui, Add, Text, Section, CURRENT SCRIPT:
Gui, Add, DropDownList, vCURRENT_SCRIPT Choose%CURRENT_SCRIPT_INDEX% W120 ys, %LIBRARY_CONTENTS%
Gui, Tab, 2
Gui, Add, Text, Section, 1_DELAY_MS:
Gui, Add, Text,, 2_DELAY_MS:
Gui, Add, Text,, 3_DELAY_MS:
Gui, Add, Text,, UI_STYLE:
Gui, Add, Edit, v1_DELAY_MS Number W60 H20 ys, %1_DELAY_MS%
Gui, Add, Edit, v2_DELAY_MS Number W60 H20, %2_DELAY_MS%
Gui, Add, Edit, v3_DELAY_MS Number W60 H20, %3_DELAY_MS%
Gui, Add, DropDownList, vUI_STYLE Choose%UI_STYLE_INDEX% W120, %UI_STYLES%
Gui, Add, Button,, SETUP MASTER
Gui, Add, Text, Section xs, CREDITS:
Gui, Add, Text,, AutoHotkey by Chris Mallett, Steve Gray (Lexikos), fincs
Gui, Add, Text,, Portions AutoIt Team, AHK Community
Gui, Add, Text,, ROBUSTSCRIPT by Egor T (Mp0wers)
Gui, Tab, 3
Gui, Add, Text, Section, COORDS DATABASE:
Gui, Add, Edit, vCOORDS_DATABASE_NAME ReadOnly W120 H20 ys
Gui, Add, Button, ys, BROWSE
Gui, Add, Text, Section xs, TARGET NAME:
Gui, Add, Text,, HOME X:
Gui, Add, Text,, HOME Y:
Gui, Add, Text,, TARGET X:
Gui, Add, Text,, TARGET Y:
Gui, Add, Text,, TARGET W:
Gui, Add, Text,, TARGET H:
Gui, Add, Edit, vTARGET_NAME W120 H20 ys
Gui, Add, Edit, vHOME_X Number W60 H20
Gui, Add, Edit, vHOME_Y Number W60 H20
Gui, Add, Edit, vTARGET_X Number W60 H20
Gui, Add, Edit, vTARGET_Y Number W60 H20
Gui, Add, Edit, vTARGET_W Number W60 H20
Gui, Add, Edit, vTARGET_H Number W60 H20
Gui, Add, Button, xs, CALC COORDS AND SAVE TO DATABASE
Gui, Tab
Gui, Add, Button, Section, SAVE
Gui, Add, Button, Default ys, SAVE AND LAUNCH
Gui, Show
Gui, Submit, NoHide
Gosub, SAVE_SETTINGS
return

GuiClose:
ExitApp
return

ButtonSAVE:
Gui, Submit, NoHide
Gosub, SAVE_SETTINGS
return

ButtonSAVEANDLAUNCH:
Gui, Submit, NoHide
Gosub, SAVE_SETTINGS
if (CURRENT_SCRIPT != "")
{
	Run, %A_ScriptDir%\SYSTEM\AutoHotkey.exe "%A_ScriptDir%\LIBRARY\%CURRENT_SCRIPT%.ahk",, UseErrorLevel
	if (ErrorLevel = 0)
	{
		ExitApp
	}
	else
	{
		MsgBox,, ERROR!, ERROR IS OCCURED WHEN LAUNCHING THE SCRIPT!
	}
}
else
{
	MsgBox,, ERROR!, PLEASE, CHOOSE THE SCRIPT TO LAUNCH!
}
return

ButtonBROWSE:
FileSelectFile, COORDS_DATABASE_PATH,, %A_ScriptDir%\SYSTEM\COORDS\,, COORDS DATABASES (*.ini)
if (ErrorLevel = 0)
{
	SplitPath, COORDS_DATABASE_PATH,,,, COORDS_DATABASE_NAME
	GuiControl,, COORDS_DATABASE_NAME, %COORDS_DATABASE_NAME%
}
return

ButtonCALCCOORDSANDSAVETODATABASE:
Gui, Submit, NoHide
if (COORDS_DATABASE_NAME != "")
{
	StringUpper, TARGET_NAME, TARGET_NAME
	StringReplace, TARGET_NAME, TARGET_NAME, _,, All
	StringReplace, TARGET_NAME, TARGET_NAME, %A_Space%,, All
	TARGET_CENTER_W := Floor(TARGET_W / 2)
	TARGET_CENTER_H := Floor(TARGET_H / 2)
	TARGET_CENTER_X := TARGET_X - HOME_X + TARGET_CENTER_W
	TARGET_CENTER_Y := TARGET_Y - HOME_Y + TARGET_CENTER_H
	TARGET_X := TARGET_X - HOME_X
	TARGET_Y := TARGET_Y - HOME_Y
	IniWrite, %TARGET_X%, %COORDS_DATABASE_PATH%, %TARGET_NAME%, X
	IniWrite, %TARGET_Y%, %COORDS_DATABASE_PATH%, %TARGET_NAME%, Y
	IniWrite, %TARGET_CENTER_X%, %COORDS_DATABASE_PATH%, %TARGET_NAME%, X_CENTER
	IniWrite, %TARGET_CENTER_Y%, %COORDS_DATABASE_PATH%, %TARGET_NAME%, Y_CENTER
	MsgBox,, DONE!, DONE!
}
else
{
	MsgBox,, ERROR!, PLEASE, CHOOSE THE COORDS DATABASE!
}
return

ButtonSETUPMASTER:
MsgBox,, SETUP MASTER, WELCOME TO SETUP MASTER!`nTO BEGIN, CLOSE THIS DIALOG AND:`nMOVE THE MOUSE CURSOR IN ORDER TO EACH POSITION AS IN "SETUP GUIDE.png"`nPRESS "SPACE" AFTER MOVING TO EACH POSITION.
KeyWait, Space, D
KeyWait, Space
MouseGetPos, MOUSE_X, MOUSE_Y
Loop
{
	PixelSearch,,, MOUSE_X, MOUSE_Y, MOUSE_X, MOUSE_Y, 0xffffff, 254, Fast RGB
	if (ErrorLevel = 0)
	{
		SM_LEFT_SIDE := MOUSE_X - 1
		MouseMove, SM_LEFT_SIDE, MOUSE_Y
		break
	}
	else
	{
		MOUSE_X := MOUSE_X + 1
	}
}
KeyWait, Space, D
KeyWait, Space
MouseGetPos, MOUSE_X, MOUSE_Y
Loop
{
	PixelSearch,,, MOUSE_X, MOUSE_Y, MOUSE_X, MOUSE_Y, 0xffffff, 254, Fast RGB
	if (ErrorLevel = 0)
	{
		SM_RIGHT_SIDE = %MOUSE_X%
		MouseMove, SM_RIGHT_SIDE, MOUSE_Y
		break
	}
	else
	{
		MOUSE_X := MOUSE_X - 1
	}
}
RES_FACTOR := (SM_RIGHT_SIDE - SM_LEFT_SIDE) / 480
KeyWait, Space, D
KeyWait, Space
MouseGetPos, MOUSE_X, MOUSE_Y
Loop
{
	PixelSearch,,, MOUSE_X, MOUSE_Y, MOUSE_X, MOUSE_Y, 0xffffff, 254, Fast RGB
	if (ErrorLevel = 0)
	{
		SM_HOME_X = %MOUSE_X%
		MouseMove, SM_HOME_X, MOUSE_Y
		break
	}
	else
	{
		MOUSE_X := MOUSE_X + 1
	}
}
KeyWait, Space, D
KeyWait, Space
MouseGetPos, MOUSE_X, MOUSE_Y
Loop
{
	PixelSearch,,, MOUSE_X, MOUSE_Y, MOUSE_X, MOUSE_Y, 0xffffff, 254, Fast RGB
	if (ErrorLevel = 0)
	{
		SM_HOME_Y = %MOUSE_Y%
		MouseMove, MOUSE_X, SM_HOME_Y
		break
	}
	else
	{
		MOUSE_Y := MOUSE_Y + 1
	}
}
MsgBox, 4, DONE!, YOUR SETTINGS: %RES_FACTOR% %SM_HOME_X% %SM_HOME_Y%`nSAVE THEM?
IfMsgBox Yes
{
	IniWrite, %RES_FACTOR%, %A_ScriptDir%\SYSTEM\SETTINGS.ini, MASTER_SETTINGS, RES_FACTOR
	IniWrite, %SM_HOME_X%, %A_ScriptDir%\SYSTEM\SETTINGS.ini, MASTER_SETTINGS, HOME_X
	IniWrite, %SM_HOME_Y%, %A_ScriptDir%\SYSTEM\SETTINGS.ini, MASTER_SETTINGS, HOME_Y
}
return

LOAD_SETTINGS:
IniRead, CURRENT_SCRIPT, %A_ScriptDir%\SYSTEM\SETTINGS.ini, BASIC_SETTINGS, CURRENT_SCRIPT, %A_Space%
IniRead, 1_DELAY_MS, %A_ScriptDir%\SYSTEM\SETTINGS.ini, ADVANCED_SETTINGS, 1_DELAY_MS
IniRead, 2_DELAY_MS, %A_ScriptDir%\SYSTEM\SETTINGS.ini, ADVANCED_SETTINGS, 2_DELAY_MS
IniRead, 3_DELAY_MS, %A_ScriptDir%\SYSTEM\SETTINGS.ini, ADVANCED_SETTINGS, 3_DELAY_MS
IniRead, UI_STYLE, %A_ScriptDir%\SYSTEM\SETTINGS.ini, ADVANCED_SETTINGS, UI_STYLE, MIDNIGHT
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
return

SAVE_SETTINGS:
IniWrite, %CURRENT_SCRIPT%, %A_ScriptDir%\SYSTEM\SETTINGS.ini, BASIC_SETTINGS, CURRENT_SCRIPT
IniWrite, %1_DELAY_MS%, %A_ScriptDir%\SYSTEM\SETTINGS.ini, ADVANCED_SETTINGS, 1_DELAY_MS
IniWrite, %2_DELAY_MS%, %A_ScriptDir%\SYSTEM\SETTINGS.ini, ADVANCED_SETTINGS, 2_DELAY_MS
IniWrite, %3_DELAY_MS%, %A_ScriptDir%\SYSTEM\SETTINGS.ini, ADVANCED_SETTINGS, 3_DELAY_MS
IniWrite, %UI_STYLE%, %A_ScriptDir%\SYSTEM\SETTINGS.ini, ADVANCED_SETTINGS, UI_STYLE
return

GET_LIBRARY_CONTENTS:
CURRENT_SCRIPT_INDEX := 1
LIBRARY_CONTENTS := ""
Loop, %A_ScriptDir%\LIBRARY\*.ahk
{
	SplitPath, A_LoopFileLongPath,,,, OutNameNoExt
	LIBRARY_CONTENTS = %LIBRARY_CONTENTS%%OutNameNoExt%|
	if (CURRENT_SCRIPT = OutNameNoExt)
	{
		CURRENT_SCRIPT_INDEX = %A_Index%
	}
}
return

GET_UI_STYLES:
IniRead, UI_STYLES, %A_ScriptDir%\SYSTEM\UI_STYLES.ini
StringReplace, UI_STYLES, UI_STYLES, `n, |, All
UI_STYLE_INDEX := 1
Loop, Parse, UI_STYLES, |
{
	if (UI_STYLE = A_LoopField)
	{
		UI_STYLE_INDEX = %A_Index%
	}
}
return