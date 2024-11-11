#SingleInstance Force
#Include <UIA>
#Include <matFunctionsV2>
#Include <FindTextV2>
#Include <AccV2>
TraySetIcon("C:\Users\" A_Username "\Documents\AutoHotkey\Lib\pngwing.com.ico")

SetTitleMatchMode 2
;Imagens de referencias para clicks
;Imagens SPED


NumpadAdd:: {
    PgwFEl := UIA.ElementFromHandle("Lançamentos Fiscais | ahk_exe PgwF.exe")
    ;https://github.com/Descolada/UIA-v2/wiki/04.-Elements#findwait-methods
    CFOPO := (PgwFEl.WaitElementFromPath("IY4vt").Dump())

    ;https://www.autohotkey.com/docs/v2/misc/RegEx-QuickRef.htm
    REGEX := "Value:\s`"([^`"]*)"
    CFOPV := RegExFindValue(CFOPO, REGEX)
    CFOPV := StrReplace(CFOPV, ".", "")


    ; Display the extracted value
    ;MsgBox "Valor do campo 'CFOP': " . CFOPV, "Sucesso", 64

    if (CFOPV == 5929 or CFOPV == 6929) {
        ;Pegar quantidade de itens do botao Itens
        ItensO := PgwFEl.ElementFromPath("IYYr4/").Dump()
        REGEX := "Value:\s`"([^`"]*)"
        Global ItensV := RegExFindValue(ItensO, REGEX)
        REGEX := "([^\s]*)"
        Global ItensV := RegExFindValue(ItensV, REGEX)

        ;Entrar nos itens
        PgwFEl.WaitElementFromPath("IYYr4/").ControlClick()
        Send "^{Enter}"

        ;Espera janela dos itens ativar e atualiza handle
        WinWaitActive "Itens da NF"
        Sleep 70
        PgwFEl := UIA.ElementFromHandle("Itens da NF ahk_exe PgwF.exe")

        ;Espera a setinha pra cima do scroll de itens aparecer e clica nela
        PgwFEl.WaitElementFromPath("YsE0").Click("left")
        Send "{Click 5}"

        ;Espera botao de impostos aparecer e clica nele
        PgwFEl.WaitElementFromPath("Y4ur").ControlClick()
        Send "^{Enter}"
        Sleep 100

        ;Espera janela de impostos ativar
        WinWaitActive "Impostos"
        Sleep 100

        ;Apaga conteudo do segundo quadradinho e coloca 090
        Send "{Tab}{BS}"
        Sleep 100
        Send "090"

        ;Apaga conteudo do quarto quadradinho e coloca 3
        Sleeper("{Tab}", 80, 2)
        Sleeper("{BS}", 80, 3)
        Send "3"
        Sleep 50

        ;Apagar ALQ e ICMS
        Sleeper("{Tab}", 30, 2)
        Send "^a{BS}"
        Sleeper("{Tab}", 30, 1)
        Send "^a{BS}"
        Sleep 100

        ;Atualiza o handle da janela
        PgwFEl := UIA.ElementFromHandle("Impostos ahk_exe PgwF.exe")

        ;Clica no CST do PIS COFINS apaga e coloca 49
        PgwFEl.WaitElementFromPath("Yt4y").ControlClick()
        Send "^a{BS}"
        Sleep 50
        Send "49{Enter}"
        ;Apaga as duas linhas, deixando apenas o valor no isento
        Sleeper("^a{BS}{Enter}", 10, 5)
        Sleeper("{Tab}", 30, 3)
        Sleeper("^a{BS}{Enter}", 10, 5)

        ;Pega valor de BC/ISENTAS/OUTRAS
        BCIO := (PgwFEl.WaitElementFromPath("Yy4qr").Dump())
        REGEX := "Value:\s`"([^`"]*)"
        BCIV := RegExFindValue(BCIO, REGEX)

        ;Clica um quadrado antes do Isento/N. Tributado
        PgwFEl.WaitElementFromPath("Yt4t").ControlClick()

        ;Vai para o Isento/N. Tributado apaga e troca pelo valor de BC/ISENTAS/OUTRAS
        Send "{Tab}{BS}"
        Send BCIV
        Send "{Enter}"

        ;Sai dos impostos e grava
        Sleep 100
        Send "!o"
        Sleep 150
        Send "!g"
        Sleep 150
        Send "!s"
        Sleep 200

        Global ItensV := ItensV - 1
    
        loop ItensV {
            CorrigirItem()
        }

        Winactivate "Itens da NF"
        Winclose "Itens da NF"

        if Winactive("Valores Lançados"){
            Send "!s"
            Sleep 80
            Send "!s"                
        }
        
        WinWaitActive "Lançamentos Fiscais" 

        Send "!g"
        Sleep 100
        Send "!s"
        Sleep 100

        PgwFEl := UIA.ElementFromHandle("Lançamentos Fiscais")
        Sleep 200
        PgwFEl.ElementFromPath("0rr").ControlClick()
    }

}


CorrigirItem() {
    Sleep 300
    PgwFEl := UIA.ElementFromHandle("Itens da NF")
    Sleep 100

    ;Clica na proxima nota
    PgwFEl.WaitElementFromPath("Y/0s").Click()
    Sleep 100

    ;Entrar nos impostos
    PgwFEl.WaitElementFromPath("Y4ur").ControlClick()
    Sleep 100
    Send "^{Enter}"
    Sleep 100

    WinWaitActive "Impostos"
    Sleep 100

    Send "{Tab}{BS}"
    Sleep 100
    Send "090"

    Sleeper("{Tab}", 80, 2)
    Sleeper("{BS}", 80, 3)
    Send "3"
    
    ;Apagar ALQ e ICMS
    Sleeper("{Tab}", 30, 2)
    Send "^a{BS}"
    Sleeper("{Tab}", 30, 1)
    Send "^a{BS}"
    Sleep 100
    
    PgwFEl := UIA.ElementFromHandle("Impostos ahk_exe PgwF.exe")

    PgwFEl.WaitElementFromPath("Yt4y").ControlClick()
    Send "^a{BS}"
    Sleep 50
    Send "49{Enter}"

    ;Apaga as duas linhas, deixando apenas o valor no isento
    Sleeper("^a{BS}{Enter}", 10, 5)
    Sleeper("{Tab}", 30, 3)
    Sleeper("^a{BS}{Enter}", 10, 5)

    BCIO := (PgwFEl.WaitElementFromPath("Yy4qr").Dump())
    REGEX := "Value:\s`"([^`"]*)"
    BCIV := RegExFindValue(BCIO, REGEX)

    PgwFEl.WaitElementFromPath("Yt4t").ControlClick()

    Send "{Tab}{BS}"
    Send BCIV
    Send "{Enter}"
    Sleep 100

    Send "!o"
    Sleep 150
    Send "!g"
    Sleep 150
    Send "!s"
    Sleep 200
}

;Type: 50004 (Edit) Value: "1.403" LocalizedType: "editar" AutomationId: "199290" ClassName: "TEditColorido"
