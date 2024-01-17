<!-- #include virtual = "/includes/config.asp" -->
<!-- #include virtual = "/includes/session.asp" -->

<!doctype html>
<html class="no-js " lang="en">
<head>
    <title><%=ayarlar_title%></title>
    <!-- #include virtual = "/includes/head.asp" -->
</head>
<body class="theme-orange">
    <!-- #include virtual = "/includes/loading.asp" -->
    <!-- #include virtual = "/includes/header.asp" -->
    <!-- #include virtual = "/includes/leftmenu.asp" -->

    <section class="content home">
        <div class="block-header">
            <div class="row">
                <div class="col-lg-7 col-md-6 col-sm-12">
                    <h2>HOŞ GELDİNİZ</h2>
                </div>

            </div>
        </div>
        <div class="container-fluid">

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
            

            <div class="row clearfix">
                <div class="col-sm-12 col-md-12 col-lg-12">
                    <div class="card">
                        <div class="header">
                            <h2>Kullanıcı Listesi</h2>
                            <p>Tüm Kullanıcılar</p>

                        </div>
                        <div class="body table-responsive members_profiles">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Adı Soyadı</th>
                                        <th>E-mail Adresi</th>
                                        <th>Login Tarihi</th>
                                        <th>Login IP</th>
                                        <th>Kayıt Tarihi</th>
                                        <th>Durum</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
	
                                        Set a = SQL.Execute("SELECT * FROM tblUsers ORDER BY fldUserID DESC")
                                        If a.Eof Then
                                        Else
                                        Do while not a.Eof
                                    %>
                                    <tr>
                                        <td>
                                            <%=a("fldUserID")%>
                                        </td>
                                        <td><span title="<%=a("fldUserName")%>" class="title text-dark font-bold" style="color: #92293b !important; font-size: 12px"><%=a("fldUserName")%></span></td>
                                        <td><span class="title text-dark font-bold"><%=a("fldUserEmail")%></span></td>
                                        <td><%=FormatDateTime(a("fldUserLoginDate"))%></td>
                                        <td><%=a("fldUserLoginIP")%></td>
                                        <td><%=FormatDateTime(a("fldUserRegisterDate"))%></td>
                                        <td><%=DurumSec(a("fldUserStatus"))%></td>
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
    <script src="/assets/js/pages/index.js"></script>
</body>
</html>
