<%
	'#Cookies Atama
	Session("user_id") = Request.Cookies("user_id")
	'#Cookies Atama

    If Session("user_id") = "" Then
        Response.Redirect("/login")
    Else
        Set a = SQL.Execute("SELECT TOP 1 * FROM tblUsers WHERE fldUserStatus=1 AND fldUserID='"& Session("user_id") &"'")
            If a.Eof Then
                Session.Abandon
                Response.Redirect("/")
            Else

            SET_ADMIN_ID                = a("fldUserID")
            SET_ADMIN_AD                = a("fldUserName")
            SET_ADMIN_MAIL              = a("fldUserEmail")
            SET_ADMIN_DURUM             = a("fldUserStatus")
            SET_ADMIN_LOGINIP           = a("fldUserLoginIP")
            SET_ADMIN_LOGINTARIH        = a("fldUserLoginDate")

            End If
        a.Close
        Set a = Nothing
    End If

    ErrorURLx    = Request.QueryString
    ErrorPagex   = Split(ErrorURLx, ":"& SET_HTTP_PORT)
    ErrorSayfax  = ErrorPagex(1)


	ErrorSayfaSplitx= Split(ErrorSayfax, "/")
	ErrorSayfaLinkx	= ErrorSayfaSplitx(0)
	ErrorRedirect	= ErrorSayfaSplitx(1)	

%>
