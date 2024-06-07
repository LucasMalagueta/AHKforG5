;Funçoes
;Clica na imagem a qual foi passado o parametro e caso nao encontre avisa
ClickOnImage(image, xOffset, yOffset, mouseClick, label, ByRef X, ByRef Y) {
    If (ok := FindText(X, Y, 572-150000, 549-150000, 572+150000, 549+150000, 0, 0, image)) {
        FindText().Click(X + xOffset, Y + yOffset, mouseClick)
        Return true
    } Else {
        MsgBox, 48, Aviso, %label% não encontrado.,1
        Exit
    }
}

;Se a janela existe, ativa ela
ExistActivate(windowTitle) {
    If WinExist(windowTitle) {
        WinActivate
        Return true
    } Else {
        MsgBox, 48, Aviso, Janela "%windowTitle%" inativa.,2
        Exit
    }
}

;Se a janela esta ativa, ativa ela
ActiveActivate(windowTitle) {
    If WinActive(windowTitle) {
        WinActivate
        Return true
    } Else {
        MsgBox, 48, Aviso, Janela "%windowTitle%" inativa.,2
        Exit
    }
}

;Função para repetir gerador de numero aleatorio
NumAleatorio(numcasos) {
    loop %numcasos% {
        Random, rand, 1, 9
        Send,%rand%
    }
}

;lança nota
lancar(TIPO, CST, CFOP, UNID) {
    CodOperacao:="|<CodOperacao>*139$48.00000000000000I0000000g0000000007D7CQQQQ9998YWYY98jcQUQY98c8YUYY9998YWYY6D78wQwM080000000800040000000M00U"
    Send,{PgUp}
    if ClickOnImage(CodOperacao, 420, 0, "L", "Codigo Operação", X, Y) {
        Send,%TIPO%{Sleep 20}{Tab 2}%CST%{Enter 2}%CFOP%{Enter 2}%UNID%{Enter 3}0{Enter 4}0{Enter}0{Enter}0{Enter}0{Enter}0{Enter}0{Enter}0{Enter 7}0{Enter}+{Tab 16}
    }
    Return
}

;Substitui nota ;!s{Sleep 20}{Tab}{Enter}{Sleep 20}{Down}  
substituir(CST, CFOP) {
    CSTICMSC170:="|<CSTICMSC170>*145$49.000000003Vnwdl2C3948JYn8V0U4+UFY0UQ29E8nUE1V4c48A808WI2o16O8G/BOF1sw94wZ7U00000002"
    Send,{PgUp}
    if ClickOnImage(CSTICMSC170, 420, 0, "L", "CST ICMS C170", X, Y) {
        Send,{Sleep 20}0{Enter 2}0{Enter 10}0{Enter}0{Enter}0{Enter}0{Enter}+{Tab 16}%CST%{Enter 2}%CFOP%{Enter 7}
    }
    Return
}

substituirExc(CST, CFOP) {
    CSTICMSC170:="|<CSTICMSC170>*145$49.000000003Vnwdl2C3948JYn8V0U4+UFY0UQ29E8nUE1V4c48A808WI2o16O8G/BOF1sw94wZ7U00000002"
    Send,{PgUp}
    if ClickOnImage(CSTICMSC170, 420, 0, "L", "CST ICMS C170", X, Y) {
        Send,{Sleep 20}0{Enter 2}0{Enter 13}0{Enter}0{Enter}0{Enter}+{Tab 18}%CST%{Enter 2}%CFOP%{Enter 10}
    }
    Return
}

;Cria uma empresa, a partir da tela pesquisar dados cadastrais que mostra a lista de empresas
CriarEmpresa(NOME, CNPJ, IE, CODM, LOGR, NUM, COMPL, BAIR) {
    if ExistActivate("Pesquisar Dados Cadastrais") {
        Send,{Insert}{Sleep 40}
        if ActiveActivate("Participante") {
            Send,{Sleep 20}111
            NumAleatorio(8)
            Send,{Sleep 20}{Enter}{Sleep 20}%NOME%{Sleep 20}{Enter}{Sleep 20}%CNPJ%{Sleep 20}{Tab 2}{Sleep 20}%IE%{Sleep 20}{Tab 3}{Sleep 20}%CODM%{Sleep 40}{Tab 3}{Sleep 20}%LOGR%{Sleep 20}{Enter}{Sleep 20}%NUM%{Sleep 20}{Enter}{Sleep 20}%COMPL%{Sleep 20}{Enter}{Sleep 20}%BAIR%{Enter}
        } 
    }
}
    
;Cria um item, a partir da tela pesquisar dados cadastrais que mostra a lista de itens
CriarItem(NOME, UNIDADE, TIPO) {
    if ExistActivate("Pesquisar Dados Cadastrais") {
        Send,{Insert}{Sleep 40}
        if ActiveActivate("Item/Produtos") {
            Send,{Sleep 20}000
            NumAleatorio(8)
            Send,{Enter}%NOME%{Sleep 20}{Tab 2}%UNIDADE%{Sleep 20}{Enter 4}%TIPO%{Sleep 20}{Enter}
        } 
    }
}
