<aside id="leftsidebar" class="sidebar">
    <div class="user-info">

        <div class="info-container">
            <div class="name" data-toggle="dropdown"><%=SET_ADMIN_AD%></div>
            <div class="btn-group user-helper-dropdown">
                <i class="material-icons" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true" role="button"> keyboard_arrow_down </i>
                <ul class="dropdown-menu slideUp">
                    <li><a href="/logout/"><i class="material-icons">input</i>Güvenli Çıkış</a></li>
                </ul>
            </div>
            <div class="email"><%=FormatDatetime(SET_ADMIN_LOGINTARIH)%></div>
            <div class="email"><%=SET_ADMIN_LOGINIP%></div>
        </div>
    </div>
    <div class="menu">
        <ul class="list">
            <li class="active"><a href="/"><i class="material-icons">home</i><span>Ana Sayfa</span></a></li>
            <li><a href="/projectsadd/"><i class="material-icons">note_add</i><span>Proje Ekle</span></a></li>
            <li><a href="/"><i class="material-icons">view_list</i><span>Projeler</span> </a></li>
            <li><a href="/tasksadd/"><i class="material-icons">alarm_add</i><span>Görev Ekle</span></a></li>
            <li><a href="/users/"><i class="material-icons">people_outline</i><span>Kullanıcı Listesi</span> </a></li>

            <li class="header">SİZE ÖZEL</li>

            <li><a href="/personaladd/"><i class="material-icons">person_add</i><span>Çalışan Ekle</span> </a></li>          
            <li><a href="/personals/" ><i class="material-icons">people</i><span>Çalışanlarınız</span> </a></li>
            <li><a href="/tasks/" ><i class="material-icons">timeline</i><span>Görevleriniz</span> </a></li>
            <li><a href="/projects/"><i class="material-icons">format_list_numbered</i><span>Projeleriniz</span> </a></li>
            <li class="active"><a href="/logout/"><i class="material-icons">power_settings_new</i><span>Güvenli Çıkış</span> </a></li>

        </ul>
    </div>
</aside>