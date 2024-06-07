#include <AccV2>
#Requires AutoHotkey v2.0-a
#SingleInstance Force

; Acc List viewer to quickly see all acc data from a specified window

; Create the window:
myGui := Gui(,"Acc Viewer")
myGui.Opt("+Resize")
myGui.OnEvent("Size", Gui_Size)
myGui.OnEvent("Close", (*)=>(ExitApp))
ogButton_Selector := MyGui.addButton("xm y2 w60 vbtnSelector BackgroundTrans h24 w24 +0x4000", "+")
ogButton_Selector.SetFont("s20", "Times New Roman")
ogButton_Selector.statusbar := "Click and drag to select a specific control or window"

; Create the ListView with two columns, Name and Size:
ogEditSearch := myGui.AddText("ym x+10","Search:")
ogEditSearch := myGui.AddEdit("yp-2 x+10")
ogEditSearch.OnEvent("Change",(*)=>(LV_Update()))

LV := myGui.Add("ListView", "xm yp+24 r25 w800", ["Path","Name","RoleText","Role","x","y","w","h","Value", "StateText", "State", "Description", "KeyboardShortcut", "Help", "ChildId"])
LV.OnEvent("ContextMenu", LV_ContextMenu)
; Notify the script whenever the user double clicks a row:
LV.OnEvent("DoubleClick", LV_DoubleClick)

SB := MyGui.AddStatusBar(,)
LV_Update("A")
LV.ModifyCol  ; Auto-size each column to fit its contents.
LV.ModifyCol(2, "Integer")  ; For sorting purposes, indicate that column 2 is an integer.
OnMessage(WM_LBUTTONDOWN := 0x0201, CheckButtonClick)
MyGui.Show

LV_Update(WinTitle:=""){
    global Acc_Content
    
    LV.Delete()
    SearchText := ogEditSearch.text
    LV.Opt("-Redraw")
    SB.SetText("Reading acc data...")

    if (WinTitle != "") {
        Title := WinGetTitle(Wintitle)
        myGui.Title := "Acc Viewer - [" Title "]"
        oAcc := Acc.ObjectFromWindow(WinTitle)
        global Acc_Content := oAcc.DumpAll()
        myGui.WinTitle := Wintitle
    }

    SB.SetText("Generating list...")

    Counter := 0
    CounterTotal:=0

    Loop Parse, Acc_Content, "`n","`r"
        {
            ; 4,1: RoleText: pane Role: 16 [Location: {x:3840,y:0,w:3840,h:2100}] [Name: ] [Value: ] [StateText: normal]
            CounterTotal++
            Path := RegExReplace(A_LoopField,"^([\d,]*):.*","$1", &OutputVarCount )
            Path := OutputVarCount=0 ? "" : Path
            RoleText := RegExReplace(A_LoopField,".*\QRoleText: \E(.*)\Q Role: \E.*","$1")
            Role := RegExReplace(A_LoopField,".*\Q Role: \E(.*)\Q [Location: \E.*","$1")
            x := RegExReplace(A_LoopField,".*\Q [Location: {x:\E(.*)\Q,y:\E.*","$1")
            y := RegExReplace(A_LoopField,".*\Q,y:\E(.*)\Q,w:\E.*","$1")
            w := RegExReplace(A_LoopField,".*\Q,w:\E(.*)\Q,h:\E.*","$1")
            h := RegExReplace(A_LoopField,".*\Q,h:\E(.*)\Q}] \E.*","$1")
            name := RegExReplace(A_LoopField,".*\Q}] [Name:\E(.*?)\Q] [\E.*","$1", &OutputVarCount)
            name := OutputVarCount=0 ? "" : name
            value := RegExReplace(A_LoopField,".*\Q] [Value:\E(.*?)\Q] [\E.*","$1", &OutputVarCount)
            value := OutputVarCount=0 ? "" : value
            description := RegExReplace(A_LoopField,".*\Q] [Description: \E(.*?)\Q]\E.*","$1", &OutputVarCount)
            description := OutputVarCount=0 ? "" : description
            StateText := RegExReplace(A_LoopField,".*\Q] [StateText: \E(.*?)(\Q] [\E.*|\Q]\E)$","$1", &OutputVarCount)
            StateText := OutputVarCount=0 ? "" : StateText
            State := RegExReplace(A_LoopField,".*\Q] [State: \E(.*?)(\Q] [\E.*|\Q]\E)$","$1", &OutputVarCount)
            State := OutputVarCount=0 ? "" : State
            KeyboardShortcut := RegExReplace(A_LoopField,".*\Q] [KeyboardShortcut: \E(.*?)(\Q] [\E.*|\Q]\E)$","$1", &OutputVarCount)
            KeyboardShortcut := OutputVarCount=0 ? "" : KeyboardShortcut
            Help := RegExReplace(A_LoopField,".*\Q] [Help: \E(.*?)(\Q] [\E.*|\Q]\E)$","$1", &OutputVarCount)
            Help := OutputVarCount=0 ? "" : Help
            ChildId := RegExReplace(A_LoopField,".*\Q ChildId: \E(.*?)(\Q [\E.*|\Q\E)$","$1", &OutputVarCount)
            ChildId := OutputVarCount=0 ? "" : ChildId

            if (ogEditSearch.text != "" and !InStr(Path "." RoleText "." Role "." Name "." value "." Description "." StateText "." State "." KeyboardShortcut "." Help ,ogEditSearch.text )){
                continue
            }
            RowNumber := LV.Add(, Path, name, RoleText, Role, x, y, w, h,  value, StateText, State, Description, KeyboardShortcut, Help, ChildId)
            if (myGui.HasProp("ElID") and myGui.ElID = x "-" y "-" w "-" h "-" Role){
                LV.Modify(RowNumber, "Select Focus Vis")
            }
            Counter++
        }

    SB.SetText((Counter=Countertotal) ? "Found " Counter " elements." : "Filtered " Counter "/" CounterTotal)
    LV.Opt("+Redraw")
}

