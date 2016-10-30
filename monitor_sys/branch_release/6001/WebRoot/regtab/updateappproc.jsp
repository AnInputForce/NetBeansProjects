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
	document.form1.updatedept.value="update";
	  
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
	<%
	String procuser,procname,strWhere2,strWhere3;		
	
	%>
		<form name="form1">
			<table>
			<%
			String sql = null,hostID=null,hostDesc=null,selected=null;
			int rows=0;
			MyManager m = MyManager.getInstance();
			DBRowSet rs =null;
			
			%>
				<tr>	
					<td>
						<select  name="hostid" style="width:122px"  >
						<%		
							sql = "select hostID,hostDesc from   Hosts  where hostID > 0 ";
											
							rs = m.selectSql(sql);
							if(rs != null)
							{
								rows = rs.getRowCount();
								
								for(int i = 0 ; i< rows ; i++)
								{
								
									 hostID = rs.getString(i,0);
							  		 hostDesc = rs.getString(i,1);							   
													   
								     if(hostDesc==null)
								     {
								     	hostDesc = "";
								     }
								     if(hostID.trim().equals((String)application.getAttribute("str1")))
								     {
							   	 		selected="selected='selected'";					   
							   	     }else
								     {
								   	 	selected="";							   
								   	 }
							         %> 
						  			 <option value="<%=hostID %>" <%=selected %> ><%=hostDesc%></option>
						  		<%} 
							}	%>				
						</select>
						
					</td>
					<td>
						进程拥有者
					</td>
					<td>
						<input name="procuser" type="text" 
						  value=<%=application.getAttribute("str2")%>>
					</td>
					<td>
						进程名称
					</td>
					<td>
						<input name="procname" type="text" 
						  value=<%=application.getAttribute("str3")%>>
					</td>
				
				</tr>		
				<tr    height='25'>
					<td >
						<input  type="hidden" />
					</td>	
				</tr>	
				<tr  >
					<td >
						<input  type="hidden" />
					</td>	
					
					<td  align="center"  >		
								
						<input value="提交" type="button" class="button"
							onclick=updaterecord();>
					</td>
				</tr>
			</table>
		
		<%
					
			String isUpdate = request.getParameter("updatedept");
			
			if (isUpdate != null) {
									
				hostID=request.getParameter("hostid");
				procuser=request.getParameter("procuser");
				procname =encode(request.getParameter("procname"));
				
				if (hostID == null) hostID="";
				if (procuser == null) procuser="";
				if (procname == null) procname="";
			
				
				if(application.getAttribute("str2")!=null &&
					!application.getAttribute("str2").equals(""))
				{
					strWhere2=" and procUID='"+ application.getAttribute("str2") +"'";				
				
				}else
				{
					strWhere2="";
				}		
				if(application.getAttribute("str3")!=null &&
					!application.getAttribute("str3").equals(""))
				{
					strWhere3=" and procName='"+ application.getAttribute("str3") +"'";				
				
				}else
				{
					strWhere3="";
				}		
			
				sql = "update  appproc_reg set    hostID= '" + hostID.trim()
				+ "'  , procUID= '" + procuser.trim()	
				+ "'  , procName= '" + procname.trim()			
				+ "'  where hostID ='"
				+ application.getAttribute("str1") + "' " 
				+ strWhere2 + strWhere3 ;

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
		     <input name="updatedept" type="hidden" />	
		</form>
	</body>
</html>
