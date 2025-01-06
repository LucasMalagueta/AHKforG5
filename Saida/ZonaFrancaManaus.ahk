#SingleInstance Force
#Include <FindTextV2>
#Include <matFunctionsV2>
#Include <AccV2>
#Include <UIA>

TraySetIcon("C:\Users\" A_Username "\Documents\AutoHotkey\Lib\pngwing.com.ico")
SetTitleMatchMode(2)

;Janelas que permitem funcionamento
GroupAdd("G5", "G5 Phoenix - Escrita Fiscal por Computador")
GroupAdd("G5", "Lançamentos Fiscais")
GroupAdd("G5", "Impostos")
GroupAdd("G5", "Itens da NF")

;Variaveis globais
global ItemAtual := 0
Global SleepTime := 180
Global Flag := 1

nextPos := 0

NFEe:="|<NFEe>*145$17.WT1YU390xHmOY7n88aEH4US"
Lupa:="|<Lupa>*210$18.0000z031k40M80A8Q4Ey2Fr2FX2EQ2Ey29r49X4A0860E31U0y0000U"
C195:="|<C195>*162$35.000000Aw8wwUH8l90V42aO12814rX4E2DVa8U433AFa8YaMVsFtsUU00011U0004000000U|<C195-2>*160$35.0000004s8swUH8l90V42W+12814rU4E2DU28U4214Fa8YUEVsFlsUU00010U0004000000U"


;Definir qual XML esta sendo trabalhada
    NumpadAdd:: {
        PgwFEl := UIA.ElementFromHandle("Lançamentos Fiscais | ahk_exe PgwF.exe")
        ;Tenta pesquisa rapida antes das demais

        CFOPO := (PgwFEl.WaitElementFromPath("IY4vt").Dump())
        REGEX := "Value:\s`"([^`"]*)"
        Global CFOPV := RegExFindValue(CFOPO, REGEX)
        Global CFOPV := StrReplace(CFOPV, ".", "")

        if(CFOPV == 6110 or CFOPV == 6109 or CFOPV == 5901){

            ItensO := PgwFEl.ElementFromPath("IYYr4/").Dump()
            REGEX := "Value:\s`"([^`"]*)"
            Global ItensV := RegExFindValue(ItensO, REGEX)
            REGEX := "([^\s]*)"
            Global UltimoItem := RegExFindValue(ItensV, REGEX)

            AbatimentoO := PgwFEl.ElementFromPath("IY4z").Dump()
            REGEX := "Value:\s`"([^`"]*)"
            if (RegExMatch(AbatimentoO, REGEX, &match)) {
                Global AbatimentoV := RegExFindValue(AbatimentoO, REGEX)
            } else {
                Global AbatimentoV := 0
            }

            PgwFEl.WaitElementFromPath("IYYr4/").ControlClick()
            Send "^{Enter}"

            ;Espera janela dos itens ativar e atualiza handle
            WinWaitActive "Itens da NF"
            Sleep 180
            PgwFEl := UIA.ElementFromHandle("Itens da NF ahk_exe PgwF.exe")

            ;Espera a setinha pra cima do scroll de itens aparecer e clica nela
            PgwFEl.WaitElementFromPath("YsE0").Click("left")
            Send "{Click 15}"

            Sleep 180

            if(AbatimentoV == 0){
                Loop {
                    CorrigirItem()
                    if (UltimoItem == ItemAtual){
                        break
                    }
                }
            }else if(AbatimentoV != 0){
                Loop {
                    CorrigirItemAbatido()
                    if (UltimoItem == ItemAtual){
                        break
                    }
                }
            }

            Winactivate "Itens da NF"
            Winclose "Itens da NF"
            WinWaitActive "Lançamentos Fiscais" 

            global Flag := 1

            ; Send "!g"
            ; Sleep 180
            ; Send "!s"

            ; PgwFEl := UIA.ElementFromHandle("Lançamentos Fiscais")
            ; PgwFEl.ElementFromPath("0qr").Click()
        }
    }   

    CorrigirItem() {
        PgwFEl := UIA.ElementFromHandle("Itens da NF ahk_exe PgwF.exe")
        Sleep 1150
    
        ;Clica na proxima nota
        if(Flag != 1){
            Sleep 350
            PgwFEl.WaitElementFromPath("Y/0s").Click()
        }
            

        Sleep 325
    
        ;Entrar nos impostos
        PgwFEl.WaitElementFromPath("Y4ur").ControlClick()
        Send "^{Enter}"
        Sleep 250
    
        WinWaitActive "Impostos"
        Sleep 180

        PgwFEl := UIA.ElementFromHandle("Impostos")


        PgwFEl.WaitElementFromPath("Yu4q").ControlClick()
        Sleeper("{Tab}", 80, 1)
        Send "49"
        Sleeper("{Tab}{BS}", 80, 5)
        Sleep 80

        Sleeper("{Tab}", 80, 3)

        Send "49"
        Sleeper("{Tab}{BS}", 80, 5)
        Sleep 120

    
        Send "!o"
        Sleep 200
        if(WinExist("Erros")){
            Send "!s"
            Sleep 250
        }
        Send "!g"
        Sleep 50
        WinWaitActive "Erros"
        Sleep 75
        Send "!s"
        Sleep 350

        global ItemAtual += 1
        global Flag := 0
    }

    CorrigirItemAbatido() {
        PgwFEl := UIA.ElementFromHandle("Itens da NF ahk_exe PgwF.exe")
        Sleep 1150
    
        ;Clica na proxima nota
        if(Flag != 1){
            Sleep 350
            PgwFEl.WaitElementFromPath("Y/0s").Click()
        }
            

        Sleep 325
    
        ;Entrar nos impostos
        PgwFEl.WaitElementFromPath("Y4ur").ControlClick()
        Send "^{Enter}"
        Sleep 250
    
        WinWaitActive "Impostos"
        Sleep 250

        PgwFEl := UIA.ElementFromHandle("Impostos")

        VALORo := PgwFEl.WaitElementFromPath("Yy4qr").Dump()
        REGEX := "Value:\s`"([^`"]*)"
        VALORv := RegExFindValue(VALORo, REGEX)
        Sleep 250


        ;Altera o valor do IPI
        PgwFEl.WaitElementFromPath("Yv4v").ControlClick()
        Sleeper("{Tab}", 80, 2)
        Send VALORv
    

        ;Arruma o Pis e Cofins
        PgwFEl.WaitElementFromPath("Yu4q").ControlClick()
        Sleeper("{Tab}", 80, 1)
        Send "49"
        Sleeper("{Tab}{BS}", 80, 5)
        Sleep 120

        Sleeper("{Tab}", 80, 3)

        Send "49"
        Sleeper("{Tab}{BS}", 80, 5)
        Sleep 180

    
        Send "!o"
        Sleep 200
        if(WinExist("Erros")){
            Send "!s"
            Sleep 220
        }

        PgwFEl := UIA.ElementFromHandle("Itens da NF ahk_exe PgwF.exe")

        PgwFEl.WaitElementFromPath("Yr4w").ControlClick()
        Sleeper("{Tab}+{Tab}", 80, 1)
        Sleep 270
        Send "^a^a"
        Sleep 270
        Send VALORv
        Sleep 250

        Send "!g"

        Sleep 75
        WinWaitActive "Erros"
        Sleep 75
        Send "!s"
        Sleep 350
        

        global ItemAtual += 1
        global Flag := 0
    }