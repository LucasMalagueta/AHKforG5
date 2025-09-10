#SingleInstance, force
#Include <FindText>
#Include <matFunctions>
SetTitleMatchMode, 2

Menu, Tray, Icon, C:\Users\%A_Username%\Documents\AutoHotkey\Lib\pngwing.com.ico     

;Imagens de referencias para clicks
;Imagens SPED


Novo:="|<>*153$33.zzzzzzzzzzzeeeees0000300000s0000300000s0000300000s00003WQ000wIE003IW000uYE0038W000t3U00300000s0000300000ueeeefzzzzzw"
UmNoveZeroQuatro:="|<1904>*180$27.83XUr0mqC84IHF0WWm83oLt02W28UqkLoQQ2U"
Itens:="|<Itens>*127$22.U002E009000aQgOG/+NDcYYUW+G++Mb8aU"
Seta:="|<Seta>*200$7.476qC3"
CST:="|<CST>*182$19.SCDkcV840Y20G0s9024U12EcV7XUY"
IpiCST:="|<IPIC>*165$12.G5G5G5HtG1G1G1G10000000077cV8181710V0VcV71U"
PisCST:="|<PisCST>*191$14.7m12YEd4+FwUE84210YE800000QTcV20EU47108G"
BCIsentas:="|<BCIsentas>*167$39.kw500018Ec002905000F818lmnl099FNF828Xu+90F2EFF8I9+++kwV6CFA"
IsentoN:="|<Isento/N.>*167$33.0002V00E0K80202l6KNkZ8/+F4d7FG94c2+F8X1FG+4Mm9CEVA"
ProximaNota:="|<ProximaNota>*192$7.UM/5nxzzzjbXVUU|<ProximaNota>*186$7.UM+4mxzzzjbXVUU|<ProximaNota>*189$7.UM+5nxzzzjbXVUU|<ProximaNota>*177$7.UM+4mhTzzjbXVUU"


NumpadAdd::
    if (ok:=FindText(X, Y, 407-150000, 222-150000, 407+150000, 222+150000, 0, 0, UmNoveZeroQuatro)) {
        ;Pega a quantidade de Itens
        if ClickOnImage(Itens, 0, 0, "L", "Itens", X, Y){
            Sleep 30
            ClickOnImage(Itens, 15, 18, "R", "Itens", X, Y)
            Sleep 32
            Send, {Down}{Sleep 20}{Down}{Sleep 20}{Down}{Sleep 20}{Enter}
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
                    Sleep 32
                    Send, {Enter 2}
                    Send, 3
                    Send, {Enter}

                    ;Clica no CST do PIS
                    ClickOnImage(PisCST, 0, 26, "L", "CSTPis", X, Y)
                    Send, {Click}
                    Send, 99
                    Send, {Enter}

                    
                    ;Pega valor de BC/ISENTAS/OUTRAS
                    ClickOnImage(BCIsentas, 0, 0, "L", "BC/Isentas", X, Y)
                    ClickOnImage(BCIsentas, 0, 15, "R", "BC/Isentas", X, Y)
                    Sleep 32
                    Send, {Down}{Sleep 20}{Down}{Sleep 20}{Down}{Sleep 20}{Enter}
                    Sleep 80

                    ;Vai para o Isento/N. Tributado apaga e troca pelo valor de BC/ISENTAS/OUTRAS
                    ClickOnImage(IsentoN, 0, 0, "L", "Isento/N. Tributado", X, Y)
                    ClickOnImage(IsentoN, 0, 18, "R", "Isento/N. Tributado", X, Y)
                    Sleep 32
                    Send, {Down}{Sleep 20}{Down}{Sleep 20}{Down}{Sleep 20}{Down}{Sleep}{Enter}
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
