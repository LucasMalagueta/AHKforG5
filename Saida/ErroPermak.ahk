#Requires AutoHotkey v2.0
#SingleInstance Force
#Include <UIA>
#Include <matFunctionsV2>
#Include <FindTextV2>
#Include <AccV2>
TraySetIcon("C:\Users\" A_Username "\Documents\AutoHotkey\Lib\pngwing.com.ico")

SetTitleMatchMode 2
;Imagens de referencias para clicks

X:=0
Y:=0

Turbo:="|<Turbo>*120$27.y020100E0802012/SC8FG+92+FF8FG+92OFF8BHlo"
ProximaNFE:="|<ProximaNFE>*130$13.U0Q0DU7w3zVzwzwzsDk7U301"


NumpadAdd:: {
    PgwFEl := UIA.ElementFromHandle("Lançamentos Fiscais | ahk_exe PgwF.exe")
    Sleep 100

    NumCasas := InputBox("Quanto irá rodar?", "Quantas vezes irá rodar?", "", "").value
    loop NumCasas{
        flag := 0
        
        If WinActive("Lançamentos Fiscais"){
            ;getch CFOP
           
            Get()
            ;Mercadoria
            if(GrupoDA()){
                
                ;Altera o valor no campo IPI
                PgwFEl.WaitElementFromPath("IY4/").ControlClick()
                Send "{Tab}"
                Sleep 380
                VLfor := Format("{:.2f}", VL)

                Send VLfor
                Send "Enter"

                ;Altera o valor no campo Prazo
                PgwFEl.WaitElementFromPath("IY4ws").ControlClick()
                Send "{Tab}"
                Sleep 380

                Send VLfor
                Send "Enter"

                Sleep 250

                ;Termina a correção
                PgwFEl.WaitElementFromPath("0").Click()
                flag := 1
            }
            else
                ;Substituição Tributária
                if(GrupoST()){
                    VLfor := Format("{:.2f}", VL)
                    Res := VLfor - ST
                    ;Altera o valor no campo IPI
                    PgwFEl.WaitElementFromPath("IY4/").ControlClick()
                    Send "{Tab}"
                    Sleep 380
                    Res := Format("{:.2f}", Res)
                    Send Res

                    ;Altera o valor no campo Prazo
                    PgwFEl.WaitElementFromPath("IY4ws").ControlClick()
                    Send "{Tab}"
                    Sleep 380
                    
                    Send VLfor
                    Send "Enter"

                    Sleep 250
                    ;Termina a correção
                    PgwFEl.WaitElementFromPath("0").Click()

                    flag := 1
                }
                Sleep 400
                if (flag == 1) {
                    val := 1 
                    while (val == 1) {
                        if (FindText(&X, &Y, 408-150000, 346-150000, 408+150000, 346+150000, 0, 0, Turbo)){
                            val := 0
                        }
                    }

                    Sleep 380   
                    if (ClickOnImage(ProximaNFE, 0, 0, "L", "ProximaNFE") and ActiveActivate("Lançamentos Fiscais")) {
                        
                        flag := 0
                        Sleep 150
                    }
                        
                } else {
                    ClickOnImage(ProximaNFE, 0, 0, "L", "ProximaNFE")
                }
                Sleep 200
        }
    }
}

Get(){
    PgwFEl := UIA.ElementFromHandle("Lançamentos Fiscais | ahk_exe PgwF.exe")

    CFOPO := (PgwFEl.WaitElementFromPath("IY4vt").Dump()) 
    global CFOPV := RegExFindValue(CFOPO, "Value:\s`"([^`"]*)")
    global CFOPV := StrReplace(CFOPV, ".", "")


    VLO := (PgwFEl.WaitElementFromPath("IY4qt").Dump())
    global VL := RegExFindValue(VLO, "Value:\s`"([^`"]*)")
    global VL := StrReplace(VL, ",", "")

    CMIPIO := (PgwFEl.WaitElementFromPath("IY4su").Dump())
    global CMIPI := RegExFindValue(CMIPIO, "Value:\s`"([^`"]*)")
    global CMIPI := StrReplace(CMIPI, ",", "")

    PZO := (PgwFEl.WaitElementFromPath("IY4rs").Dump())
    global PZ := RegExFindValue(PZO, "Value:\s`"([^`"]*)")
    global PZ := StrReplace(PZ, ",", "")

    if(GrupoST()){

        IPSTO := (PgwFEl.WaitElementFromPath("IY4vs").Dump())
        if (RegExMatch(IPSTO, "Value:\s`"([^`"]*)", &match)) {

            IPST := RegExFindValue(IPSTO, "Value:\s`"([^`"]*)")
            IPST := StrReplace(IPST, ",", "")
            global ST := IPST + 0
        }
        else{
            global ST := 0
        }
    }
    
}


GrupoST(){
    return CFOPV == 5401 or CFOPV == 5403 or CFOPV == 6401 or CFOPV == 6403 or CFOPV == 6404
}
GrupoDA(){
    return CFOPV == 5101 or CFOPV == 5102 or CFOPV == 6101 or CFOPV == 6102
}

