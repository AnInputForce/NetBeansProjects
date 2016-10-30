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
	document.form1.updatecert.value="update";
	  
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
						 证件类型ID
					</td>
							
					<td>
						<input name="certid" type="text" 
						  value=<%=application.getAttribute("str1")%>>
					</td>
					<td>
						证件名称
					</td>	
					<td>
						<input name="certname" type="text" 
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
			String certid,certname;
		
			String strWhere2;		
				
			String isUpdate = request.getParameter("updatecert");
			
			if (isUpdate != null) {
									
				certid=request.getParameter("certid");
				certname =encode(request.getParameter("certname"));
				
				if (certid == null) certid="";
				if (certname == null) certname="";
			
				
				if(application.getAttribute("str2")!=null &&
					!application.getAttribute("str2").equals(""))
				{
					strWhere2=" and cert_name='"+ application.getAttribute("str2") +"'";				
				
				}else
				{
					strWhere2="";
				}		
				
				Manager m = Manager.getInstance();	

				String sql = "update  mon_certinfo set    cert_id= '" + certid.trim()
				+ "'  , cert_name= '" + certname.trim()			
				+ "'  where cert_id ='"
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
		     <input name="updatecert" type="hidden" />	
		</form>
	</body>
</html>
