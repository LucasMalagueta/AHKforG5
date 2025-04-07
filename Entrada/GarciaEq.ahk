#SingleInstance Force
#Include <UIA>
#Include <matFunctionsV2>
#Include <FindTextV2>
#Include <AccV2>
#Requires AutoHotkey v2.0

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

    if (CFOPV == 1403) {

        ;Pegar quantidade de itens do botao Itens
        ItensO := PgwFEl.ElementFromPath("IYYr4/").Dump()
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

        ;Atualiza o handle da janela
        PgwFEl := UIA.ElementFromHandle("Impostos ahk_exe PgwF.exe")

        ;Apaga conteudo do CST e coloca 060
        Send "{Tab}{BS}"
        Sleep 70
        Send "060"
        Send "{Enter}"
        Sleep 50

        ;Clica no quadrado "SOMAR ICMS ST"
        PgwFEl.WaitElementFromPath("Yy2").ControlClick()
        Sleep 70

        ;Clica no CST do IPI, apaga e coloca 49
        PgwFEl.WaitElementFromPath("Yv4v").ControlClick()
        Send "^a{BS}"

        Sleep 50
        Send "49{Enter}"
        Sleep 50
        Send "4{Enter}"
        

        ;Clica no CST do PIS
        PgwFEl.WaitElementFromPath("Yt4y").ControlClick()
        Send "{Tab}"
        Sleep 50
        Send "{BS 2}"
        Sleep 50
        Send "{Tab}"
        Sleep 50
        Send "{BS 2}"
        
        Sleep 50
        Sleeper("{Tab}",50,3)
        Send "{BS 2}"


        ;Clica no CST do COFINS
        PgwFEl.WaitElementFromPath("Ys4y").ControlClick()
        Send "{Tab}"
        Sleep 50
        Send "{BS 2}"
        Sleep 50
        Send "{Tab}"
        Sleep 50
        Send "{BS 2}"
        
        Sleep 50
        Sleeper("{Tab}",50,3)
        Send "{BS 2}"

        
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
        Send "!o!o"
        Sleep 70
        PgwFEl := UIA.ElementFromHandle("Itens da NF")
        Sleep 150
        PgwFEl.WaitElementFromPath("Y0").Click()
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
    PgwFEl.WaitElementFromPath("Y/0r").Click()
    Sleep 70

    ;Entrar nos impostos
    PgwFEl.WaitElementFromPath("Y4ur").ControlClick()
    Send "^{Enter}"
    Sleep 70

    ;Espera janela de impostos ativar
    WinWaitActive "Impostos"
    Sleep 70

    ;Atualiza o handle da janela
    PgwFEl := UIA.ElementFromHandle("Impostos ahk_exe PgwF.exe")

    ;Apaga conteudo do CST e coloca 060
    Send "{Tab}{BS}"
    Sleep 70
    Send "060"
    Send "{Enter}"
    Sleep 50


    ;Clica no quadrado "SOMAR ICMS ST"
    PgwFEl.WaitElementFromPath("Yy2").ControlClick()
    Sleep 70

    ;Clica no CST do IPI, apaga e coloca 49
    PgwFEl.WaitElementFromPath("Yv4v").ControlClick()
    Send "^a{BS}"

    Sleep 50
    Send "49{Enter}"
    Sleep 50
    Send "4{Enter}"
    

    ;Clica no CST do PIS
    PgwFEl.WaitElementFromPath("Yt4y").ControlClick()
    Send "{Tab}"
    Sleep 50
    Send "{BS 2}"
    Sleep 50
    Send "{Tab}"
    Sleep 50
    Send "{BS 2}"
    
    Sleep 50
    Sleeper("{Tab}",50,3)
    Send "{BS 2}"


    ;Clica no CST do COFINS
    PgwFEl.WaitElementFromPath("Ys4y").ControlClick()
    Send "{Tab}"
    Sleep 50
    Send "{BS 2}"
    Sleep 50
    Send "{Tab}"
    Sleep 50
    Send "{BS 2}"
    
    Sleep 50
    Sleeper("{Tab}",50,3)
    Send "{BS 2}"

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
    PgwFEl := UIA.ElementFromHandle("Itens da NF")
    Sleep 150
    PgwFEl.WaitElementFromPath("Y0").Click()
    Sleep 70
    Send "!s"
    Sleep 70
}

;Type: 50004 (Edit) Value: "1.403" LocalizedType: "editar" AutomationId: "199290" ClassName: "TEditColorido"