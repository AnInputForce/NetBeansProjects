<%@ page language="java" import="com.git.base.dbmanager.*,com.tools.*,java.util.*" contentType="text/html;charset=GBK"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<script language="JavaScript" type="text/javascript">

function updatePasswd()
{	
	document.form1.postmethod.value="update";
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
	<center>
		<form name="refreshform" />
		</form>
		<form name="form1" method="post">
			<%			
				int iRet= 0;
				Manager m = Manager.getInstance();
				String sql = null;
				String postmethod = null;
				Vector v_rs = new Vector();
				
				String newpasswd,oldpasswd,cfmpasswd, sname;
				
			%>
			<table>
				<tr>
					<td align="right">
						旧&nbsp&nbsp密&nbsp&nbsp码:
					</td>
					<td>
						<input name="oldpasswd" type="password">
					</td>
				</tr>
				<tr>
					<td align="right">
						新&nbsp&nbsp密&nbsp&nbsp码:
					</td>
					<td>
						<input name="newpasswd" type="password">
					</td>
				</tr>
				<tr>
					<td align="right">
						确认新密码:
					</td>
					<td>
						<input name="cfmpasswd" type="password" />
					</td>
				</tr>
				<tr>
					<td colspan="2">
					<hr color="blue">
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input value="提 交" type="button" class="button"
							onclick=updatePasswd();>
					</td>
				</tr>
			</table>
			<input name="postmethod" type="hidden" />
		<%
			postmethod = request.getParameter("postmethod");

			if (postmethod == null) {
			
			} else if (postmethod.equals("update")) {	
				oldpasswd=request.getParameter("oldpasswd");
				newpasswd =request.getParameter("newpasswd");
				cfmpasswd=request.getParameter("cfmpasswd");	
					
				sname = (String)session.getAttribute("username");
			    
				sql = "select user_id,user_passwd from mon_user "+
					" where user_id='"+sname.trim()+"'";

				v_rs = m.execSQL(sql);
				
				String[] arr = (String[])v_rs.elementAt(0);
				
				if ( arr[1].trim().compareTo(MD5Util.MD5(oldpasswd)) != 0){
					%>
					<script type="text/javascript">
					alert("原密码不正确,请重新输入!");
					</script>
					<%
				}else if ( newpasswd.compareTo(cfmpasswd) !=0 ){
					%>
					<script type="text/javascript">
					alert("两次输入的新密码不一致,请重新输入!");
					</script>
					<%
				}else{				
					sql = "update mon_user set user_passwd ='"+MD5Util.MD5(newpasswd)+"'"+
						"where user_id = '"+sname.trim()+"'";

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
					%>
					<script type="text/javascript">
						document.refreshform.submit();
					</script>
				<%}
			}
			%>		
		</form>
	</center>
	</body>
</html>

