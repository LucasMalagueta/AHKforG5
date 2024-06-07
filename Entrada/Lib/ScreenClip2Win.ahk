/*
[module/script] ScreenClip2Win
Author:     Learning one
Thanks:     Tic, HotKeyIt

Creates always on top windows from screen clippings. Click in upper right corner to close win. Click and drag to move it.
Uses Gdip.ahk by Tic.


;=== Example script ===
^Lbutton::SCW2_ScreenClip2Win() ; click & drag to select area to clip

#IfWinActive, ScreenClippingWindow ahk_class AutoHotkeyGUI
^c::SCW2_Win2Clipboard()        ; copy selected win to clipboard
#IfWinActive

#Include Gdip.ahk       ; by Tic
#Include ScreenClip2Win.ahk     ; by Learning one



;=== Short documentation ===
SCW2_ScreenClip2Win()           ; creates always on top window from screen clipping. Click and drag to select area.
SCW2_DestroyAllClipWins()       ; destroys all screen clipping windows.
SCW2_Win2Clipboard()            ; copies window to clipboard. By default, removes borders. To keep borders, specify "SCW2_Win2Clipboard(1)"
SCW2_SetUp(Options="")          ; you can change some default options in Auto-execute part of script. Syntax: "<option>.<value>"
    StartAfter - module will start to consume GUIs for screen clipping windows after specified GUI number. Default: 80
    MaxGuis - maximum number of screen clipping windows. Default: 6
    GuiColor - Default: black. It's actually just 1 pixel thick border around screen clipping.
    AutoMonitorWM_LBUTTONDOWN - on/off automatic monitoring of WM_LBUTTONDOWN message. Default: 1 (on)
    SelColor - selection color. Default: Yellow
    SelTrans - selection transparency. Default: 80
    
    Example:    SCW2_SetUp("MaxGuis.30 StartAfter.50 SelColor.Red")
    

;=== Avoid OnMessage(0x201, "WM_LBUTTONDOWN") collision example===
Gui, Show, w200 h200
SCW2_SetUp("AutoMonitorWM_LBUTTONDOWN.0")   ; turn off auto monitoring WM_LBUTTONDOWN
OnMessage(0x201, "WM_LBUTTONDOWN")  ; manualy monitor WM_LBUTTONDOWN
Return

^Lbutton::SCW2_ScreenClip2Win() ; click & drag
Esc::ExitApp

#Include Gdip.ahk       ; by Tic
#Include ScreenClip2Win.ahk     ; by Learning one
WM_LBUTTONDOWN() {
    if SCW2_LBUTTONDOWN()   ; LBUTTONDOWN on module's screen clipping windows - isolate - it's module's buissines
    return
    else    ; LBUTTONDOWN on other windows created by script
    MsgBox,,, You clicked on script's window not created by this module,1
}
*/


;===Functions==========================================================================
SCW2_Version() {
    return 2.00
}

SCW2_DestroyAllClipWins() {
    MaxGuis := SCW2_Reg("MaxGuis"), StartAfter := SCW2_Reg("StartAfter")
    Loop, %MaxGuis%
    {
        StartAfter++
        Gui %StartAfter%: Destroy
    }
}

SCW2_SetUp(Options="") {
    if !(Options = "")
    {
        Loop, Parse, Options, %A_Space%
        {
            Field := A_LoopField
            DotPos := InStr(Field, ".")
            if (DotPos = 0) 
            Continue
            var := SubStr(Field, 1, DotPos-1)
            val := SubStr(Field, DotPos+1)
            if var in GuiColor,StartAfter,MaxGuis,AutoMonitorWM_LBUTTONDOWN,SelColor,SelTrans
            %var% := val
        }
    }
    SCW2_Default(GuiColor,"Black")
    SCW2_Default(StartAfter,80), SCW2_Default(MaxGuis,6)
    SCW2_Default(AutoMonitorWM_LBUTTONDOWN,1), SCW2_Default(SelColor,"Yellow"), SCW2_Default(SelTrans,80)
    
    SCW2_Reg("GuiColor", GuiColor)
    SCW2_Reg("MaxGuis", MaxGuis), SCW2_Reg("StartAfter", StartAfter), SCW2_Reg("SelColor", SelColor), SCW2_Reg("SelTrans",SelTrans)
    SCW2_Reg("WasSetUp", 1)
    if AutoMonitorWM_LBUTTONDOWN
    OnMessage(0x201, "SCW2_LBUTTONDOWN")
}

SCW2_ScreenClip2Win() {
    static c
    if !(SCW2_Reg("WasSetUp"))
    SCW2_SetUp()

    StartAfter := SCW2_Reg("StartAfter"), MaxGuis := SCW2_Reg("MaxGuis"), SelColor := SCW2_Reg("SelColor"), SelTrans := SCW2_Reg("SelTrans")
    c++
    if (c > MaxGuis)
    c := 1

    GuiNum := StartAfter + c
    Area := SCW2_SelectAreaMod("g" GuiNum " c" SelColor " t" SelTrans)
    StringSplit, v, Area, |
    if (v3 < 10 and v4 < 10)    ; too small area
    return
    
    pToken := Gdip_Startup()
    if pToken =
    {
        MsgBox, 64, GDI+ error, GDI+ failed to start. Please ensure you have GDI+ on your system.
        return
    }
    
    Sleep, 100
    pBitmap := Gdip_BitmapFromScreen(Area)
    SCW2_CreatePictureWin(GuiNum,pBitmap,v1,v2)
    Gdip_Shutdown("pToken")
}

