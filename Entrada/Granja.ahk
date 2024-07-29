#SingleInstance Force
#Include <UIA>
#Include <matFunctionsV2>
#Include <FindTextV2>
#Include <AccV2>
TraySetIcon("Shell32.dll","10")

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

    if (CFOPV == 1904) {
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
        Send "{Click 15}"

        ;Espera botao de impostos aparecer e clica nele
        PgwFEl.WaitElementFromPath("Y4ur").ControlClick()
        Send "^{Enter}"
        Sleep 70

        ;Espera janela de impostos ativar
        WinWaitActive "Impostos"
        Sleep 70

        ;Apaga conteudo do segundo quadradinho e coloca 090
        Send "{Tab}{BS}"
        Sleep 70
        Send "090"

        ;Apaga conteudo do quarto quadradinho e coloca 3
        Sleeper("{Tab}", 80, 2)
        Sleeper("{BS}", 80, 3)
        Send "3"
        Sleep 70

        ;Atualiza o handle da janela
        PgwFEl := UIA.ElementFromHandle("Impostos ahk_exe PgwF.exe")

        ;Clica no CST do PIS COFINS apaga e coloca 73
        PgwFEl.WaitElementFromPath("Yt4y").ControlClick()
        Send "^a{BS}"
        Sleep 50
        Send "99{Enter}"

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
        Sleep 70
        Send "!o"
        Sleep 70
        Send "!g"
        Sleep 70
        Send "!s"
        Sleep 70

        Global ItensV := ItensV - 1
    
        loop ItensV {
            CorrigirItem()
        }

        Winactivate "Itens da NF"
        Winclose "Itens da NF"
        WinWaitActive "Lançamentos Fiscais" 

        Send "!g"
        Sleep 70
        Send "!s"

        PgwFEl := UIA.ElementFromHandle("Lançamentos Fiscais")
        PgwFEl.ElementFromPath("0qr").Click()
    }

}


CorrigirItem() {
    Sleep 200
    PgwFEl := UIA.ElementFromHandle("Itens da NF ahk_exe PgwF.exe")
    Sleep 70

    ;Clica na proxima nota
    PgwFEl.WaitElementFromPath("Y/0s").Click()
    Sleep 70

    ;Entrar nos impostos
    PgwFEl.WaitElementFromPath("Y4ur").ControlClick()
    Send "^{Enter}"
    Sleep 70

    WinWaitActive "Impostos"
    Sleep 70

    Send "{Tab}{BS}"
    Sleep 70
    Send "090"

    Sleeper("{Tab}", 80, 2)
    Sleeper("{BS}", 80, 3)
    Send "3"
    Sleep 70
    
    PgwFEl := UIA.ElementFromHandle("Impostos ahk_exe PgwF.exe")

    PgwFEl.WaitElementFromPath("Yt4y").ControlClick()
    Send "^a{BS}"
    Sleep 50
    Send "99{Enter}"

    BCIO := (PgwFEl.WaitElementFromPath("Yy4qr").Dump())
    REGEX := "Value:\s`"([^`"]*)"
    BCIV := RegExFindValue(BCIO, REGEX)

    PgwFEl.WaitElementFromPath("Yt4t").ControlClick()

    Send "{Tab}{BS}"
    Send BCIV
    Send "{Enter}"
    Sleep 70

    Send "!o"
    Sleep 70
    Send "!g"
    Sleep 70
    Send "!s"
    Sleep 70
}

;Type: 50004 (Edit) Value: "1.403" LocalizedType: "editar" AutomationId: "199290" ClassName: "TEditColorido"


RegExFindValue(String, regexPattern) {
    ; Use RegExMatch to find the match
    if (RegExMatch(String, regexPattern, &match)) {
        ; The value will be in match[1]
        extractedValue := match[1]
    } else {
        MsgBox "Valor não encontrado no campo desejado", "Falha", 16
        Exit
    }

    Return extractedValue
}