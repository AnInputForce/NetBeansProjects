<%@ page language="java" import="com.git.base.dbmanager.*"
	contentType="text/html;charset=GBK"%>
<%
	int index, iRet;
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<script language="javascript" type="text/javascript">
　

function refreshrecord()
{	
	document.refreshform.submit();
}
function insertrecord()
{	
	document.form1.postmethod.value="insert";
	document.form1.submit();
}

function validateNum(text)
{
   if(!isnum(text.value))
   {
     alert("该文本框只能输入数字!");
     text.value = "";
   }
}
function validateInt(text)
{
   if(!isInt(text.value))
   {
     alert("该文本框只能输入数字或者负号!");
     text.value = "";
   }
}
function isInt(str)
	{
		rset="";
		for(i=0;i<str.length;i++)
		{
			if((str.charAt(i)>="0" && str.charAt(i)<="9")||str.charAt(i)=="-")
			{
			}
			else
			{
				return false;
			}
		}
		return true;
	}
function isnum(str)
	{
		rset="";
		for(i=0;i<str.length;i++)
		{
			if(str.charAt(i)>="0" && str.charAt(i)<="9")
			{
			}
			else
			{
				return false;
			}
		}
		return true;
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
		<form name="refreshform" />
		</form>
		<form name="form1" method="post">
			<%				
				String roleid,rolename;
				Manager m = Manager.getInstance();	
				String sql = null;
				String postmethod = null;
			%>
			<table>
				<tr>
					<td>
						角色ID
					</td>
					<td>
						<input name="roleid" type="text" onkeyup="javascript:validateNum(document.all.roleid);">
					</td>
					<td>
						角色名称
					</td>
					<td>
						<input name="rolename" type="text" />
					</td>
				
				</tr>
				<tr height='25'>				
					<td  >
						<input  type="hidden" />
					</td>				
				</tr>
				
				<tr>				
					<td>
						<input  type="hidden" />
					</td>
					<td align="center">
						<input value="添加" type="button" class="button"
							onclick=insertrecord();>
					</td>
				</tr>
			</table>
			<input name="postmethod" type="hidden" />
			<input name="recordindex" type="hidden" />		
		<%
			postmethod = request.getParameter("postmethod");

			if (postmethod == null) {
		
			} else if (postmethod.equals("insert")) {

				roleid=request.getParameter("roleid");
				rolename =encode(request.getParameter("rolename"));
				
				if (roleid == null) roleid="";
				if (rolename == null) rolename="";		
			
			if (!roleid.equals("")) {
				sql = "insert into mon_role values('" + roleid.trim()
						+ "','" + rolename.trim() + "')" ;
				iRet = m.ModifySql(sql);
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
		<script type="text/javascript">
			document.refreshform.submit();
		</script>
		<%}%>
		</form>
	</body>
</html>

