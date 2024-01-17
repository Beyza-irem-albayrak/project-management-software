<!-- #include virtual = "/includes/config.asp" -->
<% 
   If Request.Form <> "" Then

        fldUserName     = loginkontrol(Request.Form("fldUserName"))
        fldUserEmail    = loginkontrol(Request.Form("fldUserEmail"))
        fldUserPassword = loginkontrol(Request.Form("fldUserPassword"))

		Set a = SQL.Execute("SELECT * FROM tblUsers WHERE fldUserEmail='"& fldUserEmail &"'")

			If a.Eof Then
                On Error Resume Next
				SQL.Execute("Insert Into tblUsers (fldUserName, fldUserEmail, fldUserPassword, fldUserLoginDate, fldUserLoginIP, fldUserStatus) Values ('"& fldUserName &"','"& fldUserEmail &"','"& fldUserPassword &"',CONVERT(DATETIME, '"& Now() &"', 104),'"& Request.ServerVariables("REMOTE_ADDR") &"',1)")


                        Set b = SQL.Execute("SELECT fldUserID FROM tblUsers WHERE fldUserEmail = '"& fldUserEmail &"' ORDER BY fldUserID DESC")
                            Session("user_id") = b("fldUserID")
				            Session.Timeout = 1200
				            Response.Cookies("user_id") = b("fldUserID")
				            Response.Cookies("user_id").Expires = Now + 1
                            		Response.Redirect("/")
				        b.Close
				        Set b = Nothing
			Else

				Session("Error") = fldUserEmail & " kayıt sistemde mevcut!, lütfen farklı bir email adresi giriniz!"
				Response.Redirect("/register/")
				Response.End

			End If

		a.Close
		Set a = Nothing

    End If		
%>
<!doctype html>
<html class="no-js " lang="en">
<head>
    <title><%=ayarlar_title%></title>
    <!-- #include virtual = "/includes/head.asp" -->
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
</head>

<body class="theme-orange">
<div class="authentication">
    <div class="card">
        <div class="body">
            <div class="row">
                <div class="col-lg-12">
                    <div class="header slideDown">
                        <div class="logo"><img src="/assets/images/logo.png" alt=""></div>
                   </div>                        
                </div>

                <% If ErrorText <> "" Then %>
                <div class="alert bg-red w-100"><i class="material-icons" style="vertical-align: middle;">error</i> <%=ErrorText%></div>
                <% ErrorText=""%>
                <% End If %>

				<% If Session("Error") <> "" Then %>
                    <div class="alert bg-red w-100"><i class="material-icons" style="vertical-align: middle;">error</i> <%=Session("Error")%></div>
                    <div class="c10"></div>
                    <% Session("Error") = "" %>
                <% End If %>
                        
                <% If Session("Ok") <> "" Then %>
                    <div class="alert bg-green w-100"> <i class="material-icons" style="vertical-align: middle;">check_circle</i> <%=Session("Ok")%></div>
                    <div class="c10"></div>
                    <% Session("Ok") = "" %>
                <% End If %>

                <form class="col-lg-12" id="sign_in" method="POST" action="/register/">
                    <h5 class="title">Yeni Kayıt</h5>
                    <div class="c20"></div>
                    <div class="form-group form-float">
                        <div class="form-line">
                            <label class="form-label">Adı Soyadı</label>
                            <input type="text" class="form-control"  name="fldUserName" id="fldUserName"  autofocus>
                        </div>
                    </div>                    
                    <div class="form-group form-float">
                        <div class="form-line">
                            <label class="form-label">Email Adresiniz</label>
                            <input type="text" class="form-control"  name="fldUserEmail" id="fldUserEmail"  autofocus>
                        </div>
                    </div>
                    <div class="form-group form-float">
                        <div class="form-line">
                            <label class="form-label">Şifre</label>

                            <i class="fa fa-eye-slash" id="eye" style="color:#92293b; font-size:20px; position:absolute; margin:5px 0px 0px 280px; z-index:6666; cursor:pointer"></i>
                            <input type="password" class="form-control"  name="fldUserPassword" id="fldUserPassword">
                        </div>
                    </div>


                    <div class="col-lg-12">
                        <button type="submit" class="btn btn-raised btn-success waves-effect "><i class="material-icons">check</i> KAYIT OL</button>
                    </div>
                </form>
                <div class="col-lg-6 m-t-40">
                    <a class="btn btn-info" href="/forgotpassword/">Giriş Yap</a>
                </div>                  
                <div class="col-lg-6 m-t-40">
                    <a class="btn l-slategray" href="/forgotpassword/">Şifremi Unuttum?</a>
                </div>                    
            </div>
        </div>
    </div>
</div>
<script src="/assets/bundles/libscripts.bundle.js"></script>    
<script src="/assets/bundles/vendorscripts.bundle.js"></script>
<script src="/assets/bundles/mainscripts.bundle.js"></script>
<script src="/assets/js/js.js"></script>
	<script type="text/javascript">
        $(function () {

            $('#eye').click(function () {

                if ($(this).hasClass('fa fa-eye-slash')) {

                    $(this).removeClass('fa fa-eye-slash');

                    $(this).addClass('fa fa-eye');

                    $('#fldUserPassword').attr('type', 'text');

                } else {

                    $(this).removeClass('fa fa-eye');

                    $(this).addClass('fa fa-eye-slash');

                    $('#fldUserPassword').attr('type', 'password');
                }
            });
        });	
    </script>
</body>
</html>
<!-- #include virtual = "/includes/db-close.asp" -->