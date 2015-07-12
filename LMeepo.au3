#include <DrawText.au3>
#include <WinAPI.au3>
#include <WindowsConstants.au3>
#include <GuiConstantsEx.au3>
#include <GDIPlus.au3>

Global $hwnd
Global $hwndTimer
Global $hDC
Global $bIsPause = false
Global $bIsSleep = false
Global $iCount = 1 ; Meepo counter
Global $hTimer = TimerInit() ; Meepo puf timer
Global $iPufDelay = 1500
Global $saveCount = 1
Global $iWidth = 50
Global $iHeight = 50
Global $iX = @DesktopWidth - $iHeight
Global $iY = 50

Func Main()
   ; Ctrl + Shift + Q
   HotKeySet('^+{q}', Quit)
   HotKeySet('{d}', PufPuf)
   HotKeySet('{o}', DownMeepo)
   HotKeySet('{p}', UpMeepo)
   HotKeySet('{\}', SleepApp)
   HotKeySet('{ENTER}', RouteEnterPause)
   HotKeySet('+{ENTER}', RouteShiftEnterPause)

   $hwnd = GUICreate("Text region", $iWidth, $iHeight, $iX, $iY, $WS_POPUP, BitOR($WS_EX_TOPMOST, $WS_EX_TOOLWINDOW))
   GUISetBkColor(0x00FF00)
   GUISetState()

   $hwndTimer = GUICreate("Hell World", $iWidth, $iHeight, $iX - $iWidth * 2 - 15, $iY, $WS_POPUP, BitOR($WS_EX_TOPMOST, $WS_EX_TOOLWINDOW))
   GUISetBkColor(0xFF0000)
   GUISetState()

   Draw()
   DrawTimer()
EndFunc

Func SleepApp()
   If $bIsSleep Then
	  $iCount = $saveCount
	  HotKeySet('{d}', PufPuf)
	  HotKeySet('{o}', DownMeepo)
	  HotKeySet('{p}', UpMeepo)
	  HotKeySet('{ENTER}', RouteEnterPause)
	  HotKeySet('+{ENTER}', RouteShiftEnterPause)
   Else
	  $saveCount = $iCount
	  $iCount = "S"
	  Draw()
	  HotKeySet('{d}')
	  HotKeySet('{o}')
	  HotKeySet('{p}')
	  HotKeySet('{ENTER}')
	  HotKeySet('+{ENTER}')
   EndIf

   Draw()

   $bIsSleep = Not $bIsSleep
EndFunc

Func RouteEnterPause()
   HotKeySet('{ENTER}')
   Send("{ENTER}")

   Pause()

   HotKeySet('{ENTER}', RouteEnterPause)
EndFunc

Func RouteShiftEnterPause()
   HotKeySet('+{ENTER}')
   Send("+{ENTER}")

   Pause()

   HotKeySet('+{ENTER}', RouteShiftEnterPause)
EndFunc

Func Pause()
   if Not $bIsPause Then
	  HotKeySet('{d}')
	  HotKeySet('{o}')
	  HotKeySet('{p}')
   Else
	  Draw()
	  HotKeySet('{d}', PufPuf)
	  HotKeySet('{o}', DownMeepo)
	  HotKeySet('{p}', UpMeepo)
   EndIf

   $bIsPause = Not $bIsPause
EndFunc

;-)
Func PufPuf()
   $hTimer = TimerInit()
   For $fCounter = 0 To $iCount - 1
	  Sleep(60)
	  Send("{TAB}w")
   Next
   Send("{TAB}")
EndFunc

Func UpMeepo()
   if $iCount <= 7 Then ; (5 meepo max + 2 meepo from Manta Style = 7 Meepo max)
	  $iCount += 1
	  Draw()
   EndIf
EndFunc

Func DownMeepo()
   if $iCount > 1 Then
	  $iCount -= 1
	  Draw()
   EndIf
EndFunc

Func Quit()
   Exit
EndFunc

Func DrawSleep()
   $rgn = CreateTextRgn($hwnd, 'N', 50, "Arial")
   SetWindowRgn($hwnd, $rgn)
   GUISetState()
EndFunc

Func Draw()
   $rgn = CreateTextRgn($hwnd, $iCount, 50, "Arial")
   SetWindowRgn($hwnd, $rgn)
   GUISetState()
EndFunc

Func DrawTimer()
   $iDiff = $iPufDelay - TimerDiff($hTimer)
   if $iDiff > 0 Then
	  $rgn = CreateTextRgn($hwndTimer, $iDiff, 20, "Arial")
	  SetWindowRgn($hwndTimer, $rgn)
	  $aPos = MouseGetPos()
	  WinMove($hwndTimer, "", $aPos[0] + 25, $aPos[1] + 25)
   Else
	  $rgn = CreateTextRgn($hwndTimer, "0", 20, "Arial")
	  SetWindowRgn($hwndTimer, $rgn)
	  WinMove($hwndTimer, "", -25, -25)
   EndIf
EndFunc

Main()

While 1
   Sleep(2)
   DrawTimer()
WEnd