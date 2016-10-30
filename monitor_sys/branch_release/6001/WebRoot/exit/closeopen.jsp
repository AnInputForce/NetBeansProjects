<%@ page language="java" import="java.sql.*"
	contentType="text/html;charset=GBK"%>
<%
	int index, iRet;
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<script language="javascript" type="text/javascript">
if(window.confirm("È·¶¨ÍË³ö£¿")==true)
{
	window.parent.close();
}

</script>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

	</head>
	<body>
		<input  name="closeopen"  type="button" value="close"  onclick="window.parent.close()">
	  
	</body>
</html>

