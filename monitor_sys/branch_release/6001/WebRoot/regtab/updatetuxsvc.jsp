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
						服务名
					</td>
					<td>
						<input name="servername" type="text" 
						  value=<%=application.getAttribute("str2")%>>
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
			String servername=null,strWhere=null;							
			String isUpdate = request.getParameter("updatedept");
			
			if (isUpdate != null) {
									
				hostID=request.getParameter("hostid");
				servername =encode(request.getParameter("servername"));
				
				if (hostID == null) hostID="";
				if (servername == null) servername="";
			
				if(application.getAttribute("str2")!=null &&
					!application.getAttribute("str2").equals(""))
				{
					strWhere=" and svcname='"+ application.getAttribute("str2") +"'";				
				
				}else
				{
					strWhere="";
				}		
				
				sql = "update  tux_service_reg set    svcname= '"  + servername.trim()
						+ "' ,hostID= '"+hostID.trim()+"'  where  hostID ='"
						+ application.getAttribute("str1") + "'  " +strWhere;

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
