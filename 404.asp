<!-- #include virtual = "/includes/config.asp" -->
<%
    ErrorURL    = Request.QueryString
    ErrorPage   = Split(ErrorURL, ":"& SET_HTTP_PORT)
    ErrorSayfa  = ErrorPage(1)


	ErrorSayfaSplit	= Split(ErrorSayfa, "/")
	ErrorSayfaLink	= ErrorSayfaSplit(1)
	ErrorSayfaSayfa	= ErrorSayfaSplit(2)

    If ErrorSayfaLink = "login" Then
        Response.Status = 200
        Server.Transfer("login.asp")

    ElseIf ErrorSayfaLink = "register" Then
        Response.Status = 200
        Server.Transfer("register.asp")

    ElseIf ErrorSayfaLink = "forgotpassword" Then
        Response.Status = 200
        Server.Transfer("forgotpassword.asp")

    ElseIf ErrorSayfaLink = "resetpassword" Then
        Response.Status = 200
        Server.Transfer("resetpassword.asp")

    ElseIf ErrorSayfaLink = "logout" Then
        Response.Status = 200
        Server.Transfer("logout.asp")

    ElseIf ErrorSayfaLink = "home" Then
        Response.Status = 200
        Server.Transfer("default.asp")    
 
    ElseIf InStr(ErrorSayfaLink, "usernew") > 0 Then
        Response.Status = 200
        Server.Transfer("usernew.asp")

    ElseIf InStr(ErrorSayfaLink, "userlist") > 0 Then
        Response.Status = 200
        Server.Transfer("userlist.asp")

    ElseIf InStr(ErrorSayfaLink, "useredit") > 0 Then
        Response.Status = 200
        Server.Transfer("useredit.asp")           

    ElseIf ErrorSayfaLink = "projects" Then
        Response.Status = 200
        Server.Transfer("projects.asp")

    ElseIf InStr(ErrorSayfaLink, "projectsadd") > 0 Then
        Response.Status = 200
        Server.Transfer("projectsadd.asp")

    ElseIf InStr(ErrorSayfaLink, "projectsdetails") > 0 Then
        Response.Status = 200
        Server.Transfer("projectsdetails.asp")
		
    ElseIf InStr(ErrorSayfaLink, "projectsedit") > 0 Then
        Response.Status = 200
        Server.Transfer("projectsedit.asp")

    ElseIf InStr(ErrorSayfaLink, "users") > 0 Then
        Response.Status = 200
        Server.Transfer("users.asp")

    ElseIf InStr(ErrorSayfaLink, "tasksadd") > 0 Then
        Response.Status = 200
        Server.Transfer("tasksadd.asp")

    ElseIf InStr(ErrorSayfaLink, "tasks") > 0 Then
        Response.Status = 200
        Server.Transfer("tasks.asp")

    ElseIf InStr(ErrorSayfaLink, "taskedit") > 0 Then
        Response.Status = 200
        Server.Transfer("taskedit.asp")

    ElseIf InStr(ErrorSayfaLink, "personaladd") > 0 Then
        Response.Status = 200
        Server.Transfer("personaladd.asp")

    ElseIf InStr(ErrorSayfaLink, "personals") > 0 Then
        Response.Status = 200
        Server.Transfer("personals.asp")

    ElseIf InStr(ErrorSayfaLink, "personaledit") > 0 Then
        Response.Status = 200
        Server.Transfer("personaledit.asp")

    Else
        Response.Status = 404

        Response.Write("<table border=""0"" cellpadding=""0"" cellspacing=""0"" style=""width: 100%; height: 100%;""><tr><td style=""text-align: center; font-family: Arial; font-size: 24px; font-weight: normal; line-height: 38px;""><strong style=""font-size: 34px;"">404 Hata!</strong><br />Üzgünüz, aradığınız sayfaya ulaşamadık...<p><a href=""/home"" style=""text-decoration: underline; color: #999;"">&lt; Anasayfaya dönebilirsin</a></p></td></tr></table>")

    End If
%>