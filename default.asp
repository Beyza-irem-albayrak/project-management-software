<!-- #include virtual = "/includes/config.asp" -->
<!-- #include virtual = "/includes/session.asp" -->
<%
    '# Projelere Ait Tüm Dataların Countlarını alıyoruz
    Set a = Server.CreateObject("Adodb.Recordset") 
    X = "SELECT TamamlandiProje.*, TamamlanacakProje.*, OnayBekliyor.*, TumuProjeler.* FROM (SELECT COUNT(*) AS TamamlandiPr FROM tblProjects WHERE fldDurum = '1') as TamamlandiProje, (SELECT COUNT(*) AS TamamlanacakPr FROM tblProjects WHERE fldDurum = '2') as TamamlanacakProje, (SELECT COUNT(*) AS DevamEdiyorPr FROM tblProjects WHERE fldDurum = '0') as OnayBekliyor, (SELECT COUNT(*) AS TumuPr FROM tblProjects) as TumuProjeler"
    SQL.CursorLocation = 3
    a.Open X,SQL,1,3
        HomeProjeTamamlandi     = a("TamamlandiPr")
        HomeProjeTamamlanacak   = a("TamamlanacakPr")
        HomeProjeDevamEdiyor    = a("DevamEdiyorPr")
        HomeProjeTumu           = a("TumuPr")
    a.Close
    Set a = Nothing 

    '# Görevlere Ait Tüm Dataların Countlarını alıyoruz
    Set a = Server.CreateObject("Adodb.Recordset") 
    X = "SELECT ISNULL(COUNT(fldTaskID),0) AS HomeGorevler FROM tblTask"
    SQL.CursorLocation = 3
    a.Open X,SQL,1,3
        HomeGorevler     = a("HomeGorevler")
    a.Close
    Set a = Nothing 

    '# Çalışanlara Ait Tüm Dataların Countlarını alıyoruz
    Set a = Server.CreateObject("Adodb.Recordset") 
    X = "SELECT ISNULL(COUNT(fldPerID),0) AS HomeCalisanlar FROM tblPersonal"
    SQL.CursorLocation = 3
    a.Open X,SQL,1,3
        HomeCalisanlar     = a("HomeCalisanlar")
    a.Close
    Set a = Nothing 

    '# Kullanıcılara Ait Tüm Dataların Countlarını alıyoruz
    Set a = Server.CreateObject("Adodb.Recordset") 
    X = "SELECT ISNULL(COUNT(fldUserID),0) AS HomeKullanicilar FROM tblUsers"
    SQL.CursorLocation = 3
    a.Open X,SQL,1,3
        HomeKullanicilar     = a("HomeKullanicilar")
    a.Close
    Set a = Nothing 


    '###################### SİSTEM KONTROL EDİYOR '####################################

    Set a = SQL.Execute("SELECT * FROM tblTask WHERE fldFinishDate<CONVERT(DATE, getDate(), 104) AND fldDurum<>1 ORDER BY fldTaskID ASC")
    If a.Eof Then
    Else
    Do while not a.Eof

            SQL.Execute("UPDATE tblProjects SET fldDurum=2, fldFinishDate=DATEADD(D,1,GETDATE()) WHERE  fldProjeID='"& a("fldProjeID") &"'")

        a.MoveNext:Loop
    End IF
    a.Close
    Set a = Nothing
	
	

    '###################### SİSTEM KONTROL EDİYOR '####################################


