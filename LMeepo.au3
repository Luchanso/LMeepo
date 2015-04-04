#include <DrawText.au3>
#include <WinAPI.au3>
#include <WindowsConstants.au3>
#include <GuiConstantsEx.au3>
#include <GDIPlus.au3>

Global $hwnd
Global $iCount = 5 ; Meepo counter
Global $iWidth = 50
Global $iHeight = 50
Global $iX = @DesktopWidth - $iHeight * 2
Global $iY = 50

Func Main()
   ; Ctrl + Shift + Q
   HotKeySet('^+{q}', Quit)

   ; Make TOPMOST Text
   $hwnd = GUICreate("Text region", $iWidth, $iHeight, $iX, $iY, $WS_POPUP, BitOR($WS_EX_TOPMOST, $WS_EX_TOOLWINDOW))
   GUISetBkColor(0x00FF00)

   Draw()
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