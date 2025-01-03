#SingleInstance Force
#Include <UIA>
#Include <matFunctionsV2>
#Include <FindTextV2>
#Include <AccV2>

TraySetIcon("C:\Users\" A_Username "\Documents\AutoHotkey\Lib\pngwing.com.ico")

ACHAR := "|<achar>*119$16.100400E0Tsu4EMFDV564ILlT0007s8"

NumpadSub:: {
    ClickOnImage(ACHAR, 0, 0, "L", "achar")
}


NumpadAdd:: {
    if(WinActive("Lançamentos Fiscais | ahk_exe PgwF.exe")){
        flag := 0

        PgwFEl := UIA.ElementFromHandle("Lançamentos Fiscais | ahk_exe PgwF.exe")

        TURBOo := (PgwFEl.WaitElementFromPath("IY4vt").Dump())
        REGEX := "Value:\s`"([^`"]*)"
        TURBOv := RegExFindValue(TURBOo, REGEX)

        IPIo := (PgwFEl.WaitElementFromPath("IY4zs").Dump())

        if (RegExMatch(IPIo, REGEX, &match)) {
            
            IPIv := RegExFindValue(IPIo, REGEX)
        } else {
            IPIv := 0
        }

        AVISTAo := (PgwFEl.WaitElementFromPath("IY4ws").Dump())

        if (RegExMatch(AVISTAo, REGEX, &match)) {
            
            AVISTAv := RegExFindValue(AVISTAo, REGEX)
        } else {
            AVISTAv := 0
        }

        APRAZOo := (PgwFEl.WaitElementFromPath("IY4rs").Dump())

        if (RegExMatch(APRAZOo, REGEX, &match)) {
            
            APRAZOv := RegExFindValue(APRAZOo, REGEX)
        } else {
            APRAZOv := 0
        }

        TURBOo := (PgwFEl.WaitElementFromPath("IY4vt").Dump())
        TURBOv := RegExFindValue(TURBOo, REGEX)
        
        Sleep 130

        ;reconheçe o turbo
        if (TURBOv == 1.303){
            PgwFEl.WaitElementFromPath("IY4tt").ControlClick()
            Sleeper("{BS}", 10, 3)
            Send 3
            sleep 80
            Send "{Enter 2}"
            if(IPIv != 0){
                Send IPIv
            }
            Send "{Enter 4}{Sleep 5}"
            Sleep 80
            PgwFEl.WaitElementFromPath("IY4wt").ControlClick()
            Sleeper("{BS}", 10, 2)
            if (AVISTAv != 0){
                Send 1
                Sleep 80
                PgwFEl.WaitElementFromPath("IY4ws").ControlClick()
                Send AVISTAv
                Sleep 80
                Send "{Enter 3}"
                Send "{BS}{Enter}{BS}"
                Send "{Enter 6}"
            }else if (APRAZOv != 0){
                Send 2
                Sleep 80
                PgwFEl.WaitElementFromPath("IY4rs").ControlClick()
                Send APRAZOv
                Sleep 80
                Send "{Enter 2}"
                Send "{BS}{Enter}{BS}"
                Sleep 40
                Send "{Enter 6}"
            }
            Sleep 80
            
        }
        
        if (TURBOv == 1.102 ){
            PgwFEl.WaitElementFromPath("IY4tt").ControlClick()
            Sleeper("{BS}", 10, 3)
            Send 3
            sleep 100
            Send "{Enter 2}"
            if(IPIv != 0){
                Send IPIv
            }
            Send "{Enter 4}{Sleep 5}"
            Sleep 80
            PgwFEl.WaitElementFromPath("IY4wt").ControlClick()
            Sleeper("{BS}", 10, 2)
            if (AVISTAv != 0){
                Send 1
                Sleep 80
                PgwFEl.WaitElementFromPath("IY4ws").ControlClick()
                Send AVISTAv
                Sleep 80
                Send "{Enter 3}"
                Send "{BS}{Enter}{BS}"
                Send "{Enter 6}"
                
            }else if (APRAZOv != 0){
                Send 2
                Sleep 80
                PgwFEl.WaitElementFromPath("IY4rs").ControlClick()
                Send APRAZOv
                Sleep 80
                Send "{Enter 2}"
                Send "{BS}{Enter}{BS}"
                Send "{Enter 6}"
            }
            Sleep 80
            
        }

        if (TURBOv == 1.101 ){
            PgwFEl.WaitElementFromPath("IY4tt").ControlClick()
            Sleeper("{BS}", 10, 3)
            Send 3
            sleep 100
            Send "{Enter 2}"
            if(IPIv  != 0){
                Send IPIv
            }
            Send "{Enter 4}{Sleep 5}"
            Sleep 80
            PgwFEl.WaitElementFromPath("IY4wt").ControlClick()
            Sleeper("{BS}", 10, 2)
            if (AVISTAv  != 0){
                Send 1
                Sleep 80
                PgwFEl.WaitElementFromPath("IY4ws").ControlClick()
                Send AVISTAv
                Sleep 80
                Send "{Enter 3}"
                Send "{BS}{Enter}{BS}"
                Send "{Enter 6}"
            }else if (APRAZOv  != 0){
                Send 2
                Sleep 80
                PgwFEl.WaitElementFromPath("IY4rs").ControlClick()
                Send APRAZOv
                Sleep 80
                Send "{Enter 2}"
                Send "{BS}{Enter}{BS}"
                Send "{Enter 6}"
            }
            Sleep 80
            
        }

        if (TURBOv == 1.403 ){
            PgwFEl.WaitElementFromPath("IY4tt").ControlClick()
            Sleeper("{BS}", 10, 3)
            Send 113
            sleep 100
            Send "{Enter 2}"

            BASEICMSFONTEo := PgwFEl.ElementFromPath("IY4qr").Dump()
            REGEX := "Value:\s`"([^`"]*)"
            if (RegExMatch(BASEICMSFONTEo, REGEX, &match)) {
                BASEICMSFONTEv := RegExFindValue(BASEICMSFONTEo, REGEX)
            } else {
                BASEICMSFONTEv := 0
            }

            ICMSFONTEo := PgwFEl.ElementFromPath("IY4vs").Dump()
            REGEX := "Value:\s`"([^`"]*)"
            if (RegExMatch(ICMSFONTEo, REGEX, &match)) {
                ICMSFONTEv := RegExFindValue(ICMSFONTEo, REGEX)
            } else {
                ICMSFONTEv := 0
            }

            if(IPIv != 0){
                Send IPIv
                Sleep 40
            }
            Send "{Tab}"

            if(ICMSFONTEv != 0){
                Send ICMSFONTEv
                Sleep 40
            }
            Send "{Tab}"

            if(BASEICMSFONTEv != 0){
                Send BASEICMSFONTEv
                Sleep 40   
            }
            Send "{Tab}"

            Send "{Enter}{Sleep 5}"
            Sleep 80
            PgwFEl.WaitElementFromPath("IY4wt").ControlClick()
            Sleeper("{BS}", 10, 2)
            if (AVISTAv  != 0){
                Send 1
                Sleep 80
                PgwFEl.WaitElementFromPath("IY4ws").ControlClick()
                Send AVISTAv
                Sleep 80
                Send "{Enter 3}"
                Send "{BS}{Enter}{BS}"
                Send "{Enter 6}"
            }else if (APRAZOv  != 0){
                Send 2
                Sleep 80
                PgwFEl.WaitElementFromPath("IY4rs").ControlClick()
                Send APRAZOv
                Sleep 80
                Send "{Enter 2}"
                Send "{BS}{Enter}{BS}"
                Send "{Enter 6}"
            }
            Sleep 80
            
        }

        if (TURBOv == 1.401 ){
            PgwFEl.WaitElementFromPath("IY4tt").ControlClick()
            Sleeper("{BS}", 10, 3)
            Send 113
            sleep 100
            Send "{Enter 2}"
            if(IPIv  != 0){
                Send IPIv
            }
            Send "{Enter 4}{Sleep 5}"
            Sleep 80
            PgwFEl.WaitElementFromPath("IY4wt").ControlClick()
            Sleeper("{BS}", 10, 2)
            if (AVISTAv  != 0){
                Send 1
                Sleep 80
                PgwFEl.WaitElementFromPath("IY4ws").ControlClick()
                Send AVISTAv
                Sleep 80
                Send "{Enter 3}"
                Send "{BS}{Enter}{BS}"
                Send "{Enter 6}"
            }else if (APRAZOv  != 0){
                Send 2
                Sleep 80
                PgwFEl.WaitElementFromPath("IY4rs").ControlClick()
                Send APRAZOv
                Sleep 80
                Send "{Enter 2}"
                Send "{BS}{Enter}{BS}"
                Send "{Enter 6}"
            }
            Sleep 80
            
        }

        if (TURBOv == 1.556){
            PgwFEl.WaitElementFromPath("IY4tt").ControlClick()
            Sleeper("{BS}", 10, 3)
            Send 3
            sleep 100
            Send "{Enter 2}"
            if(IPIv  != 0){
                Send IPIv
            }
            Send "{Enter 4}{Sleep 5}"
            Sleep 80
            PgwFEl.WaitElementFromPath("IY4wt").ControlClick()
            Sleeper("{BS}", 10, 2)
            if (AVISTAv  != 0){
                Send 3
                Sleep 80
                PgwFEl.WaitElementFromPath("IY4ws").ControlClick()
                Send AVISTAv
                Sleep 80
                Send "{Enter 3}"
                Send "{BS}{Enter}{BS}"
                Send "{Enter 6}"
            }else if (APRAZOv  != 0){
                Send 4
                Sleep 80
                PgwFEl.WaitElementFromPath("IY4rs").ControlClick()
                Send APRAZOv
                Sleep 80
                Send "{Enter 2}"
                Send "{BS}{Enter}{BS}"
                Send "{Enter 6}"
            }
            Sleep 80
        }

        if (TURBOv == 1.910){
            PgwFEl.WaitElementFromPath("IY4tt").ControlClick()
            Sleeper("{BS}", 10, 3)
            Send 3
            sleep 100
            Send "{Enter 2}"
            if(IPIv  != 0){
                Send IPIv
            }
            Send "{Enter 4}{Sleep 5}"
            Sleep 80
            PgwFEl.WaitElementFromPath("IY4wt").ControlClick()
            Sleeper("{BS}", 10, 2)
            if (AVISTAv  != 0){
                Send 1
                Sleep 80
                PgwFEl.WaitElementFromPath("IY4ws").ControlClick()
                Send AVISTAv
                Sleep 80
                Send "{Enter 3}"
                Send "{BS}{Enter}{BS}"
                Send "{Enter 6}"
            }else if (APRAZOv  != 0){
                Send 2
                Sleep 80
                PgwFEl.WaitElementFromPath("IY4rs").ControlClick()
                Send APRAZOv
                Sleep 80
                Send "{Enter 2}"
                Send "{BS}{Enter}{BS}"
                Send "{Enter 6}"
            }
            Sleep 80
        }

        if (TURBOv == 1.929){
            PgwFEl.WaitElementFromPath("IY4tt").ControlClick()
            Sleeper("{BS}", 10, 3)
            Send 3
            sleep 100
            Send "{Enter 2}"
            if(IPIv  != 0){
                Send IPIv
            }
            Send "{Enter 4}{Sleep 5}"
            Sleep 80
            PgwFEl.WaitElementFromPath("IY4wt").ControlClick()
            Sleeper("{BS}", 10, 2)
            Sleep 80
            PgwFEl.WaitElementFromPath("IY4ws").ControlClick()
            Sleep 80
            Send "{Enter 3}"
            Send "{BS}{Enter}{BS}"
            Send "{Enter 6}"
            Sleep 80  
        }


        if (TURBOv == 1.949){
            PgwFEl.WaitElementFromPath("IY4tt").ControlClick()
            Sleeper("{BS}", 10, 3)
            Send 3
            sleep 100
            Send "{Enter 2}"
            if(IPIv  != 0){
                Send IPIv
            }
            Send "{Enter 4}{Sleep 5}"
            Sleep 80
            PgwFEl.WaitElementFromPath("IY4wt").ControlClick()
            Sleeper("{BS}", 10, 2)
            Sleep 80
            PgwFEl.WaitElementFromPath("IY4ws").ControlClick()
            Sleep 80
            Send "{Enter 3}"
            Send "{BS}{Enter}{BS}"
            Send "{Enter 6}"
            Sleep 80  
        }
    }   
}