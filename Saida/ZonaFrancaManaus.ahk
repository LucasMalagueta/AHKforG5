#SingleInstance Force
#Include <FindTextV2>
#Include <matFunctionsV2>
#Include <AccV2>
#Include <UIA>

TraySetIcon("C:\Users\" A_Username "\Documents\AutoHotkey\Lib\pngwing.com.ico")
SetTitleMatchMode(2)

;Janelas que permitem funcionamento
; GroupAdd("G5", "G5 Phoenix - Escrita Fiscal por Computador")
; GroupAdd("G5", "Lançamentos Fiscais")
; GroupAdd("G5", "Impostos")
; GroupAdd("G5", "Itens da NF|")

;Variaveis globais
global ItemAtual := 0
Global SleepTime := 220
Global Flag := 1

nextPos := 0


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
        Global ItensV := RegExFindValue(ItensV, REGEX)

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
        WinWaitActive "Itens da NF|"
        Sleep SleepTime
        PgwFEl := UIA.ElementFromHandle("Itens da NF|")

        ;Espera a setinha pra cima do scroll de itens aparecer e clica nela
        PgwFEl.WaitElementFromPath("YsE0").Click("left")
        Send "{Click 15}"

        Sleep SleepTime

        if(AbatimentoV == 0){
            Loop ItensV {
                CorrigirItem()
            }
        }else if(AbatimentoV != 0){
            Loop ItensV {
                CorrigirItemAbatido()
            }
        }

        Winactivate "Itens da NF"
        Winclose "Itens da NF"
        WinWaitActive "Lançamentos Fiscais" 

        global Flag := 1

        ; Send "!g"
        ; Sleep SleepTime
        ; Send "!s"

        ; PgwFEl := UIA.ElementFromHandle("Lançamentos Fiscais")
        ; PgwFEl.ElementFromPath("0qr").ControlClick()
    }
}   

CorrigirItem() {
    WinWaitActive "Itens da NF|"
    Sleep 800
    PgwFEl := UIA.ElementFromHandle("Itens da NF|")
    Sleep 1500

    ;Clica na proxima nota
    if(Flag == 0){
        Sleep 1200
        PgwFEl.WaitElementFromPath("Y/0r").Click()
        ; Sleep 100
        ; Send "Enter"
    }
        

    Sleep 1000

    ;Entrar nos impostos
    PgwFEl.WaitElementFromPath("Y4ur").ControlClick()
    Send "^{Enter}"
    Sleep 250

    WinWaitActive "Impostos"
    Sleep SleepTime

    PgwFEl := UIA.ElementFromHandle("Impostos ahk_exe PgwF.exe")


    PgwFEl.WaitElementFromPath("Yu4q").ControlClick()
    Sleeper("{Tab}", 80, 1)
    Send "49"
    Sleeper("{Tab}{BS}", 80, 5)
    Sleep 80

    Sleeper("{Tab}", 80, 3)

    Send "49"
    Sleeper("{Tab}{BS}", 80, 5)
    Sleep SleepTime


    Send "!o"
    Sleep 200
    if(WinExist("Erros")){
        Send "!s"
        Sleep 250
    }

    PgwFEl := UIA.ElementFromHandle("Itens da NF|")
    Sleep SleepTime
    PgwFEl.WaitElementFromPath("Y0").Click()
    ; Sleep 100
    ; Send "Enter"
    
    Sleep 350
    ;WinWaitActive "Erros"
    Sleep 75
    Send "!s"
    Sleep 2500

    global ItemAtual += 1
    global Flag := 0
}

CorrigirItemAbatido() {
    Sleep 300
    PgwFEl := UIA.ElementFromHandle("Itens da NF|")
    Sleep 1500

    ;Clica na proxima nota
    if(Flag == 0){
        Sleep 1200
        PgwFEl.WaitElementFromPath("Y/0r").Click()
        ; Sleep 100
        ; Send "Enter"
    }
        

    Sleep 1000

    ;Entrar nos impostos
    PgwFEl.WaitElementFromPath("Y4ur").ControlClick()
    Send "^{Enter}"
    Sleep 250

    WinWaitActive "Impostos"
    Sleep 250

    PgwFEl := UIA.ElementFromHandle("Impostos ahk_exe PgwF.exe")

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
    Sleep SleepTime

    Sleeper("{Tab}", 80, 3)

    Send "49"
    Sleeper("{Tab}{BS}", 80, 5)
    Sleep SleepTime


    Send "!o!o"
    Sleep 200
    if(WinExist("Erros")){
        Send "!s"
        Sleep 220
    }

    PgwFEl := UIA.ElementFromHandle("Itens da NF|")

    PgwFEl.WaitElementFromPath("Yr4w").ControlClick()
    Sleeper("{Tab}+{Tab}", 80, 1)
    Sleep 270
    ;Send "^a^a"
    Sleep 270
    Send VALORv
    Sleep 250

    Sleep SleepTime
    PgwFEl.WaitElementFromPath("Y0").Click()
    ; Sleep 100
    ; Send "Enter"

    Sleep 350
    ;WinWaitActive "Erros"
    Sleep 100
    Send "!s"
    Sleep 2500
    

    global ItemAtual += 1
    global Flag := 0
}