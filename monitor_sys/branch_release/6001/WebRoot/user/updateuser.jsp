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
		<%
			String userid,username,userrole,userdept,certtype,certcode,usertelephone;
			Manager m = Manager.getInstance();
			DBRowSet rs = null;
			int rows=0,cols=0;
			String certid,certname;
			String roleid,rolename;	
			String deptid,deptname;		
			String selected="";	
		%>
			<table>
				<tr>
					<td>
						用户ID
					</td>
					<td>
						<input name="userid" type="text" value=<%=application.getAttribute("str1")%> >
					</td>
					<td>
						用户名称
					</td>
									
					<td>
						<input name="username" type="text" value=<%=application.getAttribute("str2")%> >
					</td>		
					<td>	
						用户角色
					</td>
					<td  >
						<select  name="roletype" style="width:122px"  >
						<%						
							rs = m.selectSql("select role_id,role_name from  mon_role order by role_id");
							if(rs != null)
							{
								rows = rs.getRowCount();
								cols = rs.getColumnCount(); 
								
								for(int i = 0 ; i< rows ; i++)
								{
								
									 roleid = rs.getString(i,0);
							  		 rolename = rs.getString(i,1);							   
													   
								     if(rolename==null)
								     {
								     	rolename = "";
								     }
								     if(roleid.trim().equals((String)application.getAttribute("str3")))
								     {
							   	 		selected="selected='selected'";					   
							   	     }else
								     {
								   	 	selected="";							   
								   	 }
							         %> 
						  			 <option value="<%=roleid %>" <%=selected %> ><%=rolename%></option>
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
						             if(deptid.trim().equals((String)application.getAttribute("str7")))
						             {
									   	 selected="selected='selected'";					   
			    					 }else
							   		 {
									   	 selected="";							   
									 }
									 %> 
						  			 <option value="<%=deptid %>"  <%=selected %> ><%=deptname%></option>
						  		<%}} %>
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
									 if(certid.trim().equals((String)application.getAttribute("str5")))
									 {
									   	selected="selected='selected'";	
								     }else
							   		 {
							   	 		selected="";							   
							   		 }
									 %> 
						  			 <option value="<%=certid %>" <%=selected %> ><%=certname%></option>
						  		<%} 
						  	}%>
						</select>						
					</td>
					<td  >
						证件号码
					</td>
					<td>
						<input name="certcode" type="text"  value=<%=application.getAttribute("str6")%> >
					</td>
							
				</tr>
				<tr>
					<td>
						手机号码
					</td>
					<td>
						<input size="12"  name="telephone" type="text"   onkeyup="javascript:validateNum(document.all.telephone);" value=<%=application.getAttribute("str4")%>  >
					</td>
					
				</tr>	
				<tr    height='25'>
					<td >
						<input  type="hidden" />
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
			String strWhere;
			String isUpdate = request.getParameter("updaterole");
			
			if (isUpdate != null) {
									
				userid=request.getParameter("userid");
				username =encode(request.getParameter("username"));
				userrole =request.getParameter("roletype");
				userdept =request.getParameter("userdept");
				certtype =request.getParameter("certtype");
				certcode =request.getParameter("certcode");
				usertelephone =request.getParameter("telephone");
				
				if (userid == null) userid="";
				if (username == null) username="";
				if (userrole == null) userrole="";
				if (userdept == null) userdept="";
				if (certtype == null) certtype="";
				if (certcode == null) certcode="";
				if (usertelephone == null) usertelephone="";
						
				strWhere= " user_id='"+ ((String)application.getAttribute("str1")).trim() +"'";				
				
				String sql = "update  mon_user set    user_id= '" + userid.trim()
				+ "'  , user_name= '" + username.trim()
				+ "'  , user_role= '" + userrole.trim()
				+ "'  , user_dept= '" + userdept.trim()
				+ "'  , user_certtype= '" + certtype.trim()
				+ "'  , user_certcode= '" + certcode.trim()
				+ "'  , user_telephone= '" + usertelephone.trim()
				+ "'  where  "+strWhere;
				
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
