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
	document.form1.updatehostpara.value="update";
	  
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
						系统ID
					</td>
					<td>
						<input name="sysid" type="text" 
						  value=<%=application.getAttribute("str1")%>>
					</td>
					<td>
						系统名称
					</td>
					<td>
						<input name="sysname" type="text" 
						  value=<%=application.getAttribute("str2")%>>
					</td>
					<td>
						系统IP
					</td>
					<td>
						<input name="sysip" type="text"  size="18"
						  value=<%=application.getAttribute("str3")%>>
					</td>
				</tr>
				<tr>
					<td>
						端口号
					</td>
					<td>
						<input name="sysport" type="text" 
						  value=<%=application.getAttribute("str4")%>>
					</td>

					<td>
						用户名
					</td>
					<td>
						<input name="sysuser" type="text" 
						  value=<%=application.getAttribute("str5")%>>
					</td>

					<td>
						用户密码
					</td>
					<td>
						<input name="syspasswd" type="password" size="19"
						  value=<%=application.getAttribute("str6")%>>
					</td>
				</tr>
				<tr>
					<td>
						路径
					</td>
					<td>
						<input name="sysdir" type="text" 
						  value=<%=application.getAttribute("str7")%>>
					</td>
					<td>
						文件名
					</td>
					<td>
						<input name="sysfilename" type="text"  
						  value=<%=application.getAttribute("str8")%>>
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
		
		<%
			String sysid,sysname,sysip,sysport,sysmsgid;
			String sysuser,syspasswd,sysdir,sysfilename;
			String strWhere2,strWhere3,strWhere4,strWhere5;
			String strWhere6,strWhere7,strWhere8,strWhere9;
			Manager m = Manager.getInstance();
				
			String isUpdate = request.getParameter("updatehostpara");
			
			if (isUpdate != null) {
									
				sysid=request.getParameter("sysid");
				sysname =encode(request.getParameter("sysname"));
				sysip=request.getParameter("sysip");
				sysport=request.getParameter("sysport");
				
				sysuser=encode(request.getParameter("sysuser"));
				syspasswd=request.getParameter("syspasswd");
				sysdir=request.getParameter("sysdir");
				sysfilename=encode(request.getParameter("sysfilename"));
	
				if (sysid == null) sysid="";
				if (sysname == null) sysname="";
				if (sysip == null) sysip="";
				if (sysport == null) sysport="";
				if (sysuser == null) sysuser="";
				if (syspasswd == null) syspasswd="";
				if (sysdir == null) sysdir="";
				if (sysfilename == null) sysfilename="";
				
				if(application.getAttribute("str2")!=null &&
					!application.getAttribute("str2").equals(""))
				{
					strWhere2=" and sysname='"+ application.getAttribute("str2") +"'";				
				
				}else
				{
					strWhere2="";
				}
				if(application.getAttribute("str3")!=null &&
					!application.getAttribute("str3").equals(""))
				{
					strWhere3=" and ipaddr='"+ application.getAttribute("str3") +"'";				
				 
				}else
				{
					strWhere3="";
				}
				if(application.getAttribute("str4")!=null &&
					!application.getAttribute("str4").equals(""))
				{
					strWhere4=" and port='"+ application.getAttribute("str4") +"'";				
				
				}else
				{
					strWhere4="";
				}
				if(application.getAttribute("str5")!=null &&
					!application.getAttribute("str5").equals(""))
				{
					strWhere5=" and loguser='"+ application.getAttribute("str5") +"'";				
				
				}else
				{
					strWhere5="";
				}
				if(application.getAttribute("str6")!=null &&
					!application.getAttribute("str6").equals(""))
				{
					strWhere6=" and passwd='"+ application.getAttribute("str6") +"'";				
				
				}else
				{
					strWhere6="";
				}
				if(application.getAttribute("str7")!=null &&
					!application.getAttribute("str7").equals(""))
				{
					strWhere7=" and dir='"+ application.getAttribute("str7") +"'";				
				
				}else
				{
					strWhere7="";
				}
				
				if(application.getAttribute("str8")!=null &&
					!application.getAttribute("str8").equals(""))
				{
					strWhere8=" and fname='"+ application.getAttribute("str8") +"'";				
				
				}else
				{
					strWhere8="";
				}
				
				String sql = "update  hostpara set    sysid= '" + sysid.trim()
				+ "'  , sysname= '" + sysname.trim()
				+ "'  , ipaddr= '" + sysip.trim()
				+ "'  , port= '" + sysport.trim()			
				+ "'  , loguser= '" + sysuser.trim()
				+ "'  , passwd= '" + syspasswd.trim()
				+ "'  , dir= '" + sysdir.trim()
				+ "'  , fname= '" + sysfilename.trim()
				+ "'  where sysid ='"
				+ application.getAttribute("str1") + "' " 
				+ strWhere2 +strWhere3 +strWhere4 +strWhere5 +strWhere6 +strWhere7 +strWhere8;

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
		     <input name="updatehostpara" type="hidden" />	
		</form>
	</body>
</html>
