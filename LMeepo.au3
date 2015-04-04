#include <DrawText.au3>
#include <WinAPI.au3>
#include <WindowsConstants.au3>
#include <GuiConstantsEx.au3>
#include <GDIPlus.au3>

Global $hwnd
Global $iCount = 0 ; Meepo counter

; Make TOPMOST Text
$hwnd = GUICreate("Text region", 500, 50, 500, 50, $WS_POPUP, BitOR($WS_EX_TOPMOST, $WS_EX_TOOLWINDOW))
GUISetBkColor(0xFF0000)

Func Draw()
EndFunc

While 1
   ; Loop
WEnd