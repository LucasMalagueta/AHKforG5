#SingleInstance, force
#Include <FindText>
#Include <matFunctions>
SetTitleMatchMode, 2
Menu, Tray, Icon, Shell32.dll, 44

Turbo:="|<Turbo>*120$27.y020100E0802012/SC8FG+92+FF8FG+92OFF8BHlo"
ProximaNFE:="|<ProximaNFE>*166$5.Vn80E|<>*139$12.zkzwztzUU|<>*221$28.00001zzzzbzzzyTzzztzzzzbxzzyTrzztzTzzbxzzyTrzztzTzzbxztyTryDtzTXzbxszyTqDztz3zzbwzzyTzzztzzzzbzzzyTzzztzzzzU0000U"
cc:="|<c/c>*120$20.0003kHl252E1E40Y1090E4E41412V2D8D0002"
CincoUm:="|<5102>*162$27.w0XXo0Qa2U0YELU4W240YEUU4W84UYm74SQzU"
CincoQuatro:="|<5405>*159$26.w0nXs0RAW0BF8w6IHl1z44E1F14UIkS84su"
delet:="|<delet>*149$20.yE02000U008LXW554VFF8IIG554VSC0400003zzz0000003zzzU008"

delete(numcasos) {
    loop %numcasos% {
        Send,{bs}{enter}
    }

    If WinActive("Lançamentos Fiscais") {

    } else {
        Return
    }
}


NumpadAdd::
    InputBox, NumCasas, Repetição, Quantas vezes irá rodar?, , 300, 130
    IfEqual, ErrorLevel, 1, Return

    loop %NumCasas% {
        flag := 0
        If WinActive("Lançamentos Fiscais") {

            } else {
                Return
            }

            if ClickOnImage(cc, 15, 18, "L", "C/C", X, Y) {
                send,{BS}1
                if (ok:=FindText(X, Y, 363-150000, 350-150000, 363+150000, 350+150000, 0, 0, CincoUm)) {
                    ClickOnImage(Turbo, 9, 16, "L", "Turbo", X, Y)
                    Send,1{sleep 2}{Enter 6}{Sleep 10}{BS}{Sleep 2}{Enter}{Sleep 2}{BS}{Sleep 2}{Enter 7}{Sleep 2}
                    flag := 1
                    }
                if (ok:=FindText(X, Y, 364-150000, 350-150000, 364+150000, 350+150000, 0, 0, CincoQuatro)) {
                    ClickOnImage(Turbo, 9, 16, "L", "Turbo", X, Y)
                    Sleep 15
                    Send,113{sleep 2}{Enter 6}{Sleep 10}{bs}{Sleep 2}{Enter}{Sleep 2}{bs}{Sleep 2}{Enter 7}{Sleep 2}
                    flag := 1
                    }
                    
                if (flag == 1) {
                        
                    if (ClickOnImage(ProximaNFE, 0, 0, "L", "Seta Direita", X, Y) and ActiveActivate("Lançamentos Fiscais")) {
                        flag := 0
                        val := 1 
                        while (val == 1) {
                            If (ok := FindText(X, Y, 572-150000, 549-150000, 572+150000, 549+150000, 0, 0, Turbo)) {
                                    val := 0
                                }
                            }
                    }
                        
                    } else {
                        MsgBox, 48, Aviso, 5102 e 5405 não encontrados.,1
                        Return
                    }
                    
                }
            }        
Return
