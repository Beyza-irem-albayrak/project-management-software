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
        End If
    a.Close
    Set a = Nothing

  

    SayfaTitle = fldProjectName & " > Proje Detayı" 
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

                            


                    <div class="card">
                        <div class="table-responsive">
                            <table class="table table-borderless table-shopping-cart  table-striped no-margin">
                                <thead class="text-muted">
                                    <tr class="small text-uppercase alert bg-teal">
                                        <th>GÖREVLİ</th>
                                        <th>GÖREV</th>
                                        <th>GÖREVİ VEREN</th>
                                        <th>BAŞLANGIÇ TARİHİ</th>
                                        <th>BİTİŞ TARİHİ</th>
                                        <th>DURUM</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        Set a = SQL.Execute("SELECT * FROM viewTasks ORDER BY fldCreateDate DESC")
                                        If a.Eof Then
                                        Else
                                        Do while not a.Eof
                                    %>

                                    <tr>
                                        <td><%=a("fldPerName")%></td>
                                        <td><%=a("fldTaskName")%></td>
                                        <td><span title="<%=a("fldUserName")%>" class="title text-dark font-bold" style="color: #92293b !important; font-size: 12px"><%=a("fldUserName")%></span></td>
                                        <td><%=FormatDateTime(a("fldStartDate"))%></td>
                                        <td><%=FormatDateTime(a("fldFinishDate"))%></td>
                                        <td><%=ProjeSec(a("fldDurum"))%></td>
                                    </tr>
                                    <%          
                                        a.MoveNext:Loop
                                        End IF
                                        a.Close
                                        Set a = Nothing
                                    %>
                                </tbody>
                            </table>
                        </div>


                        <div class="c10"></div>


                        
                    </div>

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
