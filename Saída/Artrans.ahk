#SingleInstance, force
#Include %A_ScriptDir%\Lib\FindText.ahk
#Include %A_ScriptDir%\Lib\matFunctions.ahk
SetTitleMatchMode, 2
Menu, Tray, Icon, Shell32.dll, 44       

Turbo:="|<Turbo>*120$27.y020100E0802012/SC8FG+92+FF8FG+92OFF8BHlo"
ProximaNFE:="|<ProximaNFE>*139$14.E0701w0Tk7z1zwTyLy1y0S060000008"
NFEAnterior:="|<NFEAnterior>*148$8.0kwzbkQ108"
cc:="|<c/c>*110$18.S2SV2VU2UU4UU4UU8UU8UVEVSESU"
delet:="|<delet>*149$20.yE02000U008LXW554VFF8IIG554VSC0400003zzz0000003zzzU008"
Cinco:="|<5352>*127$26.y3bnc151601E1w0LUMUN48811420EG8V551mCCTU"
Seis:="|<6932>*127$26.Q3XXcV5560F11U4EET0wM+8114W0EG8V551mCCTU"
PR:="|<Paraná>*127$13.yTEcMIA+7tx0VUEk8M4A"
CNPJ:="|<CNPJ>*110$34.S247k64AEEUM0l121U2Y4860+ET0M0Z101U2A40a48kE2LYV90aU"
SeisTres:="|<6352>*127$26.Q3bncV51601E1U0LUT0N4+8114W0EG8V551mCCTU"
doc:="|<doc>*145$33.Q0037YE00MW200348E00MV400349000MVE0034A000MWy0037Y"

NumpadAdd::
    InputBox, NumCasas, Repetição, Quantas vezes irá rodar?, , 300, 130
    IfEqual, ErrorLevel, 1, Return

    loop %NumCasas% {
        flag := 0

        ;Checar se a janela de notas esta ativa
        If WinActive("Lançamentos Fiscais") {
            ;Clicar no C/C e ajustar para 1
            if (ok:=FindText(X, Y, 572-150000, 549-150000, 572+150000, 549+150000, 0, 0, Turbo)) {
                ;Checar se a janela de notas esta ativa
                
                    
                If WinActive("Lançamentos Fiscais") {
                    Sleep 10
                    ;se a nota estiver cancelado, ele pula de nota
                    if (ok:=FindText(X, Y, 584-150000, 184-150000, 584+150000, 184+150000, 0, 0, doc) or ok:=FindText(X, Y, 363-150000, 350-150000, 363+150000, 350+150000, 0, 0, Cinco)){
                        flag := 1
                        Sleep 20
                    }  
                    else{

                        ;Procura 5405
                        if (ok:=FindText(X, Y, 364-150000, 350-150000, 364+150000, 350+150000, 0, 0, Seis)   or ok:=FindText(X, Y, 407-150000, 222-150000, 407+150000, 222+150000, 0, 0, SeisTres)) {
                            if (ok:=FindText(X, Y, 327-150000, 349-150000, 327+150000, 349+150000, 0, 0, PR)){
                                ClickOnImage(cc, 15, 18, "L", "C/C", X, Y) 
                                send,{BS}1
                                Sleep 10
                                ClickOnImage(CNPJ, 80, 16, "L", "CNPJ", X, Y)
                                Send,{BS 4}{sleep 5}1450
                                Sleep 15
                                Send, !g 
                                flag := 1
                                Sleep 40
                            }
                            else {
                                flag := 1
                                Sleep 40
                            }
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
                            Sleep 25
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