LV_DoubleClick(LV, RowNumber){
    RowText := LV.GetText(RowNumber)  ; Get the text from the row's first field.
    ; ToolTip("You double-clicked row number " RowNumber ". Text: '" RowText "'")
    ChildPath := LV.GetText(RowNumber)
    oAccp := Acc.ObjectFromPath(ChildPath, myGui.WinTitle)
    oAccp.Highlight(0)
}

Gui_Size(thisGui, MinMax, Width, Height) {
    if MinMax = -1	; The window has been minimized. No action needed.
        return
    DllCall("LockWindowUpdate", "Uint", thisGui.Hwnd)
    LV.GetPos(&cX, &cY, &cWidth, &cHeight)
    LV.Move(, , Width - cX - 10, Height -cY -26)
    DllCall("LockWindowUpdate", "Uint", 0)
}

LV_ContextMenu(LV, RowNumber, IsRightClick, X, Y){
    RowNumber := 0  ; This causes the first loop iteration to start the search at the top of the list.
    Counter:=0
    Loop{
        RowNumber := LV.GetNext(RowNumber)  ; Resume the search at the row after that found by the previous iteration.
        if not RowNumber
            break
        Counter++
    }
    if (Counter=1){
        path := LV.GetText(RowNumber)
        MyMenu := Menu()
        MyMenu.add "Copy Path", (*) =>(A_Clipboard :=path, Tooltip2("Copied [" A_Clipboard "]"))
        MyMenu.Show
    }

}

CheckButtonClick(wParam := 0, lParam := 0, msg := 0, hwnd := 0) {
    global MyGui
    MouseGetPos(, , , &OutputVarControlHwnd, 2)

    if (ogButton_Selector.hwnd = OutputVarControlHwnd) {
        ogButton_Selector.text := ""
        SetSystemCursor("Cross")
        CoordMode "Mouse", "Screen"
        While (GetKeyState("LButton")) {
            MouseGetPos(&MouseX, &MouseY, &MouseWinHwnd, &MouseControlHwnd, 2)
            Sleep(100)
            if ( MouseControlHwnd != "") {
                MouseGetPos(&MouseX, &MouseY, &MouseWinHwnd, &MouseControlHwnd, 2)
                oAccp := Acc.ObjectFromPoint(MouseX, MouseY)
                myGui.oAccp := oAccp
                myGui.ElID := oAccp.location.x "-" oAccp.location.y "-" oAccp.location.w "-" oAccp.location.h "-" oAccp.Role
                oAccp.Highlight(0)
            }
        }
 
        SetSystemCursor("Default")
        LV_Update("ahk_id" MouseWinHwnd)
        ogButton_Selector.text := "+"
    }
}

