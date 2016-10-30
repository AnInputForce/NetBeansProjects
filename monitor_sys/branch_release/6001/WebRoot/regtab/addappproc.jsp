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
				String procuser,procname;
				MyManager db = MyManager.getInstance();
				String sql = null;
				String postmethod = null;
				DBRowSet rs = null;
				int rows=0,cols=0;
				String hostID=null,hostName=null;
			%>
			<table>
				<tr>
					<td>	
						设备名称
					</td>
					<td  >
						<select  name="hostid" style="width:152px" >
						<%		
							rs = db.selectSql("select hostID,hostDesc from Hosts where hostID > '0' order by hostID");
							if(rs != null)
							{
								rows = rs.getRowCount();
								cols = rs.getColumnCount(); 
								
								for(int i = 0 ; i<rows ; i++)
								{
								
									 hostID = rs.getString(i,0);
							  		 hostName = rs.getString(i,1);							   
													   
								     if(hostName==null)
								     {
								     	hostName = "";
								     }
						             %> 
						  			 <option value="<%=hostID %>"><%=hostName%></option>
						  		<%} 
							}	%>				
						</select>
					</td>	
					<td>
						进程拥有者
					</td>
					<td>
						<input name="procuser" type="text" />
					</td>
					<td>
						进程名称
					</td>
					<td>
						<input name="procname" type="text" />
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

				hostID=request.getParameter("hostid");
				procuser=encode(request.getParameter("procuser"));
				procname =encode(request.getParameter("procname"));
				
				if (procuser == null) procuser="";
				if (procname == null) procname="";
			
			
				if (!procuser.equals("")) {

					sql = "insert into appproc_reg values('" + hostID.trim()
							+ "','" + procuser.trim()
							+ "','" + procname.trim() + "')" ;

					iRet = db.ModifySql(sql);
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
			}
			%>
		</form>
	</body>
</html>

