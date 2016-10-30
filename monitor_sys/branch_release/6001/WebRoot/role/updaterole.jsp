<%@ page language="java" import="com.git.base.dbmanager.*"
	contentType="text/html;charset=GBK"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<script language="javascript">
function updaterecord()
{
	document.form1.updaterole.value="update";
	  
    document.form1.submit();
}
<%!
 public String encode(String val)
 {
     String value = "";
     try
     {
         value = new String(val.getBytes("iso-8859-1"),"GBK");
	 }catch(Exception e)
	 {
	     e.printStackTrace();
	 }
	 return value;
 }
%>	
</script>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
	</head>
	<body>
		
		<form name="form1">
			<table>
				<tr>	
					<td>
						角色ID
					</td>
					<td>
						<input name="roleid" type="text" 
						  value=<%=application.getAttribute("str1")%>>
					</td>
					<td>
						角色名称
					</td>
					<td>
						<input name="rolename" type="text" 
						  value=<%=application.getAttribute("str2")%>>
					</td>
				
				</tr>
				<tr    height='25'>
					<td >
						<input  type="hidden" />
					</td>	
				</tr>	
				
				<tr>
					<td >
						<input  type="hidden" />
					</td>	
					
					<td  align="center"  >		
								
						<input value="提交" type="button" class="button"
							onclick=updaterecord();>
					</td>
				</tr>
			</table>
		
		<%
			String roleid,rolename;
		
			String strWhere2;
				
			String isUpdate = request.getParameter("updaterole");
			
			if (isUpdate != null) {
									
				roleid=request.getParameter("roleid");
				rolename =encode(request.getParameter("rolename"));
				
				if (roleid == null) roleid="";
				if (rolename == null) rolename="";			
				
				if(application.getAttribute("str2")!=null &&
					!application.getAttribute("str2").equals(""))
				{
					strWhere2=" and role_name='"+ application.getAttribute("str2") +"'";				
				
				}else
				{
					strWhere2="";
				}
				
				Manager m = Manager.getInstance();	

				String sql = "update  mon_role set    role_id= '" + roleid.trim()
				+ "'  , role_name= '" + rolename.trim()
				+ "'  where role_id ='"
				+ application.getAttribute("str1") + "' " 
				+ strWhere2  ;

				int iRet = m.ModifySql(sql);

				if (iRet > 0) {
				%>
					<jsp:forward page="../success.jsp"></jsp:forward>		
				<%
				} else {
				%>
					<jsp:forward page="../failure.jsp"></jsp:forward>		
			<%
				}
			}
		%>
		     <input name="updaterole" type="hidden" />	
		</form>
	</body>
</html>
