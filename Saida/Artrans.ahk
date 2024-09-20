#SingleInstance, force
#Include <FindText>
#Include <matFunctions>
SetTitleMatchMode, 2
Menu, Tray, Icon, Shell32.dll, 44       

Turbo:="|<Turbo>*120$27.y020100E0802012/SC8FG+92+FF8FG+92OFF8BHlo"
ProximaNFE:="|<ProximaNFE>*139$14.E0701w0Tk7z1zwTyLy1y0S060000008"
NFEAnterior:="|<NFEAnterior>*148$8.0kwzbkQ108"
cc:="|<c/c>*110$18.S2SV2VU2UU4UU4UU8UU8UVEVSESU"
delet:="|<delet>*149$20.yE02000U008LXW554VFF8IIG554VSC0400003zzz0000003zzzU008"
Cinco:="|<5352>*161$27.w3nno02E2U0G0LUAS240EEUU2284YEG74QQzU"
Seis:="|<6932>*159$28.C1ltt08UUc0W22w28k+87UV8U228mEM91l77Ds"
PR:="|<Paraná>*162$12.wwWWWWaWwwUYUWUXU"
CNPJ:="|<CNPJ>*110$34.S247k64AEEUM0l121U2Y4860+ET0M0Z101U2A40a48kE2LYV90aU"
SeisTres:="|<6352>*156$20.VkD8U0GE04bU6940GF04aG18sXW"
doc:="|<doc>*149$32.w003D1000m8E00AV40038G000m5000AVU0038jU00nm"

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

                    ;Procura 6352 ou 6932
                    
                    if (ok:=FindText(X, Y, 327-150000, 349-150000, 327+150000, 349+150000, 0, 0, PR)){
                        ;MsgBox, [ , OUUU, Eu, 2.5]
                        ClickOnImage(cc, 15, 18, "L", "C/C", X, Y) 
                        send,{BS}1
                        Sleep 10
                        ClickOnImage(CNPJ, 88, 16, "L", "CNPJ", X, Y)
                        Send,{Sleep 10}{BS 4}{sleep 10}1450
                        Sleep 15
                        Send, !g 
                        flag := 1
                        Sleep 40
                    }
                    else {
                        flag := 1
                        Sleep 40
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


