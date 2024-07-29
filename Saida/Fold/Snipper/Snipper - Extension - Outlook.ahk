; Snipper - Extension - Outlook
Extensions.Push({ Outlook: { Text: 'SAVE:  ' Settings_SavePath_Image_Ext ' File and attach to Outlook Email', Func: File2Outlook.Bind(,Settings_SavePath_Image, Settings_SavePath_Image_Ext) } })
File2Outlook(Borders := false, SavePath:='', FileExt:='')		; Outlook must be installed
{
	File := Snip2File(Borders, SavePath,, FileExt)
	TimeStamp := FormatTime(RegExReplace(File, '^.*\\|[_ @]|\(.*$'), "dddd MMMM d, yyyy 'at' h:mm:ss tt")
	Try
		IsObject(olEmail := ComObjActive('Outlook.Application').CreateItem(olMailItem := 0)) ; Create if Outlook is open
	Catch
		olEmail := ComObject('Outlook.Application').CreateItem(olMailItem := 0) ; Create if Outlook is not open
	olEmail.BodyFormat := (olFormatHTML := 2)
	;~ olEmail.TO :='SomeEmail@SomeWhere.com'
	;~ olEmail.CC :='SomeEmail@SomeWhere.com'
	olEmail.Subject := 'Screenshot Taken: ' TimeStamp
	HTMLBody := '<HTML>Please find attached a screenshot taken on ' TimeStamp '</HTML>'
	olEmail.HTMLBody := HTMLBody
	olEmail.Attachments.Add(File)
	olEmail.Display
}
