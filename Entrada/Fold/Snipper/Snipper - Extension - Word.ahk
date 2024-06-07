; Snipper - Extension - Word
Extensions.Push({ Word: { Text: 'COPY:  Word', Func: Clipboard2Word } })
Extensions.Push({ Word: { Text: 'SAVE:  Word PDF', Func: Clipboard2Word.Bind(,GetFullPathName('.\Snipper - Word\')) } })
Clipboard2Word(Borders := false, SavePath := '')
{
	; Put Active Snip on Clipboard
	Snip2Clipboard(Borders)
	; SavePath means to Create PDF
	If SavePath
	{
		; Get COM Application
		wdApp := ComObject('Word.Application')
		; Page Setup
		wdDoc := wdApp.Documents.Add
		wdDoc.PageSetup.PageHeight := 1584 ; Max Size Allowed by Word
		wdDoc.PageSetup.PageWidth := 1584 ; Max Size Allowed by Word
		wdDoc.PageSetup.TopMargin := wdApp.InchesToPoints(0)
		wdDoc.PageSetup.BottomMargin := wdApp.InchesToPoints(0)
		wdDoc.PageSetup.LeftMargin := wdApp.InchesToPoints(0)
		wdDoc.PageSetup.RightMargin := wdApp.InchesToPoints(0)
		; Insert Picture
		wdApp.Selection.PasteSpecial(,,,, wdPasteBitmap:=4)
		wdApp.Selection.Start -= 1
		wdPic := wdApp.Selection.InlineShapes(1)
		; Crop Page Size to Fit Picture
		wdDoc.PageSetup.PageHeight := wdPic.Height
		wdDoc.PageSetup.PageWidth := wdPic.Width
		; Save PDF
		If !FileExist(SavePath)
			DirCreate(SavePath)
		TimeStamp := FormatTime(, 'yyyy_MM_dd @ HH_mm_ss')
		FileName := 'Snipper - PDF Created with Word - ' TimeStamp '.PDF'
		wdDoc.ExportAsFixedFormat(SavePath FileName, 17)
		; Finish
		wdDoc.Close(0)
		wdApp.Quit()
		Run SavePath FileName
		return
	}
	Else
	{
		; Get COM Application
		Try
		{
			wdApp := ComObjActive('Word.Application')
			wdDoc := wdApp.ActiveDocument
		}
		Catch
		{
			wdApp := ComObject('Word.Application')
			wdDoc := wdApp.Documents.Add
			wdApp.Visible := true
		}
	}
	; Insert Picture
	PictureWidth := wdDoc.PageSetup.PageWidth - wdDoc.PageSetup.LeftMargin - wdDoc.PageSetup.RightMargin
	wdApp.Selection.EndKey(wdStory:=6)
	wdApp.Selection.Paste
	wdApp.Selection.Start -= 1
	wdPic := wdApp.Selection.InlineShapes(1)
	wdPic.LockAspectRatio := true
	wdPic.Width := PictureWidth ; Size to Side Margins
}
