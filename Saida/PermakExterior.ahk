#SingleInstance Force
#Include <FindTextV2>
#Include <matFunctionsV2>
#Include <AccV2>
#Include <UIA>
#Requires AutoHotkey v2.0

TraySetIcon("C:\Users\" A_Username "\Documents\AutoHotkey\Lib\pngwing.com.ico")
SetTitleMatchMode(2)

;Janelas que permitem funcionamento
GroupAdd("G5", "G5 Phoenix - Escrita Fiscal por Computador")
GroupAdd("G5", "Lançamentos Fiscais")
GroupAdd("G5", "Impostos")
GroupAdd("G5", "Itens da NF")

;Variaveis globais
Global FlagEstado := ""
Global filePath := ""
Global NumItem := ""
Global NumNFE := "000"
Global UNIDADE := "UNI"
Global tipoItem := "Mercadoria"
Global SleepTime := 100
Global FlagPrint := 0
Global flag1 := 0

nextPos := 0

NFEe:="|<NFEe>*145$17.WT1YU390xHmOY7n88aEH4US"
Lupa:="|<Lupa>*210$18.0000z031k40M80A8Q4Ey2Fr2FX2EQ2Ey29r49X4A0860E31U0y0000U"
C195:="|<C195>*162$35.000000Aw8wwUH8l90V42aO12814rX4E2DVa8U433AFa8YaMVsFtsUU00011U0004000000U|<C195-2>*160$35.0000004s8swUH8l90V42W+12814rU4E2DU28U4214Fa8YUEVsFlsUU00010U0004000000U"
Novo:="|<>*153$33.zzzzzzzzzzzeeeees0000300000s0000300000s0000300000s00003WQ000wIE003IW000uYE0038W000t3U00300000s0000300000ueeeefzzzzzw"

;Definir qual XML esta sendo trabalhada
    NumpadAdd:: {
        PgwFEl := UIA.ElementFromHandle("Lançamentos Fiscais | ahk_exe PgwF.exe")
        ;Tenta pesquisa rapida antes das demais

        CFOPO := (PgwFEl.WaitElementFromPath("IY4vt").Dump())
        REGEX := "Value:\s`"([^`"]*)"
        Global CFOPV := RegExFindValue(CFOPO, REGEX)
        Global CFOPV := StrReplace(CFOPV, ".", "")

        global ItemAtual := 0

        if(CFOPV == 7101 or CFOPV == 7102){

            ItensO := PgwFEl.ElementFromPath("IYYr4/").Dump()
            REGEX := "Value:\s`"([^`"]*)"
            Global ItensV := RegExFindValue(ItensO, REGEX)
            REGEX := "([^\s]*)"
            Global UltimoItem := RegExFindValue(ItensV, REGEX)

            PgwFEl.WaitElementFromPath("IYYr4/").ControlClick()
            Send "^{Enter}"

            ;Espera janela dos itens ativar e atualiza handle
            WinWaitActive "Itens da NF"
            Sleep 70
            PgwFEl := UIA.ElementFromHandle("Itens da NF ahk_exe PgwF.exe")

            ;Espera a setinha pra cima do scroll de itens aparecer e clica nela
            PgwFEl.WaitElementFromPath("YsE0").Click("left")
            Send "{Click 15}"

            Sleep 70

            global Flag := 1

            Loop {
                
                CorrigirItem()
                if (UltimoItem == ItemAtual){
                    break
                }
                while (flag1 == 1) {
                if (ok:=FindText(&X, &Y, 423-150000, 160-150000, 423+150000, 160+150000, 0, 0, Novo)){
                    global flag1 := 0
                }
            }
            }
        
            
            global Flag := 1

            Winactivate "Itens da NF"
            Winclose "Itens da NF"
            WinWaitActive "Lançamentos Fiscais" 

            ; Send "!g"
            ; Sleep 70
            ; Send "!s"

            ; PgwFEl := UIA.ElementFromHandle("Lançamentos Fiscais")
            ; PgwFEl.ElementFromPath("0qr").Click()
        }
    }   

    CorrigirItem() {
        Sleep 200

        PgwFEl := UIA.ElementFromHandle("Itens da NF ahk_exe PgwF.exe")
        Sleep 70  

        ;Clica na proxima nota
        if(Flag != 1)
            PgwFEl.WaitElementFromPath("Y/0r").Click()

        Sleep 70

        ;Pega o numero do proximo item
        NumItemO := PgwFEl.WaitElementFromPath("Yr4s").Dump()
        REGEX := "Value:\s`"([^`"]*)"
        Global NumItem := RegExFindValue(NumItemO, REGEX)

        Sleep 70

        ;Entrar nos impostos
        PgwFEl.WaitElementFromPath("Y4ur").ControlClick()
        Send "^{Enter}"
        Sleep 100
    
        WinWaitActive "Impostos"
        Sleep 70

        PgwFEl := UIA.ElementFromHandle("Impostos")

        Sleep 70

        PgwFEl.WaitElementFromPath("Yw4q").ControlClick()
        Sleeper("{Tab}", 80, 1)
        Send 99
    
        PgwFEl.WaitElementFromPath("Yu4q").ControlClick()
        Sleeper("{Tab}", 80, 1)
        Send "49"
        Sleeper("{Tab}{BS}", 80, 6)

        Sleep 70 

        Sleeper("{Tab}", 80, 2)

        Send "49"
        Sleeper("{Tab}{BS}", 80, 6)
        Sleep 60
    
        Send "!o!o"
        Sleep 70
        PgwFEl := UIA.ElementFromHandle("Itens da NF")
        Sleep 130
        PgwFEl.WaitElementFromPath("Y0").Click()
        Sleep 1800
        if(WinExist("Erros")){
            Send "!s"
            Send 70
        }
        global ItemAtual += 1
        global Flag := 0
        global flag1 := 1
    }