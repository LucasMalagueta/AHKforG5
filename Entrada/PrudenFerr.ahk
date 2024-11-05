#SingleInstance, force
#Include <FindText>
#Include <matFunctions>
SetTitleMatchMode, 2

Menu, Tray, Icon, C:\Users\%A_Username%\Documents\AutoHotkey\Lib\pngwing.com.ico  

Turbo:="|<Turbo>*120$27.y020100E0802012/SC8FG+92+FF8FG+92OFF8BHlo|120$27.y020100E0802012/SC8FG+92+FF8FG+92OFF8BHlo"
ProximaNFE:="|<ProximaNFE>*139$14.E0701w0Tk7z1zwTyLy1y0S060000008"
NFEAnterior:="|<NFEAnterior>*148$8.0kwzbkQ108"
cc:="|<c/c>*110$18.S2SV2VU2UU4UU4UU8UU8UVEVSESU"
DoisNove:="|<2949>*160$27.S1kNkEF7F229e8EFNF41vxt0111EEM8TuC1CU"
UmNove:="|<1949>*149$25.E71bM4FoI28e+14Z50SzSU111F1UVwXUHc"
DoisTres:="|<2353>*153$26.w3nnl04U4E18141XlW04450111UUEETcssu"
UmTres:="|<1353>*154$25.E7bbs0G0I090+0MwN0222U111F0UUwXXXc"
Contabil:="|<Contabil>*132$37.S000G2kU08F0M0040UA1mnCSK15Z0cf0WWXoJUFFG++kccd55LXYGSwg"

NumpadAdd::
    InputBox, NumCasas, Repetição, Quantas vezes irá rodar?, , 300, 130
    IfEqual, ErrorLevel, 1, Return

    loop %NumCasas% {

        ;Checar se a janela de notas esta ativa
        If WinActive("Lançamentos Fiscais") {
            ;Clicar no C/C e ajustar para 1
            if (ok:=FindText(X, Y, 572-150000, 549-150000, 572+150000, 549+150000, 0, 0, Turbo)) {
                ;Checar se a janela de notas esta ativa
                
                    
                
                Sleep 10

                ;Procura 1949
                if (ok:=FindText(X, Y, 702-150000, 579-150000, 702+150000, 579+150000, 0, 0, UmNove)){
                    ;Arruma o C/C
                    ClickOnImage(cc, 15, 18, "L", "C/C", X, Y) 
                    send,{BS}1
                    Sleep 10
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
                        Sleep 20                           
                    }
                } ;Procura 2949
                if (ok:=FindText(X, Y, 702-150000, 579-150000, 702+150000, 579+150000, 0, 0, DoisNove)){
                    ;Arruma o C/C
                    ClickOnImage(cc, 15, 18, "L", "C/C", X, Y) 
                    send,{BS}1
                    Sleep 10
                    ;Clica no Turbo
                    sleep 8
                    if ClickOnImage(Turbo, 9, 16, "L", "Turbo", X, Y) {
                        Sleep 10
                        ;Coloca codigo do Turbo e confirma
                        Send,3{sleep 5}{Enter 7}{Sleep 10}
                        ;Apaga PIS e COFINS
                        Send,{BS}{Sleep 5}{Enter}{Sleep 5}{BS}{Sleep 5}{Enter}{Sleep 5}{BS}{Sleep 5}{Enter}{Sleep 5}{BS}{Sleep 5}{Enter}{Sleep 5}{BS}{Sleep 5}{Enter}{Sleep 5}{BS}
                        ;Termina de confirmar a nota
                        Send,{Sleep 2} !g
                        Sleep 20                           
                    }
                }

                 ;Procura 1353 ou 2353
                else if (ok:=FindText(X, Y, 492-150000, 614-150000, 492+150000, 614+150000, 0, 0, UmTres) or ok:=FindText(X, Y, 702-150000, 579-150000, 702+150000, 579+150000, 0, 0, DoisTres)){
                    ;Arruma o C/C
                    ClickOnImage(cc, 15, 18, "L", "C/C", X, Y) 
                    send,{BS}1
                    Sleep 10
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
                        Sleep 20                          
                    }
                }
                    
                Sleep 100
                ;Loop para esperar a nota carregar
                val := 1 
                while (val == 1) {
                    If (ok:=FindText(X, Y, 320-150000, 345-150000, 320+150000, 345+150000, 0, 0, Contabil)) {
                        val := 0
                    }
                }
                Sleep 20
                ;Ir para a proxima nota
                if (ClickOnImage(ProximaNFE, 0, 0, "L", "Seta Direita", X, Y) and ActiveActivate("Lançamentos Fiscais")) {
                    flag := 0
                    Sleep 25
                }

            } else {
                Return
                }  
        }
    }
Return


