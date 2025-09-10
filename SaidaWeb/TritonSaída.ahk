#SingleInstance, force
#Include <FindText>
#Include <matFunctions>
SetTitleMatchMode, 2

Menu, Tray, Icon, C:\Users\%A_Username%\Documents\AutoHotkey\Lib\pngwing.com.ico     

;Imagens de referencias para clicks
;Imagens SPED

CFOPs := "|<5901>*178$27.w3XUY0mqQU4IEbUWW443oEUU2W4YUqkbYQQTU|<5908>*170$26.w3XXc1Zh60FFFw4IHV0x5gE1FFYUqqT8ssu|<5912>*178$27.w3UXo0mQGU4EULUW4243kUUU248YUkW7YQTzU|<5902>*177$27.w3XXo0mqGU4IELUWW243oEUU2W8YUqm7YQQzU|<5903>*177$27.w3XXo0mqGU4IELUWWA43oEEU2W3YUqoLYQQSU|<6916>*175$27.C1kEu0NC8U28G7kF2TW1sGAE12FmEMH/WCDiU"
Itens:="|<Itens>*127$22.U002E009000aQgOG/+NDcYYUW+G++Mb8aU"
Seta:="|<Seta>*200$7.476qC3"
CST:="|<CST>*182$19.SCDkcV840Y20G0s9024U12EcV7XUY"
PisCST:="|<PisCST>*191$14.7m12YEd4+FwUE84210YE800000QTcV20EU47108G"
BCIsentas:="|<BCIsentas>*167$39.kw500018Ec002905000F818lmnl099FNF828Xu+90F2EFF8I9+++kwV6CFA"
BCIsentasPrimeiro:="|<BCISentasTOP>*161$29.k2400E480008E000UX70119F0428y08490EU9+/10FXY"
IsentoN:="|<Isento/N.>*167$33.0002V00E0K80202l6KNkZ8/+F4d7FG94c2+F8X1FG+4Mm9CEVA"
ProximaNota:="|<ProximaNota>*192$7.UM/5nxzzzjbXVUU|<ProximaNota>*186$7.UM+4mxzzzjbXVUU|<ProximaNota>*189$7.UM+5nxzzzjbXVUU|<ProximaNota>*177$7.UM+4mhTzzjbXVUU"

NumpadAdd::
    if (ok:=FindText(X, Y, 407-150000, 222-150000, 407+150000, 222+150000, 0, 0, CFOPs)) {
        ;Pega a quantidade de Itens
        if ClickOnImage(Itens, 0, 0, "L", "Itens", X, Y){
            Sleep 30
            ClickOnImage(Itens, 15, 18, "R", "Itens", X, Y)
            Sleep 32
            Send, {Down}{Sleep 10}{Down}{Sleep 10}{Down}{Sleep 10}{Enter}
            ItensO := Clipboard
            ItensV := RegExFindValue(ItensO, "([\d]+)\s")
            Sleep 30
            ;Entrar nos itens
            Send, ^{Enter}

            WinWait, Itens da NF

            if ExistActivate("Itens da NF"){
                Sleep 300

                ;Espera a setinha pra cima do scroll de itens aparecer e clica nela
                ClickOnImage(Seta, 0, 0, "L", "Seta", X, Y)
                Sleep 30
                Send, {Click 15}
            }
            ;Espera botao de impostos aparecer e clica nele
            while(ItensV) {
                
                Sleep 160
                Send, !i
                Sleep 26
                Send, ^{Enter}

                WinWait, Impostos
                ;Espera janela de impostos ativar
                if ExistActivate("Impostos"){

                    Sleep 200
                    ClickOnImage(CST, 0, 0, "L", "CST", X, Y)
                    Send, 090
                    Sleep 20
                    Send, {Enter}{Sleep 10}{Bs}{Sleep 10}{Enter}

                    Send, 3
                    Send, {Enter 2}
                    Sleep 32
                    Send, {Bs}{Sleep 10}{Enter}{Sleep 10}{Bs}{Sleep 10}{Enter}{Sleep 10}

                    ClickOnImage(BCIsentasPrimeiro, 0, 0, "L", "BCIsentasPrimeiro", X, Y)
                    ClickOnImage(BCIsentasPrimeiro, 0, 18, "R", "BCIsentasPrimeiro", X, Y)
                    Sleep 32
                    Send, {Down}{Sleep 10}{Down}{Sleep 10}{Down}{Sleep 10}{Enter}
                    Sleep 80

                    ;Clica no CST do PIS
                    ClickOnImage(PisCST, 0, 26, "L", "CSTPis", X, Y)
                    Send, {Click}
                    Send, 99
                    Send, {Enter}

                    
                    ;Pega valor de BC/ISENTAS/OUTRAS
                    ClickOnImage(BCIsentas, 0, 0, "L", "BC/Isentas", X, Y)
                    ClickOnImage(BCIsentas, 0, 18, "R", "BC/Isentas", X, Y)
                    Send, {Down}{Sleep 10}{Down}{Sleep 10}{Down}{Sleep 10}{Down}{Sleep 10}{Enter}
                    Sleep 22
                    Send, +{Tab}+{Tab}
                    Sleep 22
                    Send, 49
                    Sleep 22
                    Send, {Enter}
                    Sleep 22
                    Send, 3
                    Sleep 22
                    Send, {Enter}
                    Sleep 22
                    Send, {Tab}{Sleep 10}{Bs}{Sleep 10}{Tab}{Sleep 10}{Bs}
                    Sleep 22
                    Send, {Tab 6}

                    ;Arruma a linha do PIS
                    Sleep 32
                    Send, 49
                    Send, {Tab}{Sleep 10}{Bs}{Sleep 10}{Tab}{Sleep 10}{Bs}{Sleep 10}{Tab}{Sleep 10}{Bs}{Sleep 10}{Tab}{Sleep 10}{Bs}{Sleep 10}{Tab}{Sleep 10}{Bs}{Sleep 10}{Tab}
                    Send, {Tab 2}
                    Sleep 32
                    Send, {Tab}{Sleep 10}{Bs}{Sleep 10}{Tab}{Sleep 10}{Bs}{Sleep 10}{Tab}{Sleep 10}{Bs}{Sleep 10}{Tab}{Sleep 10}{Bs}{Sleep 10}{Tab}{Sleep 10}{Bs}{Sleep 10}

                    ;Vai para o Isento/N. Tributado apaga e troca pelo valor de BC/ISENTAS/OUTRAS
                    ClickOnImage(IsentoN, 0, 0, "L", "Isento/N. Tributado", X, Y)
                    ClickOnImage(IsentoN, 0, 18, "R", "Isento/N. Tributado", X, Y)
                    Sleep 32
                    Send, {Down}{Sleep 10}{Down}{Sleep 10}{Down}{Sleep 10}{Down}{Sleep 10}{Enter}
                    Sleep 32

                    Send, {Enter}
                    Sleep 32
                    ;Sai dos impostos e grava
                    Send, !o!o
                    Sleep 26
                    Send, !g!g
                
                    Sleep 32
                    Send, !s!s
                    Sleep 80

                    ItensV := ItensV - 1
                    
                    WinWait, Itens da NF

                    if ExistActivate("Itens da NF"){
                        Sleep 300

                        ;Espera a setinha pra cima do scroll de itens aparecer e clica nela
                        ClickOnImage(ProximaNota, 0, 0, "L", "ProximaNota", X, Y)
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