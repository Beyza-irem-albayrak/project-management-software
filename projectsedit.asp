<!-- #include virtual = "/includes/config.asp" -->
<!-- #include virtual = "/includes/session.asp" -->
<%

    PageURLSplit        = Split(Request.QueryString, "/")
    req_ID       		= Func_Security(PageURLSplit(4))

    Set a = SQL.Execute("SELECT * FROM tblProjects WHERE fldProjeID='"& req_ID &"'")
        If a.Eof Then
            Response.Redirect("/")
            Response.End
        Else
            fldProjeID				= a("fldProjeID")
            PRfldUserID				= a("fldUserID")
            fldProjectName			= a("fldProjectName")
            fldProjectDesc			= a("fldProjectDesc")
            fldStartDate		    = a("fldStartDate")
            fldFinishDate		    = a("fldFinishDate")
            fldDurum		    	= a("fldDurum")
        End If
    a.Close
    Set a = Nothing

    IF PRfldUserID <> SET_ADMIN_ID Then
		Session("Error") = "Size ait olmayan projeyi düzenleyemezsiniz!"
		Response.Redirect("/?")
        Response.End
    End IF

	If Request.Form() <> "" Then


        fldProjectName              = loginkontrol(Request.Form("fldProjectName"))
        fldProjectDesc              = loginkontrol(Request.Form("fldProjectDesc"))
        fldStartDate                = Request.Form("fldStartDate")
        fldFinishDate               = Request.Form("fldFinishDate")
        fldDurum               = Request.Form("fldDurum")

            '# Düzenleme İşlemi
            
            SQL.execute("UPDATE tblProjects SET fldUserID='"& SET_ADMIN_ID &"', fldDurum='"& fldDurum &"', fldProjectName='"& fldProjectName &"', fldProjectDesc='"& fldProjectDesc &"', fldStartDate=CONVERT(DATE, '"& FormatDateTime(fldStartDate) &"', 104), fldFinishDate=CONVERT(DATE, '"& FormatDateTime(fldFinishDate) &"', 104) WHERE fldProjeID='"& req_ID &"'")

			If Err <> 0 Then
				Session("Error") = Err.Description
				Response.Redirect(ErrorRedirect)
                Response.End
			End If

			Session("Ok") = "Ekleme İşleminiz Başarıyla Gerçekleşmiştir."
			Response.Redirect(ErrorRedirect)
			Response.End

		a.Close
		Set a = Nothing

	End If   

    SayfaTitle = "Proje Düzenle" 
%>

<!doctype html>
<html class="no-js " lang="en">
<head>
    <title><%=SayfaTitle%> - <%=ayarlar_title%></title>
    <!-- #include virtual = "/includes/head.asp" -->
    <link href="/assets/plugins/bootstrap-select/css/bootstrap-select.css" rel="stylesheet" />
