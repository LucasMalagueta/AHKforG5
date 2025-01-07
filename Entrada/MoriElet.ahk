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
Global FlagEstado := ""
Global filePath := ""
Global NumItem := ""
Global NumNFE := "000"
Global UNIDADE := "UNI"
Global tipoItem := "Mercadoria"
Global SleepTime := 100
Global FlagPrint := 0

nextPos := 0

NFEe:="|<NFEe>*145$17.WT1YU390xHmOY7n88aEH4US"
Lupa:="|<Lupa>*210$18.0000z031k40M80A8Q4Ey2Fr2FX2EQ2Ey29r49X4A0860E31U0y0000U"
C195:="|<C195>*162$35.000000Aw8wwUH8l90V42aO12814rX4E2DVa8U433AFa8YaMVsFtsUU00011U0004000000U|<C195-2>*160$35.0000004s8swUH8l90V42W+12814rU4E2DU28U4214Fa8YUEVsFlsUU00010U0004000000U"


;Definir qual XML esta sendo trabalhada
    NumpadAdd:: {
        PgwFEl := UIA.ElementFromHandle("Lançamentos Fiscais | ahk_exe PgwF.exe")
        ;Tenta pesquisa rapida antes das demais

        Global NumO := (PgwFEl.WaitElementFromPath("IY4zt").Dump())
        REGEX := "Value:\s`"([^`"]*)"
        Global Num := RegExFindValue(NumO, REGEX)
        REGEX := "([^\s]*)"
        Global Num := RegExFindValue(Num, REGEX)

        global ItemAtual := 0

        CFOPO := (PgwFEl.WaitElementFromPath("IY4vt").Dump())
        REGEX := "Value:\s`"([^`"]*)"
        Global CFOPV := RegExFindValue(CFOPO, REGEX)
        Global CFOPV := StrReplace(CFOPV, ".", "")

        path := A_ScriptDir "\XMLs\" Num ".xml"
        If !FileExist(path) {
            ;Abre Explorador de arquivos e pega o caminho do arquivo selecionado
            SelectedFile := FileSelect(1, "", "Selecione um XML", "All Files (*.*)|*.*")
            Global filePath := SelectedFile

            if SelectedFile = ""{
                MsgBox "Nenhum arquivo foi selecionado.", "Aviso", 48
                Return
            } else{

                Global NumNFE := Num
                ;MsgBox "Caminho Atualizado, N° NFE da nota atual: " NumNFE, "Sucesso", "64 T0.5"
                Global FlagPrint := 0
            }
        } else {
            Global NumNFE := Num
            Global filePath := path
        }

        ItensO := PgwFEl.ElementFromPath("IYYr4/").Dump()
        REGEX := "Value:\s`"([^`"]*)"
        Global ItensV := RegExFindValue(ItensO, REGEX)
        REGEX := "([^\s]*)"
        Global UltimoItem := RegExFindValue(ItensV, REGEX)

        ;Abrir o XML para definir Quantos itens tem a nota atual
        xml := ComObject("MSXML2.DOMDocument.3.0") 
        xml.async := False
        xml.load(filePath)
        

        ;Começa a correção

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

        if(CFOPV == 1403 or CFOPV == 2403){
            Loop {
                CorrigirItemST()
                if (UltimoItem == ItemAtual){
                    break
                }
            } 
        }else if(CFOPV == 1102 or CFOPV == 2102){
            Loop {
                CorrigirItemMercadoria()
                if (UltimoItem == ItemAtual){
                    break
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

    CorrigirItemST() {
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

        GetItem := GetInfoItens()

        Sleep 70
    
        ;Entrar nos impostos
        PgwFEl.WaitElementFromPath("Y4ur").ControlClick()
        Send "^{Enter}"
        Sleep 100
    
        WinWaitActive "Impostos"
        Sleep 70
    
        Sleeper("{Tab}", 80, 1)
        Send "060"
        Sleep 70

        Sleeper("{Tab}", 80, 1)
        Sleep 70

        PgwFEl := UIA.ElementFromHandle("Impostos")

        PgwFEl.WaitElementFromPath("Yy4z").ControlClick()
        Sleeper("{Tab}", 80, 1)
        Sleep 70
        Sleeper("{BS}", 80, 1)

        if(GetItem.BC == 0){
            
            ;Pega o valor do campo para substituir o 0
            Base := PgwFEl.WaitElementFromPath("Yy4qr").Dump()
            REGEX := "Value:\s`"([^`"]*)"
            GetItem.BC := RegExFindValue(Base, REGEX)

            PgwFEl.WaitElementFromPath("Yy4z").Click()
            ;Se for Isento apaga Parte de ST 
            Sleeper("{Tab}{BS}", 80, 5)
     
        }else{
            PgwFEl.WaitElementFromPath("Yy2").Click()
            Sleep 40
            PgwFEl.WaitElementFromPath("Yy4rr").ControlClick()

        }
    
    
        PgwFEl.WaitElementFromPath("Yt4y").ControlClick()

        Sleeper("{Tab}", 80, 1)
        Send GetItem.BC
        Sleep 70

        Sleeper("{Tab}", 80, 2) 
        Sleep 50
    
        Send "!o!o"
        Sleep 100
        if(WinExist("Erros")){
            Send "!s"
            Sleep 120
        }
        PgwFEl := UIA.ElementFromHandle("Itens da NF")
        Sleep 150
        PgwFEl.WaitElementFromPath("Y0").Click()
        Sleep 200
        if(WinExist("Erros")){
            Send "!s"
            Sleep 120
        }
        global ItemAtual += 1
        global Flag := 0
    }

    CorrigirItemMercadoria() {
        Sleep 200
        PgwFEl := UIA.ElementFromHandle("Itens da NF ahk_exe PgwF.exe")
        Sleep 70
    
        ;Clica na proxima nota
        if(Flag != 1)
            PgwFEl.WaitElementFromPath("Y/0r").Click()

        Sleep 100

        ;Pega o numero do proximo item
        NumItemO := PgwFEl.WaitElementFromPath("Yr4s").Dump()
        REGEX := "Value:\s`"([^`"]*)"
        Global NumItem := RegExFindValue(NumItemO, REGEX)

        GetItem := GetInfoItens()

        Sleep 70
    
        ;Entrar nos impostos
        PgwFEl.WaitElementFromPath("Y4ur").ControlClick()
        Send "^{Enter}"
        Sleep 70
    
        WinWaitActive "Impostos"
        Sleep 70
    
    
        Sleeper("{Tab}", 80, 4)
        Send GetItem.BS
        Sleep 70

        Sleeper("{Tab}", 80, 1)
        Send GetItem.AL
        Sleep 70
        
        Sleeper("{Tab}", 80, 1)
        Send GetItem.IC
        Sleep 70

        PgwFEl := UIA.ElementFromHandle("Impostos ahk_exe PgwF.exe")
    
        PgwFEl.WaitElementFromPath("Yt4y").ControlClick()

        Sleeper("{Tab}", 80, 1)
        BasePis := GetItem.BS - GetItem.IC
        Send BasePis
        Sleep 70

        Sleeper("{Tab}", 80, 2) 
        Sleep 50
    
        Send "!o!o"
        Sleep 100
        if(WinExist("Erros")){
            Send "!s"
            Sleep 120
        }
        PgwFEl := UIA.ElementFromHandle("Itens da NF")
        Sleep 150
        PgwFEl.WaitElementFromPath("Y0").Click()
        Sleep 200
        if(WinExist("Erros")){
            Send "!s"
            Sleep 120
        }
        global ItemAtual += 1
        global Flag := 0
    }

;Funçoes C170
    ;Extrai todos os dados necessários para lançar um item
        GetInfoItens() {
            ;Atribui o XML a um Objeto 
            xml := ComObject("MSXML2.DOMDocument.3.0") 
            xml.async := False
            xml.load(filePath)
            
            ;Acha CST
            CST := xml.SelectSingleNode("//det[" NumItem - 1 "]/imposto/ICMS//CST")
            if (CST == "") {
                CST := xml.SelectSingleNode("//det[" NumItem - 1 "]/imposto/ICMS//CSOSN").Text
            } else {
                CST := CST.Text
            }

            BCS := xml.SelectSingleNode("//det[" NumItem - 1 "]/imposto/ICMS/ICMS10/vBC")
            if (BCS != "") {
                BCS := BCS.Text
            } else {
                BCS := 0
            }

            ALQ := xml.SelectSingleNode("//det[" NumItem - 1 "]/imposto/ICMS/ICMS10/pICMS")
            if (ALQ != "") {
                ALQ := ALQ.Text
            } else {
                ALQ := 0
            }

            ICMS := xml.SelectSingleNode("//det[" NumItem - 1 "]/imposto/ICMS/ICMS10/vICMS")
            if (ICMS != "") {
                ICMS := ICMS.Text
            } else {
                ICMS := 0
            }

            vBCST := xml.SelectSingleNode("//det[" NumItem - 1 "]/imposto/ICMS/ICMS10/vBCST")
            if (vBCST != "") {
                vBCST := vBCST.Text
            } else {
                vBCST := 0
            }

            vICMSST := xml.SelectSingleNode("//det[" NumItem - 1 "]/imposto/ICMS/ICMS10/ICMSST")
            if (vICMSST != "") {
                vICMSST := vICMSST.Text
            } else {
                vICMSST := 0
            }

            BCPisCof := xml.SelectSingleNode("//det[" NumItem - 1 "]/imposto/PIS//vBC")
            if (BCPisCof != "") {
                BCPisCof := BCPisCof.Text
            } else {
                BCPisCof := 0
            }



            Return {CS: CST,         AL: ALQ,     IC: ICMS,    
                    BC: BCS,         BCST: vBCST,
                    ICST: vICMSST,   AL: ALQ,     BCPC: BCPisCof}
        }


    ;Decidir o tipo de lançamento
        Conversor(CST, CFOP) {
            Switch CFOP {
                ;Converte item 1403 2403 ;<ICMS60> <ICMS070> 
                case 5401, 5403, 5405, 5655:
                    Return {CS: "060", CF: 1403}

                case 6401, 6403, 6404, 6405:
                    Return {CS: "060", CF: 2403}

                ;Converte item 1102 2102
                case 5101, 5102, 5103, 5104:
                    Switch CST {
                        ;Converte 000
                        case 00:
                            Return {CS: "000", CF: 1102}

                        ;Converte 020
                        case 20, 02:
                            Return {CS: "020", CF: 1102}

                        ;Converte 040
                        default:
                            Return {CS: "040", CF: 1102}
                    }
                Return

                case 6101, 6102, 6105, 6106, 6108:
                    Switch CST {
                        case 00:
                            Return {CS: "000", CF: 2102}

                        case 20, 02:
                            Return {CS: "020", CF: 2102}

                        default:
                            Return {CS: "040", CF: 2102}
                    }
                Return


                default:
                    ;Return {CS: "090", CF: 0, FL: 0, TP: "ENTRADA ESTADUAL"}
                    MsgBox "CFOP do item não cadastrado no codigo`nCFOP: " CFOP " ITEM: " NumItem, "Aviso", 48
                Exit
                }
            Return

        }

        NumpadSub::{
            PgwFEl := UIA.ElementFromHandle("Impostos ahk_exe PgwF.exe")
            PgwFEl.WaitElementFromPath("Yy2").Click()

        }