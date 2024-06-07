; Snipper - Extension - Acrobat
Extensions.Push({ Acrobat: { Text: 'COPY:  Acrobat PDF', Func: Clipboard2Acrobat } })
Extensions.Push({ Acrobat: { Text: 'SAVE:  Acrobat PDF', Func: Clipboard2Acrobat.Bind(,GetFullPathName('.\Snipper - PDF\')) } })
Clipboard2Acrobat(Borders := false, SavePath := '')		; Adobe Acrobat must be installed
{
	; Put Active Snip on Clipboard
	Snip2Clipboard(Borders)
	; Open Adobe Acrobat
	Try App := ComObject('AcroExch.App')
	Catch
	{
		MsgBox 'Could not Open Adobe Acrobat COM'
		return
	}
	App.Show()
	App.MenuItemExecute('ImageConversion:Clipboard')
	; Save PDF
	If SavePath
	{
		If !FileExist(SavePath)
			DirCreate(SavePath)
		TimeStamp := FormatTime(, 'yyyy_MM_dd @ HH_mm_ss')
		FileName := TimeStamp '.PDF'
		AVDoc := App.GetActiveDoc()
		PVDoc := AVDoc.GetPDDoc()
		PDSaveIncremental := 0x0000		; write changes only
		PDSaveFull := 0x0001			; write entire file
		PDSaveCopy := 0x0002			; write copy w/o affecting current state
		PDSaveLinearized := 0x0004		; write the file linearized for
		PDSaveBinaryOK := 0x0010		; OK to store binary in file
		PDSaveCollectGarbage := 0x0020	; perform garbage collection on
		PVDoc.Save(PDSaveFull | PDSaveLinearized, SavePath FileName)
	}
}
