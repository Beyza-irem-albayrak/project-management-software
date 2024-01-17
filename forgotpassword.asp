<!-- #include virtual = "/includes/config.asp" -->
<%

SayfaTitle = "Şifremi Unuttum"

	If Request.Form() <> "" Then

		fldEmail		= loginkontrol(Request.Form("fldEmail"))


		Set a = SQL.Execute("SELECT * FROM tblUsers WHERE fldUserStatus=1 AND fldUserEmail='"& fldEmail &"'")

			If a.Eof Then

			    Session("Error") = "Böyle bir hesab bulunamadı!"
			    Response.Redirect("/forgotpassword/")

			Else

                ConfirmCode		= F_SifreUret(9, "1", "1")
                SQL.Execute("UPDATE tblUsers set ConfirmCode='"& ConfirmCode &"' WHERE fldUserID = "& a("fldUserID") &"")

                mesaj	= "Merhaba Şifreni unuttuysan aşağıdaki linke tıklayarak yeni şifre oluşturabilir ve bu şifre ile "& ayarlar_url &"'a üye girişi yapabilirsin.<br><br><a href="& ayarlar_url &"/resetpassword/?code="& ConfirmCode &"&Q="& a("fldUserID") &" style=""display: inline-block;  padding: 10px 20px 10px 20px; margin-bottom:10px; background-color: #d8262f; color: #fff; text-decoration: none; font-family: Arial, helvetica, arial, 'lucida grande', sans-serif; font-size: 13px; font-weight: normal; font-style: normal;"">Şifremi Değiştir</a> <br /><br />"

			    Response.Write MailGonder(a("fldUserEmail"), "şifre yenileme", mesaj)
			    Session("Ok") = "E-posta adresinize gönderdiğimiz şifre yenileme başlıklı e-posta içindeki linke tıklayarak şifrenizi değiştirebilirsiniz."
			        
                Response.Redirect("/forgotpassword/")

			End If

		a.Close
		Set a = Nothing

	End If

%>
<!doctype html>
<html class="no-js " lang="en">
<head>
    <title><%=SayfaTitle%></title>
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

                <form class="col-lg-12" id="sign_in" method="POST" action="">
                    <h5 class="title">Lütfen sisteme tanımlı olan eposta adresinizi giriniz</h5>
                    <div class="c20"></div>
                    <div class="form-group form-float">
                        <div class="form-line">
                            <input type="email" class="form-control"  name="fldEmail" id="fldEmail" required autofocus>
                            <label class="form-label">Email Adresiniz</label>
                        </div>
                    </div>



                    <div class="col-lg-12">
                        <button type="submit" class="btn btn-raised btn-success waves-effect g-bg-blue"><i class="material-icons">check</i> GÖNDER</button>
                    </div>
                </form>
                <div class="col-lg-6 m-t-40">
                    <a class="btn btn-info" href="/register/">Kayıt Ol</a>
                </div>  
                <div class="col-lg-6 m-t-40">
                    <a class="btn  btn-raised btn-success waves-effect" href="/login/">Giriş Yap!</a>
                </div>                    
            </div>
        </div>
    </div>
</div>
<script src="/assets/bundles/libscripts.bundle.js"></script>    
<script src="/assets/bundles/vendorscripts.bundle.js"></script>
<script src="/assets/bundles/mainscripts.bundle.js"></script>

</body>
</html>
<!-- #include virtual = "/includes/db-close.asp" -->