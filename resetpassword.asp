<!-- #include virtual = "/includes/config.asp" -->
<%

SayfaTitle = "Şifre Oluşturma"

    ErrorURL    = Request.QueryString
    ErrorPage   = Split(ErrorURL, ":"& SET_HTTP_PORT)
    ErrorSayfa  = ErrorPage(1)

	ErrorSayfaSplit	= Split(ErrorSayfa, "/")
	ErrorSayfaLink	= ErrorSayfaSplit(1)
	ErrorSayfaSayfa	= ErrorSayfaSplit(2)



    URLSplit        = Split(Request.QueryString, "?")
    URLSplitt       = Split(URLSplit(1), "&")


	code  	 = Replace(URLSplitt(0), "code=", "")
	Q     	 = Replace(URLSplitt(1), "Q=", "")

	If code = "" OR Q = "" Then
	Response.Redirect(ayarlar_url)
	Response.End()
	End If


    Set a = SQL.Execute("SELECT TOP 1 fldUserID FROM tblUsers WHERE fldUserStatus=1 AND ConfirmCode='"& code &"' AND fldUserID='"& Q &"'")
        If a.Eof Then
	        code  	 = ""
	        Q     	 = ""

            Response.Redirect("/")
            Response.End
        Else
            fldMusteriID	= a("fldUserID")

        End If
    a.Close
    Set a = Nothing



	If Request.Form() <> "" Then


		YeniQCode		    = Request.Form("YeniQCode")

		Set a = SQL.Execute("SELECT * FROM tblUsers WHERE fldUserStatus=1 AND ConfirmCode='"& code &"' AND fldUserID='"& Q &"'")

			'# Böyle bir üye yok
			If a.Eof Then
                YeniQCode = ""
				Session("Error") = "Eşleşen Bir kayıt bulunamadı"
				Response.Redirect("/login/")
				Response.End
            Else
                    fldConfirmCode  = F_SifreUret(9, "1", "1")

                    SQL.Execute("UPDATE tblUsers SET fldUserPassword='"& YeniQCode &"', ConfirmCode='"& ConfirmCode &"' WHERE fldUserID = "& Q &"")
                        
                    mesaj = "Merhaba "& a("fldUserName") &",<br /><br /> <strong>Kullanıcı şifrenizi değiştirdiniz.</strong> <br /><br /> Bilginize"

			        Response.Write MailGonder(a("fldUserEmail"), "Şifreniz değiştirildi!", mesaj)

                    YeniQCode = ""
                    Q     = ""
                    fldMusteriID = ""
                    ConfirmCode = ""
				    Session("Ok") = "Şifreniz başarılı bir şekilde değiştirildi.<br>Yeni şifrenizle siteye giriş yapabilirsiniz."

				    Response.Redirect("/login/")
				    Response.End
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
                    <h5 class="title">Lütfen <%=ayarlar_url%>  sonraki girişlerinizde kullanacağınız yeni şifrenizi belirleyiniz.</h5>
                    <div class="c20"></div>
                    <div class="form-group form-float">
                        <div class="form-line">
                            <label class="form-label">Yeni Şifrenizi Belirleyin!</label>
                            <i class="fa fa-eye-slash" id="eye" style="color:#92293b; font-size:20px; position:absolute; margin:5px 0px 0px 290px; z-index:6666; cursor:pointer"></i>

                            <input type="password" class="form-control" id="YeniQCode" name="YeniQCode" tabindex="2" autocomplete="off" minlength="4" maxlength="15" required autofocus />
                            <span id="guclu_mu"></span>

                            
                        </div>
                    </div>



                    <div class="col-lg-12">
                        <button type="submit" class="btn btn-raised btn-success waves-effect g-bg-blue"><i class="material-icons">check</i> ŞİFREMİ YENİLE</button>
                    </div>
                </form>
                <div class="col-lg-12 m-t-40">
                    <a class="btn  btn-raised btn-success waves-effect" href="/login/">Giriş Yap!</a>
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

                    $('#YeniQCode').attr('type', 'text');

                } else {

                    $(this).removeClass('fa fa-eye');

                    $(this).addClass('fa fa-eye-slash');

                    $('#YeniQCode').attr('type', 'password');
                }
            });
        });	
    </script>

</body>
</html>
<!-- #include virtual = "/includes/db-close.asp" -->