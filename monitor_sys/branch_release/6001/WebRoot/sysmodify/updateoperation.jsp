<%@ page language="java" import="com.git.base.dbmanager.*"
	contentType="text/html;charset=GBK"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<script language="javascript">
function updaterecord(i)
{
	document.form1.updateoperation.value="update";
	  
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
						流程号
					</td>
					<td>
						<input name="followid" type="text"
							value=<%=application.getAttribute("str1")%>>
					</td>
					<td>
						当前状态
					</td>
					<td>
						<input name="curstatus" type="text"
							value=<%=application.getAttribute("str2")%>>
					</td>
				
					<td>
						下一状态
					</td>
					<td>
						<input name="nextstatus" type="text"
							value=<%=application.getAttribute("str3")%>>
					</td>
				</tr>
				<tr>
					<td>
						函数名称
					</td>
					<td>
						<input name="funcname" type="text"
							value=<%=application.getAttribute("str4")%>>
					</td>
					<td>
						状态名称
					</td>
					<td>
						<input name="statusname" type="text"
							value=<%=application.getAttribute("str5")%>>
					</td>
				</tr>
				<tr>
					<td>
					</td>
					<td>
						<input value="提交" type="button" class="button"
							onclick=updaterecord();>
					</td>
					<td>

					</td>

				</tr>

			</table>
			<input name="updateoperation" type="hidden" />
		</form>
		<form name="refreshform" />
		</form>

		<%
			String followid, status, nextstatus, funcname,statusname;

			String isUpdate = request.getParameter("updateoperation");
			if (isUpdate != null) {
				followid = request.getParameter("followid");
				status = request.getParameter("curstatus");
				nextstatus = request.getParameter("nextstatus");
				funcname = request.getParameter("funcname");
				statusname = encode(request.getParameter("statusname"));

				if (followid == null)
					followid = "";
				if (status == null)
					status = "";
				if (nextstatus == null)
					nextstatus = "";
				if (funcname == null)
					funcname = "";
				if (statusname == null)
					statusname = "";

				Manager m = Manager.getInstance();
				
				String sql = "update  bat_taskoperation set   followid= '"
				+ followid.trim() + "'  , curstatus= '" + status.trim()
				+ "'  , nextstatus= '" + nextstatus.trim()
				+ "'  , funcname= '" + funcname.trim()
				+ "'  , note= '" + statusname.trim()
				+ "'  where followid ='"
				+ application.getAttribute("str1")
				+ "' and curstatus= '"
				+ application.getAttribute("str2")
				+ "' and nextstatus= '"
				+ application.getAttribute("str3")
				+ "' and funcname= '"
				+ application.getAttribute("str4")
				+ "' and note= '"
				+ application.getAttribute("str5") + "'";

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
	</body>
</html>
