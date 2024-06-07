#SingleInstance, force
#Include %A_ScriptDir%\Lib\FindText.ahk
#Include %A_ScriptDir%\Lib\matFunctions.ahk
SetTitleMatchMode, 2
Menu, Tray, Icon, Shell32.dll, 44       

Turbo:="|<Turbo>*120$27.y020100E0802012/SC8FG+92+FF8FG+92OFF8BHlo"
ProximaNFE:="|<ProximaNFE>*166$5.Vn80E"
Avista:="|<Avista>*120$33.422U00UEE20+140E1E8YnCF14dE+854WDT0cWGA425+FUUEa9w"
cc:="|<c/c>*120$20.0003kHl252E1E40Y1090E4E41412V2D8D0002"

NumpadAdd::
    InputBox, NumCasas, Repetição, Quantas vezes irá rodar?, , 300, 130
    IfEqual, ErrorLevel, 1, Return

    loop %NumCasas% {
        flag := 0

        ;Checar se a janela de notas esta ativa
        If WinActive("Lançamentos Fiscais") {
            ;Clicar no C/C e ajustar para 1
            if ClickOnImage(cc, 15, 18, " ", "C/C", X, Y) {
                ;Checar se a janela de notas esta ativa
                If WinActive("Lançamentos Fiscais") {
                    Sleep 15

                    if (ok:=FindText(X, Y, 718-150000, 641-150000, 718+150000, 641+150000, 0, 0, Turbo)) {
                        sleep 10
                        if ClickOnImage(Avista, 9, 16, "L 2", "Avista", X, Y) {
                            Sleep 15
                            Send,{sleep 5}{BS}{Enter}{Sleep 5}{BS}{Enter 2}
                            ;Apaga PIS e COFINS
                            Send,{BS}{Sleep 5}{Enter}{Sleep 5}{BS}{Sleep 5}{Enter}
                            ;Termina de confirmar a nota
                            Send,{Enter 6}{Sleep 5}
                            flag := 1                            
                        }
                    }
                    
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
                        MsgBox, 48, Aviso, nenhum dos cfops encontrados.,1
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