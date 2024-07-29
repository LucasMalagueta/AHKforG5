#Warn VarUnset, Off

;Funçoes
;Clica na imagem a qual foi passado o parametro e caso nao encontre avisa
ClickOnImage(image, xOffset, yOffset, mouseClick, label) {
    if (ok:=FindText(&FindX, &FindY, 572-150000, 549-150000, 572+150000, 549+150000, 0, 0, image)) {
        FindText().Click(FindX + xOffset, FindY + yOffset, mouseClick)
        return {FoundX: FindX , FoundY: FindY}
    } else {
        MsgBox label . "não encontrado.", "Aviso", 48
        Exit
    }
}

;Se a janela existe, ativa ela
ExistActivate(windowTitle) {
    If WinExist(windowTitle) {
        WinActivate
        Return true
    } Else {
        MsgBox "Janela " windowTitle " inativa", "Aviso", 48
        Exit
    }
}

;Se a janela esta ativa, ativa ela
ActiveActivate(windowTitle) {
    If WinActive(windowTitle) {
        WinActivate
        Return true
    } Else {
        MsgBox "Janela " windowTitle " inativa", "Aviso", 48
        Exit
    }
}

;Função para repetir gerador de numero aleatorio
NumAleatorio(numcasos) {
    loop numcasos {
        rand := Random(1, 9)
        Send rand . "{Sleep 40}"
    }
}

ItensC170:="|<ItensC170>*131$70.020000000000s04U0080+006E0E000U0800E779lkCC3nbx0YYd9198+GGI2GGYY4YUdx9E99+GEGG2Y4ZaYYd9198+GGHlVmQM3X0gt90000E0000000000D00000008"

;lança nota
lancar(TIPO, CST, CFOP, UNID) {
    CodOperacao:="|<CodOperacao>*139$48.00000000000000I0000000g0000000007D7CQQQQ9998YWYY98jcQUQY98c8YUYY9998YWYY6D78wQwM080000000800040000000M00U"
    Send "{PgUp}"
    ClickOnImage(CodOperacao, 420, 0, "L", "Codigo Operação")
    Click
    Sleep 80
    Send TIPO 
    Sleeper("{Tab}", 40, 2)
    Send CST 
    Sleeper("{Enter}", 40, 2)
    Send CFOP 
    Sleeper("{Enter}", 40, 2) 
    Send UNID 
    Sleeper("{Enter}", 40, 3)
    Send "0"
    Sleeper("{Enter}", 40, 4)
    Sleeper("0{Enter}", 80, 7)
    Sleeper("{Enter}", 40, 6)
    Send "0{Sleep 5}{Enter}"
    Sleep 80
    ;Falta retornar para a caixa quantidade de itens 
    Return
}

lancarReg(TIPO, CST, CFOP, UNID) {
    Send NumItem
    Sleep 40
    Sleeper("{Tab}", 40, 2)
    Send SubNomeItem
    Sleeper("{Tab}", 40, 2)
    Send NomeItem
    Sleep 40
    Sleeper("{Tab}", 80, 2)
    Sleep 80
    Send TIPO 
    Sleeper("{Tab}", 80, 2)
    Send CST 
    Sleeper("{Enter}", 80, 2)
    Send CFOP 
    Sleeper("{Enter}", 80, 2) 
    Send UNID 
    Sleeper("{Enter}", 80, 3)
    Send "0"
    Sleeper("{Enter}", 80, 2)
    Send Quantidade
    Sleeper("{Enter}", 80, 1)
    Send ValorProd
    Sleeper("{Enter}", 80, 1)
    Send DescontoI
    Sleeper("{Enter}", 80, 1)
    Send ALQ
    Sleeper("{Enter}", 80, 1)
    Send BASE
    Sleeper("{Enter}", 80, 1)
    Send icms "{Sleep 80}{Enter}"
    Sleeper("0{Sleep 40}{Enter}", 100, 3)
    Sleeper("{Enter}", 80, 6)
    Sleeper("0{Enter}", 80, 1)
    ClickOnImage(ItensC170, 515, 0, "L", "ItensC170")
    Return
}

