<!-- #include virtual = "/includes/config.asp" -->
<%on error resume next

    fldUserID		= Func_Security(Request("fldUserID"))
	ConfirmCode		= F_SifreUret(9, "1", "1")

    SQL.Execute("UPDATE tblUsers set ConfirmCode='"& ConfirmCode &"' WHERE fldUserID = "& fldUserID &"")
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="tr" lang="tr">
<head>
	<meta http-equiv="Content-Language" content="tr">
	<meta http-equiv="Content-Type" content="text/html; charset=windows-1254"/>
	<style>
		body { background: #fff; font-family: Tahoma; font-size: 11px; color: #333; }
		table { font-family: Tahoma; font-size: 11px; color: #333; }
	</style>
</head>
<body>

<table border="0" width="100%" cellspacing="0" cellpadding="0" height="100%">
	<tr>
		<td valign="top">
		<div align="center">
			<table border="0" width="75%" id="table1" cellspacing="0" cellpadding="0" height="100%">
				<tr>
					<td valign="top">
						<div style="background-color: #b22238; color: #fff; padding: 10px; font-weight: bold; font-size: 12px;"><%=ayarlar_title%></div>
						<div style="padding: 5px 10px 0px 10px;">
							<div style="line-height: 18px;">
								Merhaba,<br /><br />
								<strong>Şifreni unuttuysan aşağıdaki linke tıklayarak yeni şifre oluşturabilir ve bu şifre ile <%=ayarlar_url%>'a üye girişi yapabilirsin.</strong> <br /><br />

								<a href="<%=ayarlar_url &"/resetpassword/?code="&ConfirmCode&"&Q="&fldUserID%>" style="display: inline-block;  padding: 10px 20px 10px 20px; margin-bottom:10px; background-color: #b22238; color: #fff; text-decoration: none; font-family: Arial, helvetica, arial, 'lucida grande', sans-serif; font-size: 13px; font-weight: normal; font-style: normal;">Şifremi Değiştir</a>
								<br /><br />
								--------------------------------------------------------------------------------------------<br /><br />
								<%=ayarlar_urlkisa%>
							</div>
							<div style="clear: both; height: 25px;"></div>
							<div style="background-color: #b22238; height: 1px;"></div>
							<div style="clear: both; height: 5px;"></div>

						</div>
					</td>
				</tr>
			</table>
		</div>
		</td>
	</tr>
</table>

</body>
</html>
<!-- #include virtual = "/includes/db-close.asp" -->