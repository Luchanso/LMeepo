#include <DrawText.au3>
#include <WinAPI.au3>
#include <WindowsConstants.au3>
#include <GuiConstantsEx.au3>
#include <GDIPlus.au3>

Global $hwnd
Global $bIsPause = false
Global $iCount = 4 ; Meepo counter
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
   HotKeySet('{ENTER}', RouteEnterPause)
   HotKeySet('+{ENTER}', RouteShiftEnterPause)

   ; Make TOPMOST Text
   $hwnd = GUICreate("Text region", $iWidth, $iHeight, $iX, $iY, $WS_POPUP, BitOR($WS_EX_TOPMOST, $WS_EX_TOOLWINDOW))
   GUISetBkColor(0x00FF00)

   Draw()
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

   HotKeySet('+{ENTER}', RouteEnterPause)
EndFunc

Func Pause()
   if Not $bIsPause Then
	  HotKeySet('{d}')
	  HotKeySet('{o}')
	  HotKeySet('{p}')
   Else
	  HotKeySet('{d}', PufPuf)
	  HotKeySet('{o}', DownMeepo)
	  HotKeySet('{p}', UpMeepo)
   EndIf

   $bIsPause = Not $bIsPause
EndFunc

;-)
Func PufPuf()
   For $fCounter = 0 To $iCount - 1
	  Sleep(10)
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

Func Draw()
   $rgn = CreateTextRgn($hwnd, $iCount, 50, "Arial")
   SetWindowRgn($hwnd, $rgn)
   GUISetState()
EndFunc

Main()

While 1
   ; Loop
WEnd