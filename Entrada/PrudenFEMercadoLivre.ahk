﻿#SingleInstance, force
#Include <FindText>
#Include <matFunctions>
SetTitleMatchMode, 2

Menu, Tray, Icon, C:\Users\%A_Username%\Documents\AutoHotkey\Lib\pngwing.com.ico      

Turbo:="|<Turbo>*120$27.y020100E0802012/SC8FG+92+FF8FG+92OFF8BHlo"
ProximaNFE:="|<ProximaNFE>*166$5.Vn80E"
NFEAnterior:="|<NFEAnterior>*148$8.0kwzbkQ108"
cc:="|<c/c>*120$20.0003kHl252E1E40Y1090E4E41412V2D8D0002"
UmNoveQuatroNove:="|<1949>*127$26.83UXi14N4UF6F84GYG0wcwU1G180LkG1494WC2CU|<1949>*150$25.E71bM4FoI28e+14Z50SzSU111F1UVwXUHc"
Pis:="|<Pis>*120$17.yE1202404+MTZ8k92UF50dG1AY"
UmDoisZeroDois:="|<1202>*127$26.83XXi1554U1F180IEG0948U4F4824G21150WTCTU"
DoisNoveQuatroNove:="|<2949>*127$26.Q3UXcV4N48F6F24GYF0wcwU1G1E0LkM1497uC2CU"
DoisDoisZeroDois:="|<2202>*127$26.Q3XXcV55481F120IEF0948U4F4E24G81153uTCTU"

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
                    if (ok:=FindText(X, Y, 407-150000, 222-150000, 407+150000, 222+150000, 0, 0, UmNoveQuatroNove)) {
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

                    ;Procura 5405
                    if (ok:=FindText(X, Y, 407-150000, 222-150000, 407+150000, 222+150000, 0, 0, UmDoisZeroDois)) {
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

                    if (ok:=FindText(X, Y, 407-150000, 222-150000, 407+150000, 222+150000, 0, 0, DoisNoveQuatroNove)) {
                        ;Clica no Turbo
                        sleep 8
                        if ClickOnImage(Turbo, 9, 16, "L", "Turbo", X, Y) {
                            Sleep 10
                            ;Coloca codigo do Turbo e confirma
                            Send,3{sleep 5}{Enter 5}{sleep 5}{Enter 8}{Sleep 10}
                            ;Apaga PIS e COFINS
                            Send,{BS}{Sleep 5}{Enter}{Sleep 5}{BS}{Sleep 5}{Enter}
                            ;Termina de confirmar a nota
                            Send,{Sleep 2} !g
                            flag := 1                            
                        }
                    }


                    if (ok:=FindText(X, Y, 407-150000, 222-150000, 407+150000, 222+150000, 0, 0, DoisDoisZeroDois)) {
                        ;Clica no Turbo
                        sleep 8
                        if ClickOnImage(Turbo, 9, 16, "L", "Turbo", X, Y) {
                            Sleep 10
                            ;Coloca codigo no Turbo e confirma
                            Send,1{sleep 5}{Enter 5}{sleep 5}{Enter 8}{Sleep 10}
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