</head>
<body class="theme-orange">
    <!-- #include virtual = "/includes/loading.asp" -->
    <!-- #include virtual = "/includes/header.asp" -->
    <!-- #include virtual = "/includes/leftmenu.asp" -->

    <section class="content home">
        <div class="block-header">
            <div class="row">
                <div class="col-lg-7 col-md-6 col-sm-12">
                    <h2><%=SayfaTitle%></h2>
                </div>
                <div class="col-lg-5 col-md-6 col-sm-12">
                    <ul class="breadcrumb float-md-right">
                        <li class="breadcrumb-item"><a href="/"><i class="zmdi zmdi-home"></i>Ana Sayfa</a></li>
                        <li class="breadcrumb-item active"><%=SayfaTitle%></li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="container-fluid">
            <div class="row clearfix">
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="card">

                        <div class="body">

                            <% If Session("Error") <> "" Then %>
                            <div class="alert alert-danger text-center" role="alert"><i class="material-icons" style="vertical-align: middle;">error</i> <%=Session("Error")%></div>
                            <div class="c10"></div>
                            <% Session("Error") = "" %>
                            <% End If %>

                            <% If Session("Ok") <> "" Then %>
                            <div class="alert alert-success text-center" role="alert"><i class="material-icons" style="vertical-align: middle;">check_circle</i> <%=Session("Ok")%></div>
                            <div class="c10"></div>
                            <% Session("Ok") = "" %>
                            <% End If %>

                            <form action="" method="post" id="FormGonder" name="FormGonder">
                                <div class="row clearfix">
                                    <div class="col-sm-12">
                                        <div class="row">
                                            
                                            <div class="col-sm-12 col-md-12 col-lg-12">
                                                <div class="form-group">
                                                    <div class="form-line">
                                                        <input type="text" class="form-control" placeholder="Proje Adı" name="fldProjectName" id="fldProjectName" value="<%=fldProjectName%>" required>
                                                    </div>
                                                </div>
                                            </div>                                            
											<div class="col-sm-12 col-md-12 col-lg-12">
                                                <div class="form-group">
                                                    <div class="form-line">
                                                        <textarea class="form-control" placeholder="Proje Açıklaması" name="fldProjectDesc" id="fldProjectDesc"><%=fldProjectDesc%></textarea>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
										
										
										
										
                                        <div class="row">
                                            <div class="col-sm-12 col-md-12 col-lg-12">
                                                <div class="form-group">
                                                    <div class="form-line">


													<select class="form-control show-tick" id="fldDurum" name="fldDurum" placeholder="Durumu" required>
													<option value="">Durum Seçiniz</option>
                                                        <%for qq=0 to Ubound(ProjeSec)%>
                                                        <option value="<%=qq%>" <%IF Int(fldDurum)=Int(qq) Then%>selected<%End IF%>><%=ProjeSec(qq)%></option>
                                                        <%next%>
                                                    </select>


                                                    </div>
                                                </div>
                                            </div>										
                                           
                                        </div>											
										
										
                                        <div class="row">
                                            <div class="col-sm-12 col-md-6 col-lg-6">
                                                <div class="form-group">
                                                    <div class="form-line">

                                                        <input type="date" class="form-control" placeholder="Başlangıç Tarihi"  name="fldStartDate" id="fldStartDate" value="<%=fldStartDate%>"  required>
                                                    </div>
                                                </div>
                                            </div>										
                                            <div class="col-sm-12 col-md-6 col-lg-6">
                                                <div class="form-group">
                                                    <div class="form-line">
                                                        <input type="date" class="form-control" placeholder="Bitiş Tarihi"  name="fldFinishDate" id="fldFinishDate" value="<%=fldFinishDate%>" required>
                                                    </div>
                                                </div>
                                            </div>
                                            

                                        </div>

                                        <div class="hrciz"></div>

                                        <div class="form-group">

                                            <button type="submit" form="FormGonder" class="btn  btn-raised btn-success waves-effect"><i class="material-icons">verified_user</i> DÜZENLE</button>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <!-- #include virtual = "/includes/footer.asp" -->
        </div>
    </section>
    <script src="/assets/bundles/libscripts.bundle.js"></script>
    <script src="/assets/bundles/vendorscripts.bundle.js"></script>
    <script src="/assets/bundles/jvectormap.bundle.js"></script>
    <script src="/assets/bundles/morrisscripts.bundle.js"></script>
    <script src="/assets/bundles/sparkline.bundle.js"></script>
    <script src="/assets/bundles/knob.bundle.js"></script>
    <script src="/assets/bundles/mainscripts.bundle.js"></script>
    <script src="/assets/js/js.js"></script>
    <script type="text/javascript">
     
        var fldStartDate = document.getElementById('fldStartDate');
        var fldFinishDate = document.getElementById('fldFinishDate');

        fldStartDate.addEventListener('change', function() {
            if (fldStartDate.value)
                fldFinishDate.min = fldStartDate.value;
        }, false);
        fldFinishDate.addEventLiseter('change', function() {
            if (fldFinishDate.value)
                fldStartDate.max = fldFinishDate.value;
        }, false);

    </script> 
</body>
</html>
