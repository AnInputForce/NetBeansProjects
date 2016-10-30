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
　
function updaterecord(i)
{
    document.form1.recordindex.value=i;
    
	document.form1.postmethod.value="update";

    document.form1.submit();   
}
function selectrecord()
{	
	document.form1.postmethod.value="select";
	document.form1.submit();
}
function refreshrecord()
{	
	document.refreshform.submit();
}

function deleterecord(i)
{
	if(confirm("确认删除吗?")){
	    document.form1.postmethod.value="delete";
	    document.form1.recordindex.value=i;
		document.form1.submit();
	}
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
				String userid,typeid;			
				Manager m = Manager.getInstance();
				DBRowSet rs = null;
				int rows=0,cols=0;
				String sql = null;				
				String postmethod = null;

				String value = "";		
				String strType=null;		
			%>			
			<input name="postmethod" type="hidden" />
			<input name="recordindex" type="hidden" />		
			<%
			postmethod = request.getParameter("postmethod");

			if (postmethod == null) {
			%>		
			<table border="1" >
				<tr  align="center">
				
					<td>
						序号
					</td>
					<td>
						用户ID
					</td>
					<td>
						用户名称
					</td>
					<td>
						用户角色
					</td>
					<td>
						手机号码
					</td>
					<td>
						证件类型
					</td>
					<td>
						证件号码
					</td>
					<td>
						隶属部门
					</td>	
					<td  colspan="2">
						操  作
					</td>
				</tr>
				<%					
				    rs = m.selectSql("select "+" u.user_id,"+" u.user_name,"+" u.user_role as roleid,"
				      	+" u.user_telephone,"+" u.user_certtype as certtype, "+"u.user_certcode, "+" u.user_dept as userdept , "
				      	+" d.dept_name as deptname,  "+" r.role_name as rolename, "+" c.cert_name as certname "+"  from  mon_user u ," 
				      	+" mon_role r ,mon_certinfo c ,mon_deptinfo d "
						+"where u.user_certtype = c.cert_id  and u.user_dept=d.dept_id and r.role_id=u.user_role ");
					
					rows = rs.getRowCount();
					cols = rs.getColumnCount();					
					
					for(int r = 0; r < rows; r++){
					%>
					<tr>
						<td>
							<input  type="text" readonly="readonly"  value=<%=r+1%>  size="4">
						</td>
						<td>
							<input name=putname[<%=r%>][1]  type='text'   readonly='readonly'  size="8"
							<%
							   value = rs.getString(r,0);
													   
							   if(value==null)
							   {
							     value = "";
							   }
												  
							%>
							 <%=strType %>  value=<%=value.trim()%>   >
						</td>
						<td>
							<input name=putname[<%=r%>][2]  type='text'   readonly='readonly'  size="8"
							<%
							   value = rs.getString(r,1);
													   
							   if(value==null)
							   {
							     value = "";
							   }
													  
							%>
							 <%=strType %>  value=<%=value.trim()%>   >
						</td>
						<td>
							<select  name=putname[<%=r%>][<%=3%>]  style="width:80px"   readonly='readonly'
							<%
							   typeid = rs.getString(r,2);
							   value = rs.getString(r,8);
													   
							   if(value==null)
							   {
							     	value = "";
							   }	
							   if(typeid==null)
							   {
							     	typeid = "";
							   }	  
								%>>
							   <option value="<%=typeid.trim()%>"> <%=value.trim()%></option>						
							</select>
						</td>
						<td>
							<input name=putname[<%=r%>][4]  type='text'   readonly='readonly'  size="12"
							<%
							   value = rs.getString(r,3);
													   
							   if(value==null)
							   {
							     value = "";
							   }
							
							%>
							 <%=strType %>  value=<%=value.trim()%>   >
						</td>
						<td>
							<select  name=putname[<%=r%>][5] style="width:80px"   readonly='readonly'
							<%
							   typeid = rs.getString(r,4);
							   value = rs.getString(r,9);
													   
							   if(value==null)
							   {
							     	value = "";
							   }	
							   if(typeid==null)
							   {
							     	typeid = "";
							   }	  
							   %>>
							   <option value="<%=typeid.trim()%>"> <%=value.trim()%></option>
						
							</select>
						</td>
						<td>
							<input name=putname[<%=r%>][6]  type='text'   readonly='readonly'  size="18"
							<%
							   value = rs.getString(r,5);
													   
							   if(value==null)
							   {
							     value = "";
							   }
							  
							%>
							 <%=strType %>  value=<%=value.trim()%>   >
						</td>
						<td>
							<select  name=putname[<%=r%>][7] style="width:80px"   readonly='readonly'
							<%
							   typeid = rs.getString(r,6);
							   value = rs.getString(r,7);
													   
							   if(value==null)
							   {
							     	value = "";
							   }	
							   if(typeid==null)
							   {
							     	typeid = "";
							   }	  
							   %>>
							   <option value="<%=typeid.trim()%>"> <%=value.trim()%></option>
							</select>
						</td>			
						<td>
							<input value="修改" type="button" name=update[<%=r%>] onclick="updaterecord(<%=r%>)";>
						</td>
						<td>
							<input value="删除" type="button" name=delete[<%=r%>] onclick="deleterecord(<%=r%>)";>
						</td>
					</tr>				
				<%}%>
			</table>
			<table>
				<tr height='25'>
					<td >
						<input  type="hidden" />
					</td>	
				</tr>
				<tr>					
					<td  align="center"   >	
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;											
						<input value="刷新" type="button" class="button"
							onclick=refreshrecord();>	
					</td>
				</tr>
			
			</table>
		<%
			} 
			else if (postmethod.equals("update")) {		
			
				String str1,str2,str3,str4,str5,str6,str7;
		
				if (request.getParameter("recordindex") != null
					&& !request.getParameter("recordindex").trim().equals(""))
				{
					index = Integer.parseInt(request.getParameter("recordindex"));
					
					str1 = request.getParameter("putname[" + index + "][1]");
					
					application.setAttribute("str1", str1);
					
					str2 = encode(request.getParameter("putname[" + index + "][2]"));
					
					application.setAttribute("str2", str2);
					
					str3 = request.getParameter("putname[" + index + "][3]");
					
					application.setAttribute("str3", str3);
					
					str4 = request.getParameter("putname[" + index + "][4]");
					
					application.setAttribute("str4", str4);
					
					str5 = request.getParameter("putname[" + index + "][5]");
					
					application.setAttribute("str5", str5);
					
					str6 = encode(request.getParameter("putname[" + index + "][6]"));
					
					application.setAttribute("str6", str6);
					
					str7 = request.getParameter("putname[" + index + "][7]");
					
					application.setAttribute("str7", str7);					
				
			%>
				<script> window.open("updateuser.jsp");	</script>
			<%
				}
		%>
			<script type="text/javascript">
			    document.refreshform.submit();
			</script>
		<%
			} else if (postmethod.equals("delete")) {
				index = Integer.parseInt(request.getParameter("recordindex"));	
			
			    String str = "putname[" + index + "][1]";

		    	userid = request.getParameter(str);
			
				sql = "delete from mon_user where user_id = '" + userid.trim() + "'";

				iRet = m.ModifySql(sql);
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

