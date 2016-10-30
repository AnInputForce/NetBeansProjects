<%@ page language="java" import="com.git.base.dbmanager.*,java.util.*,com.tools.*"
	contentType="text/html;charset=GBK"%>
<%
	int index, iRet;
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<script language="javascript" type="text/javascript">
　
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
			int  num,i = 0;
			Manager  m  = Manager.getInstance();
				
			String sql = null;
			String postmethod = null;
			Vector V_rs = new Vector();
				
			String newpasswd,cfmpasswd;
			String sid,sname,userid;
			
		%>
			<table>
			<tr>
				<td>
					用&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp户:
				</td>
				<td>
					<select name="uname">
					<%
					sql = "select user_id, user_name from mon_user";
					V_rs = m.execSQL(sql);
			
					num = V_rs.size();
					for(i=0;i<num;i++) {
						String[] arr = (String[])V_rs.elementAt(i);
						sid = arr[0];
						sname = arr[1];
				
					%>		
						<option value="<%=sid.trim() %>">
							<%=sname.trim() %>
						</option>				
					<%				
					}//end_of_for(i=0;i<num;i++)
					%>
					</select>
				</td>
			</tr>
			<tr>
				<td>
					新&nbsp&nbsp密&nbsp&nbsp码:
				</td>
				<td>
					<input name="newpasswd" type="password">
				</td>
			</tr>
			<tr>
				<td>
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
				
				newpasswd =request.getParameter("newpasswd");
				cfmpasswd=request.getParameter("cfmpasswd");					
				userid=request.getParameter("uname");
				
				if ( newpasswd.compareTo(cfmpasswd) !=0  ){
			%>
					<script type="text/javascript">
					alert("两次输入的新密码不一致,请重新输入!");
					</script>
			<%
				}else{				
					sql = "update mon_user set user_passwd ='"+MD5Util.MD5(newpasswd)+"'"+
						"where user_id = '"+userid.trim()+"'";
					iRet = m.ModifySql(sql);
					if (iRet > 0) {
					%>
						<jsp:forward page="../success.jsp"></jsp:forward>		
					<%
					} else {
					%>
						<jsp:forward page="../failure.jsp"></jsp:forward>		
					<%}%>
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

