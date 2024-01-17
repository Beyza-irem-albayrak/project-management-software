<%
	'# Tanımlamalar
	Response.Buffer 	= True
	Session.LCID 		= 1055
	Session("tarih") 	= now()

	Response.ContentType = "text/html"
	Response.AddHeader "Content-Type", "text/html;charset=UTF-8"
	Response.CodePage = 65001
	Response.CharSet = "UTF-8"

    '# Microsoft SQL Server veritabanı bağlantısı kuruluyor
    On Error Resume Next

        Set SQL = Server.CreateObject("Adodb.Connection")
		'SQL.Open "Driver={SQL Server};Server=.\;uid=sa;pwd=123456;database=dbVTYS"
		SQL.Open "Driver={SQL Server};Server=proje.aspogren.com;uid=vtysodevproje;pwd=dx2%9y9A1;database=dbVTYS"

    IF Err <> 0 Then
        Response.Write("<code>Veritabanı bağlantısı kurulamıyor...</code>")
        Response.End
    End If


	yonlenecekadres 	= "/"
	DurumSec			= Array("Yayında Değil","Yayında")
	ProjeSec			= Array("Tamamlanacak","Tamamlandı","Devam Ediyor")

	IF mevki 			= "" Then 
		mevki 			= "/"
	Else
		mevki			= ErrorSayfaSayfa
	End IF


	'# Ayarlar
	Set a = Server.CreateObject("Adodb.Recordset") 
	X = "Select * From tblSettings where fldID=1"
	SQL.CursorLocation = 3
	a.Open X,SQL,1,3

		ayarlar_slogan				= a("fldTitle")
		ayarlar_title				= a("fldTitle")
		ayarlar_description			= a("fldDescription")
		ayarlar_mailserver			= a("fldMailServer")
		ayarlar_mailport			= a("fldMailPort")
		ayarlar_mailusername		= a("fldMailUsername")
		ayarlar_mailpassword		= a("fldMailPassword")
		ayarlar_mailgonderen		= a("fldMailSender")
		ayarlar_mailssl				= a("fldMailSSL")
		ayarlar_mailsend			= a("fldMailSend")
		ayarlar_url					= a("fldURL")
		ayarlar_urlkisa				= a("fldURLMin")
	a.Close
	Set a = Nothing

	'#SSL Tanımlama
    If Request.ServerVariables("HTTPS") = "off" Then
        SET_HTTP        = "http://"
        SET_HTTP_PORT   = 80
    Else
        SET_HTTP        = "https://"
        SET_HTTP_PORT   = 443
    End If

    SET_URL                 = SET_HTTP & Request.ServerVariables("SERVER_NAME")

%>
<!-- #include virtual = "/includes/sha256.asp" -->
<!-- #include virtual = "/includes/temizle.asp" -->