Tooltip2(Text := "", X := "", Y := "", WhichToolTip := "") {
    ToolTip(Text, X, Y, WhichToolTip)
    SetTimer () => ToolTip(), -3000
}

SetSystemCursor(Cursor := "", cx := 0, cy := 0) {

    if (Cursor = "Default") {
        return DllCall("SystemParametersInfo", "UInt", SPI_SETCURSORS := 0x57, "UInt", 0, "UInt", 0, "UInt", 0)
    }

    static SystemCursors := Map("APPSTARTING", 32650, "ARROW", 32512, "CROSS", 32515, "HAND", 32649, "HELP", 32651, "IBEAM", 32513, "NO", 32648,
        "SIZEALL", 32646, "SIZENESW", 32643, "SIZENS", 32645, "SIZENWSE", 32642, "SIZEWE", 32644, "UPARROW", 32516, "WAIT", 32514)

    if (Cursor = "") {
        AndMask := Buffer(128, 0xFF), XorMask := Buffer(128, 0)

        for CursorName, CursorID in SystemCursors {
            CursorHandle := DllCall("CreateCursor", "ptr", 0, "int", 0, "int", 0, "int", 32, "int", 32, "ptr", AndMask, "ptr", XorMask, "ptr")
            DllCall("SetSystemCursor", "ptr", CursorHandle, "int", CursorID)	; calls DestroyCursor
        }
        return
    }

    if (Cursor ~= "^(IDC_)?(?i:AppStarting|Arrow|Cross|Hand|Help|IBeam|No|SizeAll|SizeNESW|SizeNS|SizeNWSE|SizeWE|UpArrow|Wait)$") {
        Cursor := RegExReplace(Cursor, "^IDC_")

        if !(CursorShared := DllCall("LoadCursor", "ptr", 0, "ptr", SystemCursors[StrUpper(Cursor)], "ptr"))
            throw Error("Error: Invalid cursor name")

        for CursorName, CursorID in SystemCursors {
            CursorHandle := DllCall("CopyImage", "ptr", CursorShared, "uint", 2, "int", cx, "int", cy, "uint", 0, "ptr")
            DllCall("SetSystemCursor", "ptr", CursorHandle, "int", CursorID)	; calls DestroyCursor
        }
        return
    }

    if FileExist(Cursor) {
        SplitPath Cursor, , , &Ext := ""	; auto-detect type
        if !(uType := (Ext = "ani" || Ext = "cur") ? 2 : (Ext = "ico") ? 1 : 0)
            throw Error("Error: Invalid file type")

        if (Ext = "ani") {
            for CursorName, CursorID in SystemCursors {
                CursorHandle := DllCall("LoadImage", "ptr", 0, "str", Cursor, "uint", uType, "int", cx, "int", cy, "uint", 0x10, "ptr")
                DllCall("SetSystemCursor", "ptr", CursorHandle, "int", CursorID)	; calls DestroyCursor
            }
        } else {
            if !(CursorShared := DllCall("LoadImage", "ptr", 0, "str", Cursor, "uint", uType, "int", cx, "int", cy, "uint", 0x8010, "ptr"))
                throw Error("Error: Corrupted file")

            for CursorName, CursorID in SystemCursors {
                CursorHandle := DllCall("CopyImage", "ptr", CursorShared, "uint", 2, "int", 0, "int", 0, "uint", 0, "ptr")
                DllCall("SetSystemCursor", "ptr", CursorHandle, "int", CursorID)	; calls DestroyCursor
            }
        }
        return
    }

    throw Error("Error: Invalid file path or cursor name")
}