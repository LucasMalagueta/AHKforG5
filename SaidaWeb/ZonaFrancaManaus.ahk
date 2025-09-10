#SingleInstance, force
#Include <FindText>
#Include <matFunctions>
SetTitleMatchMode, 2

Menu, Tray, Icon, C:\Users\%A_Username%\Documents\AutoHotkey\Lib\pngwing.com.ico     

;Imagens de referencias para clicks
;Imagens SPED

CFOPs := "|<6109>*162$27.C0Flm0CHFU0G+DU2FFW0G9wE2F1mEGMPWDCCU|<6110>*179$27.C0EFm0CCPU0EGDk22FW0EGAE22FmEEHPWDjiU|<5901>*181$27.w3XUY0mqQU4IEbUWW443oEUU2W4YUqkbYQQTU"
Itens:="|<Itens>*127$22.U002E009000aQgOG/+NDcYYUW+G++Mb8aU"
Seta:="|<Seta>*200$7.476qC3"
CST:="|<CST>*182$19.SCDkcV840Y20G0s9024U12EcV7XUY"
PisCST:="|<PisCST>*175$23.0DYQ0Ed40VG012YD3t7042108420E940UFk0000000D77kVF210U4210841kE80EUE0V0VF20wQ42"
BCIsentas:="|<BCIsentas>*167$39.kw500018Ec002905000F818lmnl099FNF828Xu+90F2EFF8I9+++kwV6CFA"
IpiCST:="|<IPIC>*165$12.G5G5G5HtG1G1G1G10000000077cV8181710V0VcV71U"
BCIsentasPrimeiro:="|<BCISentasTOP>*161$29.k2400E480008E000UX70119F0428y08490EU9+/10FXY"
IsentoN:="|<Isento/N.>*167$33.0002V00E0K80202l6KNkZ8/+F4d7FG94c2+F8X1FG+4Mm9CEVA"
ProximaNota:="|<ProximaNota>*192$7.UM/5nxzzzjbXVUU|<ProximaNota>*186$7.UM+4mxzzzjbXVUU|<ProximaNota>*189$7.UM+5nxzzzjbXVUU|<ProximaNota>*177$7.UM+4mhTzzjbXVUU"
Abatimento:="|<Abatimento>*120$31.400U020200101000wQpqCF1GYd8bdGLYIId++++IZ5sweGQ"
MovFis:="|<MovFis>*137$25.00DW004200201410WW0wH+0E8Z084F042EW214|<>*137$34.U007l2000E8800100XYE42CFF0S994c10WYGU426F40E98sF10XU|<>*160$22.UU02200AM00lXYGeFF+d4cYYGWGF488sFU"

