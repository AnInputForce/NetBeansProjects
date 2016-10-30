<%@ page language="java" import="com.git.base.dbmanager.*"
	contentType="text/html;charset=GBK"%>
<%
	String followid, status, nextstatus;
	String funcname,statusname;
	int index, iRet;
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<script language="javascript" type="text/javascript">
　
function updatewin(i)
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
function insertrecord()
{	
	document.form1.postmethod.value="insert";
	document.form1.submit();
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
				Manager m = Manager.getInstance();
				DBRowSet rs = null;
				String sql = null;
				String strSql = null;
				String postmethod = null;
				String value = "";
				String sSize = "";
				int rows=0,cols=0;
			%>
			<table>
				<tr>
					<td>
						流程号
					</td>
					<td>
						<input name="followid" type="text"  onkeyup="javascript:validateNum(document.all.followid);">
					</td>
					<td>
						当前状态
					</td>
					<td>
						<input name="curstatus" type="text" onkeyup="javascript:validateNum(document.all.curstatus);">
					</td>			
					<td>
						下一状态
					</td>
					<td>
						<input name="nextstatus" type="text"  onkeyup="javascript:validateNum(document.all.nextstatus);">
					</td>
				</tr>
				<tr>
					<td>
						函数名称
					</td>
					<td>
						<input name="funcname" type="text">
					</td>
					<td>
						状态名称
					</td>
					<td>
						<input name="statusname" type="text">
					</td>
				</tr>
				<tr>
					<td>
					</td>
					<td>
						<input value="添加" type="button" class="button"
							onclick=insertrecord();>
					</td>
					
					<td>
						<input value="查询" type="button" class="button"
							onclick=selectrecord();>
					</td>
					
					<td>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input value="刷新" type="button" class="button"
							onclick=refreshrecord();>
					</td>
				</tr>
			</table>
			<input name="postmethod" type="hidden" />
			<input name="recordindex" type="hidden" />
	
		<%
			postmethod = request.getParameter("postmethod");

			if (postmethod == null) {
			%>
		<table border=1   >
			<tr  align="center"  >
				<td  >
					序号
				</td>
				<td>
					流程号
				</td>
				<td>
					当前状态
				</td>
				<td>
					下一状态
				</td>
				<td   >
					函数名称
				</td>
				<td>
					状态名称
				</td>
				<td  colspan="2"  >
						操   作
				</td>
			</tr>
			<%
				sql = "select FOLLOWID,CURSTATUS,NEXTSTATUS,FUNCNAME,NOTE  from bat_taskoperation   ";

				rs = m.selectSql(sql);
				
				if(rs!=null){
					rows = rs.getRowCount();
					cols = rs.getColumnCount();
					for(int r=0;r<rows;r++)
					{
						
					%>
						<tr>
							<td>
								<input type="text" readonly="readonly" value=<%=r+1%> size="4" >
							</td>
						<%		
						for(int c = 0 ;c<cols;c++)
						{
						%>
						<td>
							<input name=putname[<%=r%>][<%=c+1%>]   readonly='readonly'
							<%
							   value = rs.getString(r,c);
													   
							   if(value==null)
							   {
							   	   value = "";
							   }
							   if(c==1 || c==2 || c==0)
							   { 
							       sSize = "size='8'";
							   }
							   else {
							       sSize = "";
							   }
							%>
							   value="<%=value%>" <%=sSize%>> 	
						</td>
						<%} %>
						<td>
							<input value="修改" type="button" name=update[<%=r%>] onclick="updatewin(<%=r%>)"; >
						</td>
						<td>
							<input value="删除" type="button" name=delete[<%=r%>] onclick="deleterecord(<%=r%>)";  >
						</td>
					</tr>
				<%}}%>	
		</table>
		<%
			} else if (postmethod.equals("insert")) {

				followid = request.getParameter("followid");
				status = request.getParameter("curstatus");
				nextstatus = request.getParameter("nextstatus");
				funcname = encode(request.getParameter("funcname"));
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

				if (!followid.equals("") && !status.equals("")) {
					sql = "insert into bat_taskoperation values('"
					+ followid.trim() + "','" + status.trim() + "','"
					+ nextstatus.trim() + "','" + funcname.trim()
					+ "','" + statusname.trim()+ "')";
					iRet = m.ModifySql(sql);
				}
		%>
		<script type="text/javascript">
			    document.refreshform.submit();
			</script>
		<%
			}else if (postmethod.equals("update")) {
				String str1, str2, str3, str4, str5;
				out.print(request.getParameter("recordindex"));
				if (request.getParameter("recordindex") != null
				&& !request.getParameter("recordindex").trim().equals(
						"")) {
					index = Integer.parseInt(request.getParameter("recordindex"));
					str1 = request.getParameter("putname[" + index + "][1]");
					str2 = request.getParameter("putname[" + index + "][2]");
					str3 = request.getParameter("putname[" + index + "][3]");
					str4 = encode(request.getParameter("putname[" + index + "][4]"));
					str5 = encode(request.getParameter("putname[" + index + "][5]"));

					application.setAttribute("str1", str1);
					application.setAttribute("str2", str2);
					application.setAttribute("str3", str3);
					application.setAttribute("str4", str4);
					application.setAttribute("str5", str5);
		%>
			<script> window.open("updateoperation.jsp");	</script>
		<%
			}
		%>
			<script type="text/javascript">
			    document.refreshform.submit();
			</script>
		<%
			} else if (postmethod.equals("delete")) {

				index = Integer.parseInt(request.getParameter("recordindex"));

				followid = request.getParameter("putname[" + index + "][1]");
				status = request.getParameter("putname[" + index + "][2]");

				if (followid == null)
					followid = "";
		
				sql = "delete from bat_taskoperation where followid ='"
				+ followid.trim() + "' and curstatus= '"
				+ status.trim() + "'";

				iRet = m.ModifySql(sql);
				%>
					<script type="text/javascript">
					    document.refreshform.submit();
					</script>
				<%
				} else if (postmethod.equals("select")) {

				followid = request.getParameter("followid");
				status = request.getParameter("curstatus");
				nextstatus = request.getParameter("nextstatus");
				funcname = encode(request.getParameter("funcname"));
				statusname = encode(request.getParameter("statusname"));

				strSql = "1=1";
				
				
				if (followid != null && followid.trim().length() != 0) {
					
					strSql = strSql + "  and t.followid =  " + followid;
					
				}

				if (status != null && status.trim().length() != 0) {
					
					strSql = strSql + "  and t.curstatus =  " + status;
					
				}
				if (nextstatus != null && nextstatus.trim().length() != 0) {
					
					strSql = strSql + "  and t.nextstatus =  " + nextstatus;
					
				}
				if (funcname != null && funcname.trim().length() != 0) {
					
					strSql = strSql + "  and t.funcname like '%" + funcname + "%'";
					
				}
				if (statusname != null && statusname.trim().length() != 0) {
					
					strSql = strSql + "  and t.note like '%" + statusname+ "%'";
					
				}
				
				sql = "select FOLLOWID,CURSTATUS,NEXTSTATUS,FUNCNAME,NOTE  from bat_taskoperation  t where  "+ strSql;
		%>
		<table border=1>
			<tr  align="center"   >
				<td  >
					序号
				</td>
				<td>
					流程号
				</td>
				<td>
					当前状态
				</td>
				<td>
					下一状态
				</td>
				<td>
					函数名称
				</td>
				<td>
					状态名称
				</td>
				<td  colspan="2"  >
						操   作
				</td>
			
			</tr>
			<%
				rs = m.selectSql(sql);
				if(rs!=null){
					rows = rs.getRowCount();
					cols = rs.getColumnCount();
					
					for(int r=0 ; r<rows;r++)
					{
					%>
					<tr>
						<td>
							<input  type="text" readonly="readonly"  value=<%=r+1%>  size="4">
						</td>
						<%
						for(int c = 0 ; c< cols; c++)
						{
						%>
						<td>
							<input name=putname[<%=r%>][<%=c+1%>] type="text"	readonly='readonly'
							<%
						    value = rs.getString(r,c);
																   
							if(value==null)
						    {
						     	value = "";
						    }
						  		
						    if(c==1 || c==2 || c==0)
						    { 
						       sSize = "size='8'";						      
						    }
						    else {
						       sSize = "";
						    }
							%>
					   		value="<%=value%>" <%=sSize%>>
						</td>
						<%}%>
						<td>
							<input value="修改" type="button" name=update[<%=r%>] onclick="updatewin(<%=r%>)">
		
						</td>
						<td>
							<input value="删除" type="button" name=delete[<%=r%>] onclick="deleterecord(<%=r%>)">
						</td>
				</tr>
				<%}}%>
			</table>
		<%}%>
		</form>
	</body>
</html>
