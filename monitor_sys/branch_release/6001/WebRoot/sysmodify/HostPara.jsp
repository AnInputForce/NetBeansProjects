<%@ page language="java" import="com.git.base.dbmanager.*,java.util.*"
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
				String sysid,sysname,sysip,sysport,sysmsgid;
				String sysuser,syspasswd,sysdir,sysfilename;
				
				int  rows=0,cols=0;
				Manager m = Manager.getInstance();
				DBRowSet rs = null;
				String sql = null;
				String strSql = null;
				String postmethod = null;
				
				String value = "";
				String sSize = "";
			%>
			<table>
				<tr>
					<td>
						系统ID
					</td>
					<td>
						<input name="sysid" type="text" onkeyup="javascript:validateNum(document.all.sysid);">
					</td>
					<td>
						系统名称
					</td>
					<td>
						<input name="sysname" type="text" />
					</td>
					<td>
						系统IP
					</td>
					<td>
						<input name="sysip" type="text"  size="18"/>
					</td>
				</tr>
				<tr>
					<td>
						端口号
					</td>
					<td>
						<input name="sysport" type="text" onkeyup="javascript:validateNum(document.all.sysport);">
					</td>

					<td>
						用户名
					</td>
					<td>
						<input name="sysuser" type="text" />
					</td>

					<td>
						用户密码
					</td>
					<td>
						<input name="syspasswd" type="password" size="19"/>
					</td>
				</tr>
				<tr>
					<td>
						路径
					</td>
					<td>
						<input name="sysdir" type="text" />
					</td>
					<td>
						文件名
					</td>
					<td>
						<input name="sysfilename" type="text" />
					</td>
						
					<td>
						<input value="添加" type="button" class="button"
							onclick=insertrecord();>
					</td>
				
					<td>
						<input value="查询" type="button" class="button"
							onclick=selectrecord();>
							&nbsp;
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
			<table border="1" >
				<tr  align="center">
					<td>
						序号
					</td>
					<td>
						系统ID
					</td>
					<td>
						系统名称
					</td>
					<td>
						系统IP
					</td>
					<td>
						端口号
					</td>
					<td>
						用户名
					</td>
					<td>
						用户密码
					</td>
					<td>
						路径
					</td>
					<td>
						文件名
					</td>
					<td>
						消息编号
					</td>
					<td  colspan="2">
						操  作
					</td>
				</tr>
				<%
					
					rs = m.selectSql("select sysid , sysname, ipaddr,port,loguser,passwd,dir,fname,smsgid from  hostpara");
					if(rs!=null){
					rows = rs.getRowCount();
					cols = rs.getColumnCount();
					
					for(int r=0 ; r< rows;r++)
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
									<input name=putname[<%=r%>][<%=c+1%>]  size="8" readonly='readonly'
									<%
									   value = rs.getString(r,c);
															   
									   if(value==null)
									   {
									     value = "";
									   }
									  
									   String strTpye;
									   if(c==5)
									   {
									      strTpye = " type='password'";						   
									   }
									   else {
									      strTpye = " type='text'";						   
									   }
			
									%>
									  <%= strTpye%>  value=<%=value.trim()%>   >	
								</td>
							<%} %>
							<td>
								<input value="修改" type="button" name=update[<%=r%>] onclick="updaterecord(<%=r%>)";>
							</td>
							<td>
								<input value="删除" type="button" name=delete[<%=r%>] onclick="deleterecord(<%=r%>)";>
							</td>
						</tr>
					<%}}%>
			</table>
		<%
			} else if (postmethod.equals("insert")) {

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
			
			if (!sysid.equals("")) {

				sql = "insert into hostpara values('" + sysid.trim()
						+ "','" + sysname.trim() + "','" + sysip.trim() + "','" 
						+ sysport.trim()+ "','" + sysuser.trim() + "','" 
						+ syspasswd.trim() + "','" + sysdir.trim()
						+ "','" + sysfilename.trim() + "'," + '0' +  ")";

				iRet = m.ModifySql(sql);
			}			
		%>
		<script type="text/javascript">
			document.refreshform.submit();
		</script>
		<%
		}
			else if (postmethod.equals("update")) {		
			
				String str1, str2, str3, str4,str5,str6,str7,str8;
		
				if (request.getParameter("recordindex") != null
					&& !request.getParameter("recordindex").trim().equals(""))
				{
					index = Integer.parseInt(request.getParameter("recordindex"));
					
					str1 = request.getParameter("putname[" + index + "][1]");
					str2 = encode(request.getParameter("putname[" + index + "][2]"));
					str3 = request.getParameter("putname[" + index + "][3]");
					str4 = request.getParameter("putname[" + index + "][4]");
					str5 = encode(request.getParameter("putname[" + index + "][5]"));
					str6 = request.getParameter("putname[" + index + "][6]");
					str7 = request.getParameter("putname[" + index + "][7]");
					str8=  encode(request.getParameter("putname[" + index + "][8]"));				
				
					application.setAttribute("str1", str1);
					application.setAttribute("str2", str2);
					application.setAttribute("str3", str3);
					application.setAttribute("str4", str4);
					application.setAttribute("str5", str5);
					application.setAttribute("str6", str6);
					application.setAttribute("str7", str7);
					application.setAttribute("str8", str8);	
					
			%>
				<script> window.open("updatehostpara.jsp");	</script>
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
			
		    	sysid = request.getParameter(str);
			
				sql = "delete from hostpara where sysid = '" + sysid.trim() + "'";
			
				iRet = m.ModifySql(sql);
				%>
				<script type="text/javascript">
				    document.refreshform.submit();
				</script>
		<%              
				} else if (postmethod.equals("select")) {

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
			

				if ( sysid.trim().length() != 0) {
					strSql = "   t.sysid = " + sysid ;
				}

				if ( sysname.trim().length() != 0) {
					if (strSql != null)
						strSql = strSql + "  and t.sysname like '%" + sysname + "%'";
					else
						strSql = "   t.sysname like '%" + sysname + "%'";
				}
				if ( sysip.trim().length() != 0) {
					if (strSql != null)
						strSql = strSql + "  and t.ipaddr =  '" + sysip+"'";
					else
						strSql = "  t.ipaddr =  '" + sysip+"'";
				}
				if (sysport.trim().length() != 0) {
					if (strSql != null)
						strSql = strSql + "  and t.port =" + sysport;
					else
						strSql = "    t.port =" + sysport;
				}
	
				if ( sysuser.trim().length() != 0) {
					if (strSql != null)
						strSql = strSql + "  and t.loguser =  '" + sysuser+"'";
					else
						strSql = "  t.loguser =  '" + sysuser+"'";
				}
				if ( syspasswd.trim().length() != 0) {
					if (strSql != null)
						strSql = strSql + "  and t.passwd =  '" + syspasswd+"'";
					else
						strSql = "  t.passwd = '" + syspasswd+"'";
				}
				if (sysdir.trim().length() != 0) {
					if (strSql != null)
						strSql = strSql + "  and t.dir like '%" + sysdir+ "%'";
					else
						strSql = "    t.dir like '%" + sysdir + "%'";
				}
				if (sysfilename.trim().length() != 0) {
					if (strSql != null)
						strSql = strSql + "  and t.fname like '%" + sysfilename+ "%'";
					else
						strSql = "    t.fname like '%" + sysfilename + "%'";
				}
				if (strSql == null) {
					strSql = "1=1";
				}

				sql = "select sysid , sysname, ipaddr,port,loguser,passwd,dir,fname,smsgid from  hostpara t where  " + strSql;
			%>
			<table border=1>
				<tr  align="center">
					<td>
						序号
					</td>
					<td>
						系统ID
					</td>
					<td>
						系统名称
					</td>
					<td>
						系统IP
					</td>
					<td>
						端口号
					</td>
					<td>
						用户名
					</td>
					<td>
						用户密码
					</td>
					<td>
						路径
					</td>
					<td>
						文件名
					</td>
					<td>
						消息编号
					</td>
					<td  colspan="2">
						操  作
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
									<input name=putname[<%=r%>][<%=c+1%>]  size="8" readonly='readonly'
									<%
									   value = rs.getString(r,c);
															   
									   if(value==null)
									   {
									     value = "";
									   }
									  
									   String strTpye;
									   if(c==5)
									   {
									      strTpye = " type='password'";						   
									   }
									   else {
									      strTpye = " type='text'";						   
									   }
			
									%>
									  <%= strTpye%>  value=<%=value.trim()%>   >	
								</td>
							<%} %>
							<td>
								<input value="修改" type="button" name=update[<%=r%>] onclick="updaterecord(<%=r%>)";>
							</td>
							<td>
								<input value="删除" type="button" name=delete[<%=r%>] onclick="deleterecord(<%=r%>)";>
							</td>
						</tr>
					<%}}%>				
			</table>
		<%}%>
		</form>
	</body>
</html>

