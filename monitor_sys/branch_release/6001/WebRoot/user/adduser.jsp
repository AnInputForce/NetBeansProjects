<%@ page language="java" import="com.git.base.dbmanager.*,com.tools.MD5Util"
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
	<body>
		<form name="refreshform" />
		</form>
		<form name="form1" method="post">
		<%				
			String userid,username,telephone,roletype;
			String certtype,certcode,userdept;
			String deptid,deptname;
			String certid,certname;
			String roleid,rolename;
			Manager m = Manager.getInstance();
			DBRowSet rs = null;
			int rows=0,cols=0;
			String sql = null;
			String strPass = MD5Util.MD5("123456");
			String postmethod = null;			
		%>
			<table>
				<tr>
					<td>
						用户ID
					</td>
					<td>
						<input name="userid" type="text" >
					</td>
					<td>
						用户名称
					</td>
					<td>
						<input name="username" type="text" />
					</td>		
					<td>	
						用户角色
					</td>
					<td  >
						<select  name="roletype" style="width:152px" >
						<%		
							rs = m.selectSql("select role_id,role_name from  mon_role order by role_id");
							if(rs != null)
							{
								rows = rs.getRowCount();
								cols = rs.getColumnCount(); 
								
								for(int i = 0 ; i<rows ; i++)
								{
								
									 roleid = rs.getString(i,0);
							  		 rolename = rs.getString(i,1);							   
													   
								     if(rolename==null)
								     {
								     	rolename = "";
								     }
						             %> 
						  			 <option value="<%=roleid %>"><%=rolename%></option>
						  		<%} 
							}	%>				
						</select>
					</td>							
				</tr>
				<tr>				
					<td>	
						隶属部门
					</td>
					<td  >
						<select  name="userdept" style="width:152px" >
						<%						
							rs = m.selectSql("select dept_id , dept_name from  mon_deptinfo order by dept_id");
							if(rs != null)
							{
								rows = rs.getRowCount();
								cols = rs.getColumnCount(); 
								
								for(int i = 0 ; i<rows ; i++)
								{
									 deptid = rs.getString(i,0);
							  		 deptname = rs.getString(i,1);							   
													   
								     if(deptname==null)
								     {
								     	deptname = "";
								     }
						             %> 
						  			 <option value="<%=deptid %>"><%=deptname.trim()%></option>
						  		<%}
							}		 %>			
						</select>
					</td>
			
					<td>
						证件类型
					</td>
					<td  >
						<select  name="certtype"  style="width:152px">
						<%
							rs = m.selectSql("select cert_id,cert_name  from  mon_certinfo order by cert_id");
							if(rs != null)
							{
								rows = rs.getRowCount();
								cols = rs.getColumnCount(); 
								
								for(int i = 0 ; i<rows ; i++)
								{								
									 certid = rs.getString(i,0);
							  		 certname = rs.getString(i,1);							   
													   
								     if(certname==null)
								     {
								     	certname = "";
								     }
									%> 
									  <option value="<%=certid %>" ><%=certname%></option>
								<%} 
							}%>
						</select>
					</td>
					<td>
						证件号码
					</td>
					<td>
						<input name="certcode" type="text" >
					</td>
							
				</tr>
				<tr>
					<td>
						手机号码
					</td>
					<td>
						<input name="telephone" type="text" onkeyup="javascript:validateNum(document.all.telephone);">
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

				userid=request.getParameter("userid");
				username =encode(request.getParameter("username"));
				roletype =request.getParameter("roletype");
				telephone=request.getParameter("telephone");
				certtype =encode(request.getParameter("certtype"));
				certcode=request.getParameter("certcode");
				userdept =encode(request.getParameter("userdept"));
			
			
				if (userid == null) userid="";
				if (username == null) username="";
				if (telephone == null) telephone="";
				if (roletype == null) roletype="";
				if (certtype == null) certtype="";
				if (certcode == null) certcode="";
				if (userdept == null) userdept="";
					
						
			
				if (!userid.equals("")) {

					sql = "insert into mon_user(user_id,user_name,user_telephone,"
						+"user_certtype,user_certcode,user_role,user_dept,user_passwd) "
						+"values('" + userid.trim()
							+ "','" + username.trim() 
							+ "','" + telephone.trim()
							+ "','" + certtype.trim()
							+ "','" + certcode.trim()
							+ "','" + roletype.trim()
							+ "','" + userdept.trim()
							+ "','"+ strPass.trim()+"')" ;
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
			<%
			}
			%>
		</form>
	</body>
</html>

