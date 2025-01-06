#SingleInstance, force
#Include <FindText>
#Include <matFunctions>
SetTitleMatchMode, 2
Menu, Tray, Icon, C:\Users\%A_Username%\Documents\AutoHotkey\Lib\pngwing.com.ico

Turbo:="|<Turbo>*120$27.y020100E0802012/SC8FG+92+FF8FG+92OFF8BHlo"
ProximaNFE:="|<ProximaNFE>*130$13.U0Q0DU7w3zVzwzwzsDk7U301"
CC:="|<cc>*120$18.S2SV2VU2UU4UU4UU8UU8UVEVSESU|<>*143$18.S2SV2VU2UU4UU4UU8UU8UVEVSESU"
Aprazo:="|<Aprazo>*120$24.422U4220+140+14aF14dF0cYT0cWUUEdUUEaU"
CincoNove:="|<5929>*127$27.y1llo0FFFU28+DUF2F21sVsE181WEG0HWATAU|<59292>*154$26.w3Xnc14560F1Fw4EIF0w8wE1414Um0y8syu"
SeisNove:="|<6929>*127$27.A1llm0FFFU28+DUF2FW1sVwE181WEG0HWATAU|<69292>*157$27.C1ltm0F1FU28+DUF1FW1sFwE141mEN0PWCTiU"

delete(numcasos) {
    loop %numcasos% {
        Send,{bs}{enter}
    }
}


NumpadAdd::
    InputBox, NumCasas, Repetição, Quantas vezes irá rodar?, , 300, 130
    IfEqual, ErrorLevel, 1, Return

    loop %NumCasas% {
        If WinActive("Lançamentos Fiscais") {
            Sleep 100
            if ClickOnImage(CC, 15, 18, "L", "C/C", X, Y) {
                send,{BS}   
                if (ok:=FindText(X, Y, 429-150000, 202-150000, 429+150000, 202+150000, 0, 0, CincoNove)) {
                    if(ClickOnImage(Turbo, 9, 16, "L", "Turbo", X, Y))
                    {
                        Send,{Sleep 20}{Enter 8}
                        delete(6)
                        if(ClickOnImage(Turbo, 9, 16, "L", "Turbo", X, Y)){
                            Send,3{sleep 5}{Enter 6}
                            send,{Sleep 10}{BS}{Sleep 5}{Enter}{Sleep 5}{BS}{Sleep 5}!g{Sleep 100}
                            flag := 1
                        }
                    }
                    
                }

                else if (ok:=FindText(X, Y, 572-150000, 572-150000, 572+150000, 572+150000, 0, 0, SeisNove)) {
                    if(ClickOnImage(Turbo, 9, 16, "L", "Turbo", X, Y))
                    {
                        Send,{Sleep 20}{Enter 8}
                        delete(6)
                        if(ClickOnImage(Turbo, 9, 16, "L", "Turbo", X, Y)){
                            Send,3{sleep 5}{Enter 6}
                            send,{Sleep 10}{BS}{Sleep 5}{Enter}{Sleep 5}{BS}{Sleep 5}!g{Sleep 100}
                            flag := 1
                        }
                    }
                    
                }

                Sleep 70
                
                if (flag == 1) {

                    val := 1 
                    while (val == 1) {
                        if (ok:=FindText(X, Y, 406-150000, 203-150000, 406+150000, 203+150000, 0, 0, Turbo)){

                            val := 0
                        }
                    } 
                    Sleep 100   
                    if (ClickOnImage(ProximaNFE, 0, 0, "L", "Seta Direita", X, Y) and ActiveActivate("Lançamentos Fiscais")) {
                        
                        flag := 0
                        Sleep 120
                    }
                        
                } else {
                    MsgBox, 48, Aviso, 5.929 ou 6.929 não encontrado.,1
                    Return
                }    
            }
        }else{
            Return
        }
    }        
Return
