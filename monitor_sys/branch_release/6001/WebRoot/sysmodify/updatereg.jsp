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
	document.form1.updatereg.value="update";
	  
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
	<body>
		<form name="form1">
			<table>
				<tr>	
					<td>
						流程号
					</td>
					<td>
						<input name="followid" type="text"
							 value=<%=application.getAttribute("str1")%>>
					</td>
					<td>
						任务号（后一位）
					</td>
					<td>
						<input name="tasknolastone" type="text"
							 value=<%=application.getAttribute("str2")%>>
					</td>
				
					<td>
						任务名称
					</td>
					<td>
						<input name="statusname" type="text"
							 value=<%=application.getAttribute("str3")%>>
					</td>
				
				</tr>
				
				<tr>
					<td>
					</td>
					<td>
						<input value="提交" type="button" class="button"
							onclick=updaterecord();>
					</td>
				
				</tr>

			</table>
		
		<%
			String statusname,followid,tasknolastone;
		
			String strWhere1,strWhere2,strWhere3,strWhere4;
		
			String isUpdate = request.getParameter("updatereg");
			
			if (isUpdate != null) {
			
				followid=request.getParameter("followid");
				tasknolastone=request.getParameter("tasknolastone");
				
				statusname=encode(request.getParameter("statusname"));
			
				if (followid == null) followid="";
				if (tasknolastone == null) tasknolastone="";
			
				if (statusname == null) statusname="";
				
				if(application.getAttribute("str1")!=null &&
					!application.getAttribute("str1").equals(""))
				{
					strWhere1=" and followid= "+ application.getAttribute("str1")  ;				
				
				}else
				{
					strWhere1="";
				}
				if(application.getAttribute("str2")!=null &&
					!application.getAttribute("str2").equals(""))
				{
					strWhere2=" and tasknolastone="+ application.getAttribute("str2") ;				
				
				}else
				{
					strWhere2="";
				}
				if(application.getAttribute("str3")!=null &&
					!application.getAttribute("str3").equals(""))
				{
					strWhere3=" and tranname='"+ application.getAttribute("str3")+"'" ;				
				
				}else
				{
					strWhere3="";
				}
				Manager m = Manager.getInstance();

				String sql = "update  bat_taskreg set    followid= " + followid.trim()
				+ "  , tasknolastone= " + tasknolastone.trim()
				+ "  , tranname= '" + statusname.trim()		
				+ "'  where followid ="
				+ application.getAttribute("str1")
				+strWhere2+strWhere3 ;

				int iRet = m.ModifySql(sql);

				if (iRet > 0) {
				%>
					<jsp:forward page="success.jsp"></jsp:forward>		
				<%
				} else {
				%>
					<jsp:forward page="failure.jsp"></jsp:forward>		
			<%
				}
			}
		%>
		     <input name="updatereg" type="hidden" />	
		</form>
	</body>
</html>
