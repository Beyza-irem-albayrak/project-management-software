<%	
	Response.Cookies("user_id").Expires = Now - 1
    Session.Abandon
    Response.Redirect("/login/")
%>