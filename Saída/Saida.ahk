#SingleInstance, force
#Include %A_ScriptDir%\Lib\FindText.ahk
#Include %A_ScriptDir%\Lib\matFunctions.ahk
SetTitleMatchMode, 2
Menu, Tray, Icon, Shell32.dll, 44       

Turbo:="|<Turbo>*120$27.y020100E0802012/SC8FG+92+FF8FG+92OFF8BHlo"
ProximaNFE:="|<ProximaNFE>*166$5.Vn80E"
NFEAnterior:="|<NFEAnterior>*148$8.0kwzbkQ108"
cc:="|<c/c>*120$20.0003kHl252E1E40Y1090E4E41412V2D8D0002"
CincoUm:="|<5102>*162$27.w0XXo0Qa2U0YELU4W240YEUU4W84UYm74SQzU"
CincoQuatro:="|<5405>*159$26.w0nXs0RAW0BF8w6IHl1z44E1F14UIkS84su"
delet:="|<delet>*149$20.yE02000U008LXW554VFF8IIG554VSC0400003zzz0000003zzzU008"
CincoUmZeroSeis:="|<5106>*152$26.w0XVs0N4W02FEw0YLV0954E2FF4UYKS8Qsu"
SeisUm:="|<6102>*150$28.C0Flt038Uc04W2w0G8+818V8U4W8mEG91l3b7s"
SeisQuatro:="|<6404>*160$28.C0NkN03dXc0OWOw3+/+8DsjsU2W2mE+M9l0b0c"
SeisUmZero:="|<6108>*158$27.C0Flm0CHFU0G+DU2FCW0G+QE2FFmEGO/WDCCU"
SeisUmZeroSeis:="|<6106>*159$27.C0Fku0CH8U0G+7U2FSW0G+AE2FFmEGP/WDCCU"
CincoNove:="|<5949>*160$26.w3Unc14R60FBFw4KIF0xywE1114UkEy8s4u"
SeisNove:="|<6949>*168$27.C1kNm0N7NU29eDkFNFW1vxwE111mEM8PWC1CU"
CincoUmZeroUm:="|<5101>*161$26.w0XUc0tAu02F2w0YEV0948E2F24UYki8wsy"
SeisUmZeroUm:="|<6101>*157$27.C0FkG0CHCU0G8LU2F2W0G8IE2F2mEGMHWDCDU"
CincoNoveVinteNove:="|<5929>*157$26.w3Xnc14560F1Fw4EIF0w8wE1414Um0y8tyu"
CincoNoveZeroDois:="|<5902>*159$27.w3XXo0Wa2U4IELUWW243oEUU2W84Uom74QQzU"
CincoUmDoisQuatro:="|<5124>*148$27.w0Xko0A2CU0UFLU42G40UbsU4824UW0L4CT2U"
CincoDois:="|<5202>*161$27.w3nXo02a2U0IELU2W240YEUU8W84W4m74zQzU"
Pis:="|<Pis>*144$18.yE1V01V01VH2yIWUG4UF4UIcUH8U"
NumpadAdd::
    InputBox, NumCasas, Repetição, Quantas vezes irá rodar?, , 300, 130
    IfEqual, ErrorLevel, 1, Return

    loop %NumCasas% {
        flag := 0

        ;Checar se a janela de notas esta ativa
        If WinActive("Lançamentos Fiscais") {
            ;Clicar no C/C e ajustar para 1
            if ClickOnImage(cc, 15, 18, "L", "C/C", X, Y) {
                send,{BS}1
                ;Checar se a janela de notas esta ativa
                If WinActive("Lançamentos Fiscais") {
                    Sleep 5

                    ;Procura 5102
                    if (ok:=FindText(X, Y, 363-150000, 350-150000, 363+150000, 350+150000, 0, 0, CincoUm)) {
                        ;Clica no Turbo
                        sleep 8
                        if ClickOnImage(Turbo, 9, 16, "L", "Turbo", X, Y) {
                            Sleep 10
                            ;Coloca codigo do Turbo e confirma
                            Send,1{sleep 5}{Enter 6}{Sleep 10}
                            ;Apaga PIS e COFINS
                            Send,{BS}{Sleep 5}{Enter}{Sleep 5}{BS}{Sleep 5}{Enter}
                            ;Termina de confirmar a nota
                            Send,{Sleep 2} !g
                            flag := 1                            
                        }
                    }

                    ;Procura 5405
                    else if (ok:=FindText(X, Y, 364-150000, 350-150000, 364+150000, 350+150000, 0, 0, CincoQuatro)) {
                        ;Clica no Turbo
                        sleep 8
                        if ClickOnImage(Turbo, 9, 16, "L", "Turbo", X, Y) {
                            Sleep 10
                            ;Coloca codigo no Turbo e confirma
                            Send,113{sleep 5}{Enter 6}{Sleep 10}
                            ;Apaga PIS e COFINS
                            Send,{BS}{Sleep 5}{Enter}{Sleep 5}{BS}{Sleep 5}{Enter}
                            ;Termina de confirmar a nota
                            Send,{Sleep 2} !g
                            flag := 1                            
                        }
                    }

                    else if (ok:=FindText(X, Y, 364-150000, 350-150000, 364+150000, 350+150000, 0, 0, SeisUmZeroUm)) {
                        ;Clica no Turbo
                        sleep 8
                        if ClickOnImage(Turbo, 9, 16, "L", "Turbo", X, Y) {
                            Sleep 10
                            ;Coloca codigo no Turbo e confirma
                            Send,1{sleep 5}{Enter 6}{Sleep 10}
                            ;Apaga PIS e COFINS
                            Send,{BS}{Sleep 5}{Enter}{Sleep 5}{BS}{Sleep 5}{Enter}
                            ;Termina de confirmar a nota
                            Send,{Sleep 2} !g
                            flag := 1                            
                        }
                    }


                    else if (ok:=FindText(X, Y, 364-150000, 350-150000, 364+150000, 350+150000, 0, 0, CincoUmZeroUm)) {
                        ;Clica no Turbo
                        sleep 8
                        if ClickOnImage(Turbo, 9, 16, "L", "Turbo", X, Y) {
                            Sleep 10
                            ;Coloca codigo no Turbo e confirma
                            Send,1{sleep 5}{Enter 6}{Sleep 10}
                            ;Apaga PIS e COFINS
                            Send,{BS}{Sleep 5}{Enter}{Sleep 5}{BS}{Sleep 5}{Enter}
                            ;Termina de confirmar a nota
                            Send,{Sleep 2} !g
                            flag := 1                            
                        }
                    }

                    ;Procura 6102
                    else if (ok:=FindText(X, Y, 364-150000, 350-150000, 364+150000, 350+150000, 0, 0, SeisUm)) {
                        ;Clica no Turbo
                        sleep 8
                        if ClickOnImage(Turbo, 9, 16, "L", "Turbo", X, Y) {
                            Sleep 10
                            ;Coloca codigo no Turbo e confirma
                            Send,1{sleep 5}{Enter 6}{Sleep 10}
                            ;Apaga PIS e COFINS
                            Send,{BS}{Sleep 5}{Enter}{Sleep 5}{BS}{Sleep 5}{Enter}
                            ;Termina de confirmar a nota
                            Send,{Sleep 2} !g
                            flag := 1                            
                        }
                    }

                    ;Procura 6404
                    else if (ok:=FindText(X, Y, 364-150000, 350-150000, 364+150000, 350+150000, 0, 0, SeisQuatro)) {
                        ;Clica no Turbo
                        sleep 8
                        if ClickOnImage(Turbo, 9, 16, "L", "Turbo", X, Y) {
                            Sleep 10
                            ;Coloca codigo no Turbo e confirma
                            Send,113{sleep 5}{Enter 6}{Sleep 10}
                            ;Apaga PIS e COFINS
                            Send,{BS}{Sleep 5}{Enter}{Sleep 5}{BS}{Sleep 5}{Enter}
                            ;Termina de confirmar a nota
                            Send,{Sleep 2} !g
                            flag := 1                            
                        }
                    }

                    ;Procura 6108
                    else if (ok:=FindText(X, Y, 407-150000, 222-150000, 407+150000, 222+150000, 0, 0, SeisUmZero)) {
                        ;Clica no Turbo
                        sleep 8
                        if ClickOnImage(Turbo, 9, 16, "L", "Turbo", X, Y) {
                            Sleep 10
                            ;Coloca codigo do Turbo e confirma
                            Send,1{sleep 5}{Enter 6}{Sleep 10}
                            ;Apaga o C/C
                            ClickOnImage(cc, 15, 18, "L", "C/C", X, Y)
                            Send, {BS}
                            ;Apaga PIS e COFINS
                            ClickOnImage(Pis, 0, 0,  "L", "Pis", X, Y)
                            Sleep 20
                            Send,{BS}{Sleep 5}{Enter}{Sleep 5}{BS}{Sleep 5}{Enter}
                            ;Termina de confirmar a nota
                            Send,{Sleep 2} !g
                            flag := 1                            
                        }
                    }

                    

                    ;Procura 5106
                    else if (ok:=FindText(X, Y, 407-150000, 222-150000, 407+150000, 222+150000, 0, 0, CincoUmZeroSeis)) {
                        ;Clica no Turbo
                        sleep 8
                        if ClickOnImage(Turbo, 9, 16, "L", "Turbo", X, Y) {
                            Sleep 10
                            ;Coloca codigo do Turbo e confirma
                            Send,1{sleep 5}{Enter 6}{Sleep 10}
                            ;Apaga o C/C
                            ClickOnImage(cc, 15, 18, "L", "C/C", X, Y)
                            Send, {BS}
                            ;Apaga PIS e COFINS
                            ClickOnImage(Pis, 0, 0,  "L", "Pis", X, Y)
                            Sleep 20
                            Send,{BS}{Sleep 5}{Enter}{Sleep 5}{BS}{Sleep 5}{Enter}
                            ;Termina de confirmar a nota
                            Send,{Sleep 2} !g
                            flag := 1                            
                        }
                    }

                    ;Procura 5949
                    else if (ok:=FindText(X, Y, 407-150000, 222-150000, 407+150000, 222+150000, 0, 0,CincoNove)) {
                        ;Clica no Turbo
                        sleep 8
                        if ClickOnImage(Turbo, 9, 16, "L", "Turbo", X, Y) {
                            Sleep 10
                            ;Coloca codigo do Turbo e confirma
                            Send,3{sleep 5}{Enter 6}{Sleep 10}
                            ;Apaga PIS e COFINS
                            Send,{BS}{Sleep 5}{Enter}{Sleep 5}{BS}{Sleep 5}{Enter}
                            ;Termina de confirmar a nota
                            Send,{Sleep 2} !g
                            flag := 1                            
                        }
                    }

                    ;Procura 5929
                    else if (ok:=FindText(X, Y, 407-150000, 222-150000, 407+150000, 222+150000, 0, 0,CincoNoveVinteNove)) {
                        ;Clica no Turbo
                        sleep 8
                        if ClickOnImage(cc, 9, 16, "L", "C/C", X, Y)
                            Send, {BS}{Sleep 5}{BS}
                        if ClickOnImage(Turbo, 9, 16, "L", "Turbo", X, Y) {
                            Sleep 10
                            ;Coloca codigo do Turbo e confirma
                            Send,3{sleep 5}{Enter 6}{Sleep 10}
                            ;Apaga PIS e COFINS
                            Send,{BS}{Sleep 5}{Enter}{Sleep 5}{BS}{Sleep 5}{Enter}
                            Send,{Sleep 2} !g
                            flag := 1                            
                        }
                    }

                    ;Procura 6949
                    else if (ok:=FindText(X, Y, 407-150000, 222-150000, 407+150000, 222+150000, 0, 0,SeisNove)) {
                        ;Clica no Turbo
                        sleep 8
                        if ClickOnImage(Turbo, 9, 16, "L", "Turbo", X, Y) {
                            Sleep 10
                            ;Coloca codigo do Turbo e confirma
                            Send,3{sleep 5}{Enter 6}{Sleep 10}
                            ;Apaga PIS e COFINS
                            Send,{BS}{Sleep 5}{Enter}{Sleep 5}{BS}{Sleep 5}{Enter}
                            ;Termina de confirmar a nota
                            Send,{Sleep 2} !g
                            flag := 1                            
                        }
                    }
                    
                    ;Procura 6106
                    else if (ok:=FindText(X, Y, 407-150000, 222-150000, 407+150000, 222+150000, 0, 0, SeisUmZeroSeis)) {
                        ;Clica no Turbo
                        sleep 8
                        if ClickOnImage(Turbo, 9, 16, "L", "Turbo", X, Y) {
                            Sleep 10
                            ;Coloca codigo do Turbo e confirma
                            Send,1{sleep 5}{Enter 6}{Sleep 10}
                            ;Apaga o C/C
                            ClickOnImage(cc, 15, 18, "L", "C/C", X, Y)
                            Send, {BS}
                            ;Apaga PIS e COFINS
                            ClickOnImage(Pis, 0, 0,  "L", "Pis", X, Y)
                            Sleep 20
                            Send,{BS}{Sleep 5}{Enter}{Sleep 5}{BS}{Sleep 5}{Enter}
                            ;Termina de confirmar a nota
                            Send,{Sleep 2} !g
                            flag := 1                            
                        }
                    }

                    ;Proocura 5902
                    else if (ok:=FindText(X, Y, 407-150000, 222-150000, 407+150000, 222+150000, 0, 0,CincoNoveZeroDois)) {
                        ;Clica no Turbo
                        sleep 8
                        if ClickOnImage(Turbo, 9, 16, "L", "Turbo", X, Y) {
                            Sleep 10
                            ;Coloca codigo do Turbo e confirma
                            Send,3{sleep 5}{Enter 6}{Sleep 10}
                            ;Apaga PIS e COFINS
                            Send,{BS}{Sleep 5}{Enter}{Sleep 5}{BS}{Sleep 5}{Enter}
                            ;Termina de confirmar a nota
                            Send,{Sleep 2} !g
                            flag := 1                            
                        }
                    }

                    ;Proocura 5124
                    else if (ok:=FindText(X, Y, 407-150000, 222-150000, 407+150000, 222+150000, 0, 0,CincoUmDoisQuatro)) {
                        ;Clica no Turbo
                        sleep 8
                        if ClickOnImage(Turbo, 9, 16, "L", "Turbo", X, Y) {
                            Sleep 10
                            ;Coloca codigo do Turbo e confirma
                            Send,1{sleep 5}{Enter 6}{Sleep 10}
                            ;Apaga PIS e COFINS
                            Send,{BS}{Sleep 5}{Enter}{Sleep 5}{BS}{Sleep 5}{Enter}
                            ;Termina de confirmar a nota
                            Send,{Enter 6}{Sleep 5}
                            flag := 1                            
                        }
                    }

                    ;Procura 5202
                    else if (ok:=FindText(X, Y, 363-150000, 350-150000, 363+150000, 350+150000, 0, 0, CincoDois)) {
                        ;Clica no Turbo
                        sleep 8
                        if ClickOnImage(Turbo, 9, 16, "L", "Turbo", X, Y) {
                            Sleep 10
                            ;Coloca codigo do Turbo e confirma
                            Send,1{sleep 5}{Enter 6}{Sleep 10}
                            ;Apaga PIS e COFINS
                            Send,{BS}{Sleep 5}{Enter}{Sleep 5}{BS}{Sleep 5}{Enter}
                            ;Termina de confirmar a nota
                            Send,{Sleep 2} !g
                            flag := 1                            
                        }
                    }

                    ;Se achou qualquer cfop entra no if
                    if (flag == 1) {
                        ;Loop para esperar a nota carregar
                        val := 1 
                        while (val == 1) {
                            If (ok := FindText(X, Y, 572-150000, 549-150000, 572+150000, 549+150000, 0, 0, Turbo)) {
                                val := 0
                            }
                        }

                        ;Ir para a proxima nota
                        if (ClickOnImage(ProximaNFE, 0, 0, "L", "Seta Direita", X, Y) and ActiveActivate("Lançamentos Fiscais")) {
                            flag := 0
                        }
                        
                    } else {
                        MsgBox, 48, Aviso, nenhum dos CFOPs encontrados.,1
                        Return
                    }
                } else {
                    Return
                }
            }
        } else {
            Return
        }
    }
Return

