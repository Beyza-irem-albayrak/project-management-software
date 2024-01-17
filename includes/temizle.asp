<%

	
	'#-- E-posta Mail gönderme Start --#'
   '# Mail gönder
	'#-- E-posta Mail gönderme Start --#'
	Function MailGonder(alici, konu, mesaj)

		Set iMsg = CreateObject("CDO.Message")
		Set iConf = CreateObject("CDO.Configuration")
		Set Flds = iConf.Fields

		Set oBodyPart = iMsg.BodyPart
			oBodyPart.Fields("urn:schemas:mailheader:content-type") = "text/plain; charset=""windows-1254"""
			oBodyPart.ContentTransferEncoding = "base64"
		oBodyPart.Fields.Update

		schema = "http://schemas.microsoft.com/cdo/configuration/"
			Flds.Item(schema & "sendusing")			= 2
			Flds.Item(schema & "smtpserver")		= ayarlar_mailserver
			Flds.Item(schema & "smtpserverport")		= ayarlar_mailport
			Flds.Item(schema & "smtpauthenticate")	= 1
			Flds.Item(schema & "sendusername")		= ayarlar_mailusername
			Flds.Item(schema & "sendpassword")		= ayarlar_mailpassword
			Flds.Item(schema & "smtpusessl")			= ayarlar_mailssl
		Flds.Update

		With iMsg
			.To			= alici
			.From		= ""& ayarlar_mailgonderen &" <"& ayarlar_mailusername &">"
			.ReplyTo		= ayarlar_mailusername
			.Subject		= konu
			.TextBody	= mesaj
			.HTMLBody	= mesaj

			Set oBodyPart = iMsg.HTMLBodyPart
				oBodyPart.Fields("urn:schemas:mailheader:content-type") = "text/html; charset=""windows-1254"""
				oBodyPart.ContentTransferEncoding = "base64"
			oBodyPart.Fields.Update

			Set .Configuration = iConf
			.Send
			On Error Resume Next
			If Err = 0 Then
				'response.write "OK"
			Else
				response.write err.Description
			End If
		End With

	End Function
	'#-- E-posta Mail gönderme Finish --#'



	'#-- Login Güvenlik Kontrolü Start --#'
	Function loginkontrol(verixx)
		verix = Replace (verix ,"<script","",1,-1,1)
		verix = Replace (verix ,"or ","",1,-1,1)
		verix = Replace (verix ,"or'","",1,-1,1)
		verix = Replace (verix ,"order","",1,-1,1)
		verix = Replace (verix ,"or","or",1,-1,1)
		verix = Replace (verix ,"''","",1,-1,1)
		verix = Replace (verix ,"UNION","",1,-1,1)
		verix = Replace (verix ,"SELECT","",1,-1,1)
		verix = Replace (verix ,"WHERE'","",1,-1,1)
		verix = Replace (verix ,"LIKE","",1,-1,1)
		verix = Replace (verix ,"FROM","",1,-1,1)
		verix = Replace (verix ,"UPDATE","",1,-1,1)
		verix = Replace (verix ,"INSERT","",1,-1,1)
		verix = Replace (verix ,"ORDER","",1,-1,1)
		verix = Replace (verix ,"GROUP","",1,-1,1)
		verix = Replace (verix ,"ALTER","",1,-1,1)
		verix = Replace (verix ,"ADD","",1,-1,1)
		verix = Replace (verix ,"MODIFY","",1,-1,1)
		verix = Replace (verix ,"RENAME","",1,-1,1)
		verix = Replace (verix ,Chr(39),"",1,-1,1)
		verix = Replace (verix ,"*","",1,-1,1)
		verix = Replace (verix ,"'","&acute;",1,-1,1)
		verix = Replace (verix ,"´","&acute;",1,-1,1)
	loginkontrol=verixx
	End  Function
	'#-- Login Güvenlik Kontrolü Finish --#'


	'#-- Login Güvenlik Kontrolü Start --#'
	Function Func_Security(Veri)

		Veri			= Replace(Veri, "!", "")
		Veri			= Replace(Veri, "'", "")
		Veri			= Replace(Veri, "^", "")
		Veri			= Replace(Veri, "+", "")
		Veri			= Replace(Veri, "%", "")
		Veri			= Replace(Veri, "&", "")
		Veri			= Replace(Veri, "/", "")
		Veri			= Replace(Veri, "(", "")
		Veri			= Replace(Veri, ")", "")
		Veri			= Replace(Veri, "=", "")
		Veri			= Replace(Veri, "?", "")
		Veri			= Replace(Veri, "_", "")
		Veri			= Replace(Veri, "*", "")
		Veri			= Replace(Veri, "-", "")
		Veri			= Replace(Veri, "<", "")
		Veri			= Replace(Veri, ">", "")
		Func_Security	= Veri

	End Function
	'#-- Login Güvenlik Kontrolü Finish --#'



    '#-- Rastgele kod oluşturma --#'
    Function F_SifreUret(HarfSayi, SayiUret, HarfUret)

        '# 10 karakter için 9 girilmeli (1 eksik yani 0'dan başlıyor)
        '# F_SifreUret(8, "1", "1") '# 9 karakterli harf ve sayı
        '# F_SifreUret(8, "1", "0") '# 9 karakterli sayı
        '# F_SifreUret(8, "0", "1") '# 9 karakterli harf

        Harf = Array("A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "R", "S", "T", "U", "V", "Y", "Z", "Q", "W", "X", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "r", "s", "t", "u", "v", "y", "z", "q", "w", "x")
        Sayi = Array("1", "2", "3", "4", "5", "6", "7", "8", "9", "0")

        If SayiUret = "1" AND HarfUret = "1" Then
            Denetim = "3"
        Elseif SAyiUret = "1" Then
            Salla = "2"
        Elseif HarfUret = "1" Then
            Salla = "1"
        End if

        Randomize Timer
        For I = 0 To Int(HarfSayi)
            If Denetim = "3" Then
                Salla = Int((Rnd * 2) + 1)
            End If
            If Salla = 2 Then
                Gidecek = Gidecek & "" & Sayi(Int((Rnd * 10) + 0))
            Elseif Salla = 1 Then
                Gidecek = Gidecek & "" & Harf(Int((Rnd * 52) + 0))
            End If
        Next

        F_SifreUret = Gidecek
		'Response.Write SifreUret(8, "1", "1") '8 karakterli harf ve sayılardan oluşan bir şifre oluşturur
		'Response.Write "<br>---"
		'Response.Write SifreUret(8, "1", "0") '8 Karakterli sayılardan oluşan bir şifre 
		'Response.Write "<br>---"
		'Response.Write SifreUret(8, "0", "1") '8 Karakterli harflerden oluşan bir şifre
		'Response.Write "<br>---"
    End Function
    '#-- Rastgele kod oluşturma --#'

%>