#SingleInstance, force
#Include <FindText>
#Include <matFunctions>
SetTitleMatchMode, 2

Menu, Tray, Icon, C:\Users\%A_Username%\Documents\AutoHotkey\Lib\pngwing.com.ico     

;Imagens de referencias para clicks
;Imagens SPED

CFOPs := "|<1903>*171$27.83XXr0mqG84IEF0WWA83oEF02W38UqoLoQQSU|<1902>*170$27.83XXr0mqG84IEF0WW283oEV02W88Uqm7oQQzU|<1915>*167$26.83UXy1YsUUF2884EXm0w84U1218UkWTcsyy|<1916>*168$26.83UVy1YsUUF2E84Ebm0w94U12F8UkaTcsyu|<1925>*168$26.83Xny1YYUUF1884EHm0w84U1418Um2Tctyy|<2909>*167$27.S1llmENPN22++8EFFF41u9t01F1EEPMTuCCCU|<2911>*180$28.S1kEF8Ab70UW44228EEE7V120244EEMEHx77rs|<2915>*167$27.S1kFuENC8228F0EF2D41sE90121EEMFDuCDjU|<1556>*174$26.83nly0UUUU88E83nrm0454U11F8WGKTcwwu|<2556>*170$27.S1tsuE88821120EDDT408+9011FEF9/DuDDCU|<1407>*171$27.80nbz0Cq383IEF0mW687wEV02WA8UKl7o2QMU|<2407>*183$28.S0Nnx83hUkUOW223+8MEDsV202WAEE/MXx0b68"
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
                    Send, 99
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