NumpadAdd::
    if (ok:=FindText(X, Y, 407-150000, 222-150000, 407+150000, 222+150000, 0, 0, CFOPs)) {
        ;Pega a quantidade de Itens
        if ClickOnImage(Itens, 0, 0, "L", "Itens", X, Y){
            Sleep 28
            ClickOnImage(Itens, 15, 18, "R", "Itens", X, Y)
            Sleep 28
            Send, {Down}{Sleep 10}{Down}{Sleep 10}{Down}{Sleep 10}{Enter}
            ItensO := Clipboard
            ItensV := RegExFindValue(ItensO, "([\d]+)\s")
            Sleep 30
            ;pegar Abatimento
            ClickOnImage(Abatimento, 0, 0, "L", "Abatimento", X, Y)
            Sleep 28
            ClickOnImage(Abatimento, 0, 16, "R", "Abatimento", X, Y)
            Sleep 28
            Send, {Down}{Sleep 10}{Down}{Sleep 10}{Down}{Sleep 10}{Enter}
            Sleep 28
            Abatimento := Clipboard

            ;Entrar nos itens
            ClickOnImage(Itens, 15, 18, "L", "Itens", X, Y)
            Sleep 10
            Send, ^{Enter}
            
            WinWait, Itens da NF

            if ExistActivate("Itens da NF"){
                Sleep 300

                ;Espera a setinha pra cima do scroll de itens aparecer e clica nela
                ClickOnImage(Seta, 0, 0, "L", "Seta", X, Y)
                Sleep 30
                Send, {Click 15}
                if (ItensO != Abatimento){
                    
                    ;Espera botao de impostos aparecer e clica nele
                    while(ItensV) {
                        
                        Sleep 160
                        Send, !i
                        Sleep 26
                        Send, ^{Enter}

                        WinWait, Impostos
                        ;Espera janela de impostos ativar
                        if ExistActivate("Impostos"){

                            Sleep 180
                            ;Copia o valor do BC / Isentas
                            ClickOnImage(BCIsentasPrimeiro, 0, 0, "L", "BCIsentasPrimeiro", X, Y)
                            ClickOnImage(BCIsentasPrimeiro, 0, 18, "R", "BCIsentasPrimeiro", X, Y)

                            Sleep 32
                            Send, {Down}{Sleep 10}{Down}{Sleep 10}{Down}{Sleep 10}{Enter}
                            Sleep 80
                            ;Clica no CST do IPI
                            ClickOnImage(IpiCST, 4, 24, "L", "SegundoIPI", X, Y)

                            Sleep 28
                            Send, {Tab 2}
                            Sleep 28
                            Send, %Clipboard%
                            ;Clica no CST do PIS
                            ClickOnImage(PisCST, 0, 26, "L", "CSTPis", X, Y)
                            Send, {Click}

                            ;Arruma a linha do PIS
                            Sleep 32
                            Send, 49
                            Sleep 32
                            ClickOnImage(PisCST, 99, 6, "L", "CSTPis", X, Y)
                            Send, {Sleep 8}{Bs}{Sleep 8}{Tab}{Sleep 8}{Bs}{Sleep 8}{Tab}{Sleep 8}{Bs}{Sleep 8}{Tab}{Sleep 8}{Bs}{Sleep 8}{Tab}{Sleep 8}{Bs}{Sleep 8}{Tab}{Sleep 8}
                            Send, {Sleep 8}{Tab}{Sleep 8}{Tab}
                            Sleep 32
                            ;Arruma a linha do Cofins
                            Send, 49
                            Sleep 32
                            ClickOnImage(PisCST, 99, 75, "L", "CSTPis", X, Y)
                            Send, {Sleep 8}{Bs}{Sleep 8}{Tab}{Sleep 8}{Bs}{Sleep 8}{Tab}{Sleep 8}{Bs}{Sleep 8}{Tab}{Sleep 8}{Bs}{Sleep 8}{Tab}{Sleep 8}{Bs}

                            Send, {Enter}
                            Sleep 28
                            ;Sai dos impostos e grava
                            Send, !o!o
                            Sleep 380
                            ClickOnImage(MovFis, -45, 34, "L", "MovFis", X, Y)
                            Click
                            Sleep 32
                            Send, %Clipboard%{Sleep 10}{Enter}
                            Sleep 50
                            Send, !g{Sleep 10}!g{Sleep 10}!g
                        
                            Sleep 40
                            Send, !s{Sleep 10}!s{Sleep 10}!s
                            Sleep 90

                            ItensV := ItensV - 1
                            
                            WinWait, Itens da NF

                            if ExistActivate("Itens da NF"){
                                Sleep 450

                                ;Espera a setinha pra cima do scroll de itens aparecer e clica nela
                                ClickOnImage(ProximaNota, 0, 0, "L", "ProximaNota", X, Y)
                            }
                        }
                    }
                }
                else{
                    ;Espera botao de impostos aparecer e clica nele
                    while(ItensV) {
                        
                        Sleep 160
                        Send, !i
                        Sleep 26
                        Send, ^{Enter}

                        WinWait, Impostos
                        ;Espera janela de impostos ativar
                        if ExistActivate("Impostos"){

                            ClickOnImage(PisCST, -3, 6, "L", "CSTPis", X, Y)
                            ;Arruma a linha do PIS
                            Sleep 32
                            Send, 49
                            ;Arruma a linha do PIS
                            Sleep 32
                            Send, 49
                            Sleep 32
                            ClickOnImage(PisCST, 99, 6, "L", "CSTPis", X, Y)
                            Send, {Sleep 8}{Bs}{Sleep 8}{Tab}{Sleep 8}{Bs}{Sleep 8}{Tab}{Sleep 8}{Bs}{Sleep 8}{Tab}{Sleep 8}{Bs}{Sleep 8}{Tab}{Sleep 8}{Bs}{Sleep 8}{Tab}{Sleep 8}
                            Send, {Sleep 8}{Tab}{Sleep 8}{Tab}
                            Sleep 32
                            ;Arruma a linha do Cofins
                            Send, 49
                            Sleep 32
                            ClickOnImage(PisCST, 99, 75, "L", "CSTPis", X, Y)
                            Send, {Sleep 8}{Bs}{Sleep 8}{Tab}{Sleep 8}{Bs}{Sleep 8}{Tab}{Sleep 8}{Bs}{Sleep 8}{Tab}{Sleep 8}{Bs}{Sleep 8}{Tab}{Sleep 8}{Bs}
    
                            Send, {Enter}
                            Sleep 32
                            ;Sai dos impostos e grava
                            Send, !o!o
                            Sleep 26
                            Send, !g{Sleep 10}!g{Sleep 10}!g
                        
                            Sleep 40
                            Send, !s{Sleep 10}!s{Sleep 10}!s
                            Sleep 90

                            ItensV := ItensV - 1
                            
                            WinWait, Itens da NF

                            if ExistActivate("Itens da NF"){
                                Sleep 450
                                ;Espera a setinha pra cima do scroll de itens aparecer e clica nela
                                ClickOnImage(ProximaNota, 0, 0, "L", "ProximaNota", X, Y)
                            }
                        }
                    }
                }
            }

            Winactivate, Itens da NF
            Winclose, Itens da NF
            WinWaitActive, Lançamentos Fiscais

            ; Send "!g"
            ; Sleep 26
            ; Send "!s"

            ; PgwFEl := UIA.ElementFromHandle("Lançamentos Fiscais")
            ; PgwFEl.ElementFromPath("0qr").Click()
                
            
        }
    }

    