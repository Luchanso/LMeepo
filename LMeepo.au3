#include <DrawText.au3>
#include <WinAPI.au3>
#include <WindowsConstants.au3>
#include <GuiConstantsEx.au3>
#include <GDIPlus.au3>

Global $hwnd
Global $bIsPause = false
Global $bIsSleep = false
Global $iCount = 4 ; Meepo counter
Global $iWidth = 50
Global $iHeight = 50
Global $iX = @DesktopWidth - $iHeight
Global $iY = 50

Func Main()
   ; Ctrl + Shift + Q
   HotKeySet('^+{q}', Quit)
   HotKeySet('{d}', PufPuf)
   HotKeySet('{f}', SmartPuf)
   HotKeySet('{o}', DownMeepo)
   HotKeySet('{p}', UpMeepo)
   HotKeySet('{\}', SleepApp)
   HotKeySet('{ENTER}', RouteEnterPause)
   HotKeySet('+{ENTER}', RouteShiftEnterPause)

   ; Make TOPMOST Text
   $hwnd = GUICreate("Text region", $iWidth, $iHeight, $iX, $iY, $WS_POPUP, BitOR($WS_EX_TOPMOST, $WS_EX_TOOLWINDOW))
   GUISetBkColor(0x00FF00)

   Draw()
EndFunc

Func getMeepoCount()
   Dim $aAdresses[3] = [0xA95D288]
   Dim $Buffer[UBound($aAdresses)-1]
   For $i = 0 To UBound($aAdresses) - 1
	   $Buffer[$i] = DllStructCreate("dword a;dword b")
	   _WinAPI_ReadProcessMemory($hProcess, $aAdresses[$i], DllStructGetPtr($Buffer[$i]), DllStructGetSize($Buffer[$i]), $read)
	   ConsoleWrite($Buffer[$i])
   Next
EndFunc

Func SleepApp()
   If $bIsSleep Then
	  $iCount = 3
	  HotKeySet('^+{q}', Quit)
	  HotKeySet('{d}', PufPuf)
	  HotKeySet('{f}', SmartPuf)
	  HotKeySet('{o}', DownMeepo)
	  HotKeySet('{p}', UpMeepo)
	  HotKeySet('{ENTER}', RouteEnterPause)
	  HotKeySet('+{ENTER}', RouteShiftEnterPause)
   Else
	  $iCount = "S"
	  Draw()
	  HotKeySet('^+{q}')
	  HotKeySet('{d}')
	  HotKeySet('{f}')
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
	  HotKeySet('{f}')
	  HotKeySet('{o}')
	  HotKeySet('{p}')
   Else
	  Draw()
	  HotKeySet('{d}', PufPuf)
	  HotKeySet('{f}', SmartPuf)
	  HotKeySet('{o}', DownMeepo)
	  HotKeySet('{p}', UpMeepo)
   EndIf

   $bIsPause = Not $bIsPause
EndFunc

;-)
Func PufPuf()
   For $fCounter = 0 To $iCount - 1
	  Sleep(60)
	  Send("{TAB}w")
   Next
   Send("{TAB}")
EndFunc

Func SmartPuf()
   For $fCounter = 0 To $iCount - 1
	  Sleep(60)
	  Send("{TAB}w")
   Next
   Send("{TAB}")
   Sleep(800)
   Send("{SPACE}")
   Sleep(100)
   Send("q")
   Sleep(50)
   Send("w")
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

Main()

While 1
   Sleep(1)
WEnd
