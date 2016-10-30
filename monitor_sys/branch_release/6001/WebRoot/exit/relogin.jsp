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

</script>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<body>		
		<form name="form1" method="post">
			<script language="javascript" type="text/javascript">
				window.parent.close();
				window.open("../Login.jsp");
			</script>
			<%
			//response.sendRedirect("../Login.jsp"); 				
			%>			
		</form>
	</body>
</html>

