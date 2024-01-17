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
                            <h2>Görevleriniz</h2>
                            <p>Sizin tarafınızdan oluşturulan görevleriniz</p>

                        </div>
                        <div class="body table-responsive members_profiles">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Görev Adı</th>
                                        <th>Açıklama</th>
                                        <th>Adam Gün Değeri</th>
                                        <th>Atanan Çalışan</th>
                                        <th>Başlama Tarihi</th>
                                        <th>Bitiş Tarihi</th>
                                        <th>Durum</th>
                                        <th>İşlem</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        Set a = SQL.Execute("SELECT * FROM viewTasks WHERE fldUserID="& SET_ADMIN_ID &" ORDER BY fldCreateDate DESC")
                                        If a.Eof Then
                                        Else
                                        Do while not a.Eof
                                    %>
                                    <tr>
                                        <td>
                                            <%=a("fldTaskID")%>
                                        </td>
                                        <td><span title="<%=a("fldTaskName")%>" class="title text-dark font-bold" style="color: #92293b !important; font-size: 12px"><%=a("fldTaskName")%></span></td>
                                        <td><span class="title text-dark font-bold"><%=a("fldTaskDesc")%></span></td>
                                        <td><span class="title text-dark font-bold"><%=a("fldManDay")%></span></td>
                                        <td><span class="title text-dark font-bold"><%=a("fldPerName")%></span></td>
                                        <td><%=FormatDateTime(a("fldStartDate"))%></td>
                                        <td><%=FormatDateTime(a("fldFinishDate"))%></td>
                                        <td><%=ProjeSec(a("fldDurum"))%></td>
                                        <td>
                                            <a href="/taskedit/<%=a("fldTaskID")%>" class="btn-sm btn-raised btn-primary waves-effect font-12">
                                                <i class="material-icons" style="vertical-align: bottom;">find_in_page</i>
                                                <span>DÜZENLE</span>
                                            </a>
                                        </td>
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
