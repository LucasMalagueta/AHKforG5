#SingleInstance, force
;#Include %A_ScriptDir%\Lib\UIA_Interface.ahk
#Include <FindText>
#Include <matFunctions>
SetTitleMatchMode, 2
Menu, Tray, Icon, C:\Users\%A_Username%\Documents\AutoHotkey\Lib\pngwing.com.ico

ProximaNFE:="|<ProximaNFE>*166$5.Vn80E"
NFEAnterior:="|<NFEAnterior>*148$8.0kwzbkQ108"
cc:="|<c/c>*120$20.0003kHl252E1E40Y1090E4E41412V2D8D0002"
gravar:="|<gravar>*117$54.0000000000Ds0000000pM0000003ek00000041k1s00007zk24000023k200000Dvk20nYHa8Dk2QUIEI8/k24XmXo/fk24YGYI8Dk2AYF4IDvs1oXl3o2vc00000023E7y00007yU0000007z0000000000000000U"
CincoUm:="|<5102>*162$27.w0XXo0Qa2U0YELU4W240YEUU4W84UYm74SQzU"
CincoQuatro:="|<5405>*159$26.w0nXs0RAW0BF8w6IHl1z44E1F14UIkS84su"
delet:="|<delet>*149$20.yE02000U008LXW554VFF8IIG554VSC0400003zzz0000003zzzU008"
Turbo:="|<Turbo>*120$27.y020100E0802012/SC8FG+92+FF8FG+92OFF8BHlo"


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
                sleep 50
                send,+{Tab 2}
                sleep 30
                send,SP
                ;Checar se a janela de notas esta ativa
                If WinActive("Lançamentos Fiscais") {
                    Sleep 80
                    ;Procura 5102
                    if (ok:=FindText(X, Y, 363-150000, 350-150000, 363+150000, 350+150000, 0, 0, CincoUm)) {
                        ;Clica no Turbo
                        if ClickOnImage(Turbo, 9, 16, "L", "Turbo", X, Y) {
                            Sleep 15
                            ;Coloca codigo do Turbo e confirma
                            Send,1{sleep 5}{Enter 6}{Sleep 10}
                            ;Apaga PIS e COFINS
                            Send,{BS}{Sleep 5}{Enter}{Sleep 5}{BS}{Sleep 5}{Enter}
                            ;Termina de confirmar a nota
                            Send,{Enter 6}{Sleep 5}
                            flag := 1                            
                        }
                    }

                    ;Procura 5403
                    if (ok:=FindText(X, Y, 364-150000, 350-150000, 364+150000, 350+150000, 0, 0, CincoQuatro)) {
                        ;Clica no Turbo
                        if ClickOnImage(Turbo, 9, 16, "L", "Turbo", X, Y) {
                            Sleep 15
                            ;Coloca codigo no Turbo e confirma
                            Send,113{sleep 5}{Enter 6}{Sleep 10}
                            ;Não apaga PIS e COFINS
                            Send,{Sleep 5}{Enter}{Sleep 5}{Sleep 5}{Enter}
                            ;Termina de confirmar a nota
                            Send,{Enter 6}{Sleep 5}
                            flag := 1                            
                        }
                    }
                    
                    ;Se achou 5102 ou 5405 entra no if
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
                        MsgBox, 48, Aviso, 5102 e 5405 não encontrados.,1
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

NumpadSub::
    ClickOnImage(ProximaNFE, 0, 0, "L", "Seta Direita", X, Y)
Return 