%>
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
                <div class="col-lg-12">
                    <div class="card">
                        <ul class="row profile_state list-unstyled">



                            <li class="col-lg-3 col-md-3 col-12 ccc">
                                <div class="body bggg1 aass text-white">
                                    <a class="text-white text-decoration-none" href="javascript:;">
                                        <h4> <%=HomeProjeTumu%> <br> Tüm Projeler</h4>
                                    </a>
                                    <div class="c10"></div>
                                    <span></span>
                                </div>
                            </li>
                            <li class="col-lg-3 col-md-3 col-12 ccc">
                                <div class="body bggg3 aass text-white">
                                    <a class="text-white text-decoration-none" href="javascript:;">
                                        <h4> <%=HomeProjeTamamlandi%> <br> Tamamlanan Projeler</h4>
                                    </a>

                                    <div class="c10"></div>
                                    <span></span>
                                </div>
                            </li>
                            <li class="col-lg-3 col-md-3 col-12 ccc">
                                <div class="body bggg2 aass text-white">
                                    <a class="text-white text-decoration-none" href="javascript:;">
                                        <h4> <%=HomeProjeDevamEdiyor%> <br> Devam Eden Projeler</h4>
                                    </a>
                                    <div class="c10"></div>
                                    <span></span>
                                </div>
                            </li>
                            <li class="col-lg-3 col-md-3 col-12 ccc">
                                <div class="body bggg4 aass text-white">
                                    <a class="text-white text-decoration-none" href="javascript:;">
                                        <h4> <%=HomeProjeTamamlanacak%> <br> Tamamlanacak Projeler</h4>
                                    </a>
                                    <div class="c10"></div>
                                    <span></span>
                                </div>
                            </li>

                        </ul>
                    </div>
                </div>
            </div>


        <div class="row clearfix">
            <div class="col-lg-12">
                <div class="card">
                    <ul class="row profile_state list-unstyled">



                        <li class="col-lg-4 col-md-4 col-4">
                            <div class="body">
                                <h4><span class="btn btn-raised btn-primary waves-effect"><%=HomeGorevler%> </span></h4>
                                <div class="c10"></div>
                                <span>Görevler</span>
                            </div>
                        </li>
                        <li class="col-lg-4 col-md-4 col-4">
                            <div class="body">
                                <h4><span class="btn  btn-raised btn-info waves-effect"><%=HomeCalisanlar%> </span></h4>
                                <div class="c10"></div>
                                <span>Çalışanlar</span>
                            </div>
                        </li>

                        <li class="col-lg-4 col-md-4 col-4">
                            <div class="body">
                                <h4><span class="btn  btn-raised btn-success waves-effect"><%=HomeKullanicilar%> </span></h4>
                                <div class="c10"></div>
                                <span>Kullanıcılar</span>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>

            <div class="row clearfix">
                <div class="col-sm-12 col-md-12 col-lg-12">
                    <div class="card">
                        <div class="header">
                            <h2>Projeler</h2>
                            <p>Kullanıcılar tarafından oluşturulan projeler</p>

                        </div>
                        <div class="body table-responsive members_profiles">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Projeyi Oluşturan</th>
                                        <th>Proje Adı</th>
                                        <th>Açıklama</th>
                                        <th>Başlangıç Tarihi</th>
                                        <th>Bitiş Tarihi</th>
                                        <th class="text-center">Geciken Görevler</th>
                                        <th>Durum</th>
                                        <th>İşlem</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%

                                        Set a = Server.CreateObject("ADODB.Recordset")
                                        a.Open "SELECT * FROM viewProjects ORDER BY fldCreateDate DESC", SQL, 1, 3

                                            totalPageUser   = 0
                                            a.pageSize      = 100000
                                            a.absolutepage  = page
                                            totalPage       = a.pageCount
                                            totalUser       = a.recordCount
                                            Response.Buffer = True
                                            For i = 1 to a.pageSize
                                            If a.Eof Then Exit For End If	
                                    %>
                                    <tr>
                                        <td>
                                            <%=a("fldProjeID")%>
                                        </td>
                                        <td><span title="<%=a("fldUserName")%>" class="title text-dark font-bold" style="color: #92293b !important; font-size: 12px"><%=a("fldUserName")%></span></td>
                                        <td><span class="title text-dark font-bold"><%=a("fldProjectName")%></span></td>
                                        <td><span class="title text-dark font-bold"><%=a("fldProjectDesc")%></span></td>
                                        <td><%=FormatDateTime(a("fldStartDate"))%></td>
                                        <td><%=FormatDateTime(a("fldFinishDate"))%></td>
                                        <td class="text-center"><%=a("TaskCount")%></td>
                                        <td><%=ProjeSec(a("fldDurum"))%></td>
                                        <td>

                                            <a href="/projectsdetails/<%=a("fldProjeID")%>" class="btn-sm btn-raised btn-primary waves-effect font-12">
                                                <i class="material-icons" style="vertical-align: bottom;">find_in_page</i>
                                                <span>DETAY</span>
                                            </a>

                                        </td>
                                    </tr>
                                    <%
                                            Response.Flush
                                            totalPageUser   = totalPageUser +1
                                        a.MoveNext:Next
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
