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
	document.form1.updatedept.value="update";
	  
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
						部门ID
					</td>
					<td>
						<input name="deptid" type="text" 
						  value=<%=application.getAttribute("str1")%>>
					</td>
					<td>
						部门名称
					</td>
					<td>
						<input name="deptname" type="text" 
						  value=<%=application.getAttribute("str2")%>>
					</td>
				
				</tr>		
				<tr    height='25'>
					<td >
						<input  type="hidden" />
					</td>	
				</tr>	
				<tr  >
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
			String deptid,deptname;
		
			String strWhere2;
							
			String isUpdate = request.getParameter("updatedept");
			
			if (isUpdate != null) {
									
				deptid=request.getParameter("deptid");
				deptname =encode(request.getParameter("deptname"));
				
				if (deptid == null) deptid="";
				if (deptname == null) deptname="";			
				
				if(application.getAttribute("str2")!=null &&
					!application.getAttribute("str2").equals(""))
				{
					strWhere2=" and dept_name='"+ application.getAttribute("str2") +"'";				
				
				}else
				{
					strWhere2="";
				}		
				
				Manager m = Manager.getInstance();	

				String sql = "update  mon_deptinfo set    dept_id= '" + deptid.trim()
				+ "'  , dept_name= '" + deptname.trim()			
				+ "'  where dept_id ='"
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
		     <input name="updatedept" type="hidden" />	
		</form>
	</body>
</html>
