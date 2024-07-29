AmT(Actions*){
	static Ptr:=A_PtrSize?"UPtr":"UInt",PtrP:=Ptr "*",MyFunc
	static x32:="5589E557565383EC348B7D388B47048945CC8B47088945C88B470C8945EC8B47108945E48B45EC8945D43B45E47D068B45E48945D431C03B453C0F8D910000008B1C878B4C8704C745D000000000C745D800000000895DF08B5C8708894DE08B4DF0895DC4894DE8894DDC8B75C43975D87D568B75DC03752C31C98975C03B4DE07D2F8B75D08B5DC001CE803C0B3175118B55F08B5D3089349389D343895DF0EB0D8B55E88B5D34893493428955E841EBCC8B4DE085C9790231C98B5D20014DDCFF45D8015DD0EBA283C007E966FFFFFF8B45088B5D2040C1E0078945E085DB790231DB8D049D00000000C745E80000000031FF8945DCC745F0000000008B45E83B45247D4A8B45288B55F031C903551401F88945D83B4D207D280FB642026BF0260FB642016BC04B01F00FB6326BF60F01F03B45E08B45D80F9204084183C204EBD38B4DDC01DF014DF0FF45E8EBAE8B45202B45CCC745DC000000008945D88B55188B452403550CC745F0000000002B45C88955CC8945D08B451C034510C1E0108945E031C08B4DD0394DF00F8F9200000031C93B4DD87F748B7DDC8D14398955E831D28B75E80375283B55D47D273B55EC7D0D8B5D308B3C9301F7803F0175493B55E47D0D8B5D348B3C9301F7803F00753742EBD48B7DCC8D50018D340F8B7D400B75E08934873B55447D358B5DE831C0035D283B45EC7D0E8B7D308B34874001DEC60600EBED89D041EB878B4D20FF45F08145E000000100014DDCE964FFFFFF89D083C4345B5E5F5DC2400090"
	static x64:="4157415641554154555756534883EC28488B8424D00000008B5804895424788B780C894C2470895C24108B5808897C2408895C24148B581039DF89DF895C240C0F4D7C240831D2897C2418399424D80000000F8E8E000000448B14904531E431DB8B7C90088B6C90044489D6897C241C4489D73B5C241C7D644C63EE4C03AC24B80000004531DB4439DD7E3643807C1D0031478D341C7514488B8C24C00000004D63FA41FFC2468934B9EB11488B8C24C80000004C63FFFFC7468934B949FFC3EBC585ED41BB00000000440F49DDFFC34403A424A00000004401DEEB964883C207E965FFFFFF8B44247041BB000000008D4801C1E10783BC24A000000000440F499C24A000000031ED31F631FF468D2C9D000000003BAC24A80000007D554863DE48039C24B00000004863C74531D24C01C844399424A00000007E2D0FB65002446BE2260FB650016BD24B4401E2440FB620456BE40F4401E239CA420F92041349FFC24883C004EBC94401EF4401DEFFC5EBA244038424980000004531DB31C04531D28BBC24A00000008BAC24A80000008B9424900000002B7C241041C1E0102B6C2414035424784139EA0F8FDB0000004531C94139F90F8FB6000000438D1C1931C9394C24184189CC7E52394C24087E204C8BB424C00000004C8BBC24B0000000418B348E01DE4863F641803C37017579443964240C7E204C8BB424C80000004C8BBC24B0000000418B348E01DE4863F641803C3700755248FFC1EBA5428D340A4C8BB424E00000008D48014409C63B8C24E8000000418934867D4D31C0394424087E234C8BBC24C00000004C8BB424B0000000418B348748FFC001DE4863F641C6043600EBD74863C141FFC1E941FFFFFF41FFC24181C00000010044039C24A0000000E91EFFFFFF89C84883C4285B5E5F5D415C415D415E415FC3909090"
	;~ Do Not Remove This Line
	BCH:=A_BatchLines,Mode:=A_TitleMatchMode,CoordMode:=A_CoordModeMouse
	SetTitleMatchMode,2
	Setbatchlines,-1
	CoordMode,Mouse,Screen
	for a,b in Actions{
		Bits:=b.Bits
		for c,d in StrSplit("0123456789+/ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz")
			i:=c-1,Bits:=RegExReplace(Bits,"\Q" d "\E",(i>>5&1)(i>>4&1)(i>>3&1)(i>>2&1)(i>>1&1)(i&1))
		Bits:=RegExReplace(SubStr(Bits,1,InStr(s,"1",0,0)-1),"[^01]+"),Info:=[b.W,b.H,b.Threshold,b.Ones,b.Zeros,b.Match+0?b.Match:"100"],All:=[]
		if(b.Type="Window"){
			End:=(Start:=A_TickCount)+(b.WindowWait*1000)
			while(A_TickCount<End){
				if(WinExist(b.Area))
					Continue,2
				Sleep,100
			}Error:="Unable to find Window " """" b.Area """"
			Goto,PA_Exit
		}End:=(Start:=A_TickCount)+(b.WindowWait*1000)
		while(A_TickCount<End){
			if(WinExist(b.Area)){
				WinGet,List,List,% b.Area
				Loop,% List{
					WinGetPos,X,Y,W,H,% "ahk_id" HWND:=List%A_Index%
					All.Push({X:X,Y:Y,W:W,H:H,HWND:HWND})
				}if(!All.1){
					Error:="Unable To Find Window:`n`n`t" Area
					Goto,PA_Exit
				}Goto,PA_NextStep
			}Sleep,100
		}if(!All.Count()){
			Error:="Unable to find Window " b.Area
			Goto,PA_Exit
		}
		PA_NextStep:
		End:=(Start:=A_TickCount)+(b.Wait*1000)
		while(A_TickCount<End){
			Arr:=[]
			for c,d in All{
				K:=StrLen(Bits)*4,VarSetCapacity(In,28),VarSetCapacity(SS,d.W*d.H),VarSetCapacity(S1,K),VarSetCapacity(S0,K),VarSetCapacity(AllPos,Info.6*4)
				for e,f in [0,Info.1,Info.2,Info.4,Info.5,0,0]
					NumPut(f,&In,4*(A_Index-1),"Int")
				Cap:=VarSetCapacity(Scan,d.W*d.H*4),Stride:=((d.W*32+31)//32)*4,Win:=DllCall("GetDesktopWindow",Ptr),HDC:=DllCall("GetWindowDC",Ptr,Win,Ptr),MDC:=DllCall("CreateCompatibleDC",Ptr,HDC,Ptr),VarSetCapacity(BI,40,0),NumPut(40,BI,0,Int),NumPut(d.W,BI,4,Int),NumPut(-d.H,BI,8,Int),NumPut(1,BI,12,"Short"),NumPut(32,BI,14,"Short")
				if(hBM:=DllCall("CreateDIBSection",Ptr,MDC,Ptr,&BI,Int,0,PtrP,PPVBits,Ptr,0,Int,0,Ptr))
					OBM:=DllCall("SelectObject",Ptr,MDC,Ptr,hBM,Ptr),DllCall("BitBlt",Ptr,MDC,Int,0,Int,0,Int,d.W,Int,d.H,Ptr,HDC,Int,X,Int,Y,UInt,0x00CC0020|0x40000000),DllCall("RtlMoveMemory",Ptr,&Scan,Ptr,PPVBits,Ptr,Stride*d.H),DllCall("SelectObject",Ptr,MDC,Ptr,OBM),DllCall("DeleteObject",Ptr,hBM)
				DllCall("DeleteDC",Ptr,MDC),DllCall("ReleaseDC",Ptr,Win,Ptr,HDC)
				if(!MyFunc){
					;CodeHere
					VarSetCapacity(MyFunc,Len:=StrLen(Hex:=A_PtrSize=8?x64:x32)//2)
					Loop,%Len%
						NumPut((Value:="0x" SubStr(Hex,2*A_Index-1,2)),MyFunc,A_Index-1,"UChar")
					DllCall("VirtualProtect",Ptr,&MyFunc,Ptr,Len,"Uint",0x40,PtrP,0)
				}OK:=DllCall(&MyFunc,"UInt",Info.3,"UInt",d.X,"UInt",d.Y,Ptr,&Scan,"Int",0,"Int",0,"Int",d.W,"Int",d.H,Ptr,&SS,"AStr",Bits,Ptr,&S1,Ptr,&S0,Ptr,&In,"Int",7,Ptr,&AllPos,"Int",Info.6),Arr:=[]
				Loop,%OK%{
					if(Arr.Count()>=b.Match)
						Break,3
					Arr.Push({X:(Pos:=NumGet(AllPos,4*(A_Index-1),"Int"))&0xFFFF,Y:Pos>>16,W:Info.1,H:Info.2,HWND:HWND,Action:Action})
				}Sleep,100
			}if(Arr.1)
				Break
			Sleep,100
		}if(b.Match="Return")
			return Arr
		if(!Arr.1){
			Error:="Unable to find the Pixel Group"
			Goto,PA_Exit
		}if(!Obj:=Arr[b.Match]){
			Error:="Unable to find the " b.Match " occurrence."
			Goto,PA_Exit
		}WinGetPos,X,Y,,,% "ahk_id" Obj.HWND
		if(b.Type="InsertText"){
			Pos:="x" Obj.X+Round(b.OffSetX)-X " y" Obj.Y+Round(b.OffSetY)-Y,CB:=ClipboardAll
			while(Clipboard!=b.Text){
				Clipboard:=b.Text
				Sleep,10
			}BlockInput,On
			ControlClick,%Pos%,% "ahk_id" Obj.HWND
			if(b.SelectAll){
				Sleep,50
				Send,^a
			}Sleep,50
			Send,^v
			BlockInput,Off
			Clipboard:=CB
			Sleep,100
		}else if(b.Type="Mouse"&&b.Action!="Move"){
					;********************restore mouse position***********************************
			if(b.RestorePOS)
				MouseGetPos,RestoreX,RestoreY
			if(b.Actual){
				MouseClick,Left,% Obj.X+Round(b.OffSetX),% Obj.Y+Round(b.OffSetY),% b.ClickCount ;Added b.clickcount by Joe as it was missing
				if(b.RestorePOS)
					MouseMove,% RestoreX,RestoreY ;change this to an if the thing was selected
			}else{
				Pos:="x" Obj.X+Round(b.OffSetX)-X " y" Obj.Y+Round(b.OffSetY)-Y
				ControlClick,%Pos%,% "ahk_id" Obj.HWND,,% b.Action,% b.ClickCount
			}
		}else if(b.Type="Mouse"&&b.Action="Move")
			MouseMove,% Obj.X+Round(b.OffSetX),% Obj.Y+Round(b.OffSetY)
	}
	PA_Exit:
	CoordMode,Mouse,%CoordMode%
	SetTitleMatchMode,%Mode%
	SetBatchLines,%BCH%
	if(A_ThisLabel="PA_Exit"){
		MsgBox,262144,Error,%Error%
		Exit
	}
	return "ahk_id" Obj.HWND
}