lancarRegIsento(TIPO, CST, CFOP, UNID) {
    Send NumItem
    Sleep 40
    Sleeper("{Tab}", 40, 2)
    Send SubNomeItem
    Sleeper("{Tab}", 40, 2)
    Send NomeItem
    Sleep 40
    Sleeper("{Tab}", 80, 2)
    Sleep 80
    Send TIPO 
    Sleeper("{Tab}", 80, 2)
    Send CST 
    Sleeper("{Enter}", 80, 2)
    Send CFOP 
    Sleeper("{Enter}", 80, 2) 
    Send UNID 
    Sleeper("{Enter}", 80, 3)
    Send "0"
    Sleeper("{Enter}", 80, 2)
    Send Quantidade
    Sleeper("{Enter}", 80, 1)
    Send ValorProd
    Sleeper("{Enter}", 80, 1)
    Send DescontoI
    Sleeper("{Enter}", 80, 1)
    Sleeper("0{Enter}", 80, 6)
    Sleeper("{Enter}", 80, 6)
    Sleeper("0{Enter}", 80, 1)
    ClickOnImage(ItensC170, 515, 0, "L", "ItensC170")
    Return
}

;Substitui nota ;!s{Sleep 40}{Tab}{Enter}{Sleep 40}{Down}  
substituir(CST, CFOP) {
    CSTICMSC170:="|<CSTICMSC170>*145$49.000000003Vnwdl2C3948JYn8V0U4+UFY0UQ29E8nUE1V4c48A808WI2o16O8G/BOF1sw94wZ7U00000002"
    Send "{PgUp}"
    if ClickOnImage(CSTICMSC170, 420, 0, "L", "CST ICMS C170") {
        Send("{Sleep 40}0{Enter 2}0{Enter 10}0{Enter}0{Enter}0{Enter}0{Enter}+{Tab 16}" CST "{Enter 2}" CFOP "{Enter 7}")
    }
    Return
}

substituirExc(CST, CFOP) {
    CSTICMSC170:="|<CSTICMSC170>*145$49.000000003Vnwdl2C3948JYn8V0U4+UFY0UQ29E8nUE1V4c48A808WI2o16O8G/BOF1sw94wZ7U00000002"
    Send "{PgUp}"
    if ClickOnImage(CSTICMSC170, 420, 0, "L", "CST ICMS C170") {
        Send("{Sleep 40}0{Enter 2}0{Enter 13}0{Enter}0{Enter}0{Enter}+{Tab 18}" CST "{Enter 2}" CFOP "{Enter 10}")
    }
    Return
}

Sleeper(key, sec, times) {
    loop times {
        Send key
        Sleep sec
    }
}

;Cria uma empresa, a partir da tela pesquisar dados cadastrais que mostra a lista de empresas
CriarEmpresa(NOME, CNPJ, IE, CODM, LOGR, NUM, COMPL, BAIR) {
    if ExistActivate("Pesquisar Dados Cadastrais") {
        Send "{Insert}"
        if WinWaitActive("Participante", , 2) {
            Send "{Sleep 40}111"
            NumAleatorio(8)
            Sleeper("{Tab}", 200, 1)
            Send NOME 
            Sleeper("{Tab}", 200, 1)
            Send CNPJ
            Sleeper("{Tab}", 200, 2)
            Send IE
            Sleeper("{Tab}", 200, 3)
            Send CODM  
            Sleeper("{Tab}", 200, 3)
            Send LOGR 
            Sleeper("{Tab}", 200, 1)
            Send NUM 
            Sleeper("{Tab}", 200, 1)
            Send COMPL
            Sleeper("{Tab}", 200, 1)
            Send BAIR . "{Enter}"
        } 
    }
}
    
;Cria um item, a partir da tela pesquisar dados cadastrais que mostra a lista de itens
CriarItem(NOME, UNIDADE, TIPO) {
    if ExistActivate("Pesquisar Dados Cadastrais") {
        Send "{Insert}{Sleep 40}"
        if ActiveActivate("Item/Produtos") {
            Send "{Sleep 40}000"
            NumAleatorio(8)
            Send("{Enter}" NOME "{Sleep 40}{Tab 2}" UNIDADE "{Sleep 40}{Enter 4}" TIPO "{Sleep 40}{Enter}")
        } 
    }
}