SCW2_SelectAreaMod(Options="") {
    CoordMode, Mouse, Screen
    MouseGetPos, MX, MY
    loop, parse, Options, %A_Space%
    {
        Field := A_LoopField
        FirstChar := SubStr(Field,1,1)
        if FirstChar contains c,t,g,m
        {
            StringTrimLeft, Field, Field, 1
            %FirstChar% := Field
        }
    }
    c := (c = "") ? "Blue" : c, t := (t = "") ? "50" : t, g := (g = "") ? "99" : g
    Gui %g%: Destroy
    Gui %g%: +AlwaysOnTop -caption +Border +ToolWindow +LastFound
    WinSet, Transparent, %t%
    Gui %g%: Color, %c%
    Hotkey := RegExReplace(A_ThisHotkey,"^(\w* & |\W*)")
    While, (GetKeyState(Hotkey, "p"))
    {
        Sleep, 10
        MouseGetPos, MXend, MYend
        w := abs(MX - MXend), h := abs(MY - MYend)
        X := (MX < MXend) ? MX : MXend
        Y := (MY < MYend) ? MY : MYend
        Gui %g%: Show, x%X% y%Y% w%w% h%h% NA
    }
    Gui %g%: Destroy
    MouseGetPos, MXend, MYend
    If ( MX > MXend )
    temp := MX, MX := MXend, MXend := temp
    If ( MY > MYend )
    temp := MY, MY := MYend, MYend := temp
    Return MX "|" MY "|" w "|" h
}

SCW2_CreatePictureWin(GuiNum,pBitmap,x,y) {
    static CloseButton := 16
    GuiColor := SCW2_Reg("GuiColor")
    Gui %GuiNum%: -Border +LastFound +ToolWindow +AlwaysOnTop +OwnDialogs
    hwnd := WinExist()
    Gui %GuiNum%:Color, %GuiColor%
    Gdip_GetDimensions(pBitmap, Width, Height)
    Gui, %GuiNum%:Add, Picture, x1 y1 w%Width% h%Height% 0xE HwndScreenClippingHwnd
    hBitmap := Gdip_CreateHBITMAPFromBitmap(pBitmap), SetImage(ScreenClippingHwnd, hBitmap), DeleteObject(hBitmap), Gdip_DisposeImage(pBitmap)
    
    WinX := x-4, WinY := y-4
    WinW := Width+2, WinH := Height+2
    Gui %GuiNum%: Show, x%WinX% y%WinY% w%WinW% h%WinH% Na, ScreenClippingWindow
    
    SCW2_Reg("G" GuiNum "#HWND", hwnd)
    SCW2_Reg("G" GuiNum "#XClose", WinW+4-CloseButton)
    SCW2_Reg("G" GuiNum "#YClose", CloseButton+4)
    Return hwnd
}

SCW2_LBUTTONDOWN() {
    MouseGetPos,,, WinUMID
    WinGetTitle, Title, ahk_id %WinUMID%
    if Title = ScreenClippingWindow
    {
        PostMessage, 0xA1, 2,,, ahk_id %WinUMID%
        KeyWait, Lbutton
        CoordMode, mouse, Relative
        MouseGetPos, x,y
        XClose := SCW2_Reg("G" A_Gui "#XClose"), YClose := SCW2_Reg("G" A_Gui "#YClose")
        if (x > XClose and y < YClose)
        Gui %A_Gui%: Destroy
        return 1    ; confirm that click was on module's screen clipping windows 
    }
}

SCW2_Reg(variable, value="") {
    static
    if (value = "") {
        yaqxswcdevfr := kxucfp%variable%pqzmdk
        Return yaqxswcdevfr
    }
    Else
    kxucfp%variable%pqzmdk = %value%
}

SCW2_Default(ByRef Variable,DefaultValue) {
    if (Variable="")
    Variable := DefaultValue 
}

SCW2_Win2Clipboard(KeepBorders=0) {
    pToken := Gdip_Startup()

    ActiveWinID := WinExist("A")
    pBitmap := Gdip_BitmapFromHWND(ActiveWinID)
    if !KeepBorders
    {
        Gdip_GetDimensions(pBitmap, w, h)
        pBitmap2 := SCW2_CropImage(pBitmap, 4, 4, w-8, h-8)
        Gdip_SetBitmapToClipboard(pBitmap2)
        Gdip_DisposeImage(pBitmap), Gdip_DisposeImage(pBitmap2)
    }
    else
    Gdip_SetBitmapToClipboard(pBitmap), Gdip_DisposeImage(pBitmap)
    Gdip_Shutdown("pToken")
}

SCW2_CropImage(pBitmap, x, y, w, h) {
   pBitmap2 := Gdip_CreateBitmap(w, h), G2 := Gdip_GraphicsFromImage(pBitmap2)
   Gdip_DrawImage(G2, pBitmap, 0, 0, w, h, x, y, w, h)
   Gdip_DeleteGraphics(G2)
   return pBitmap2
}