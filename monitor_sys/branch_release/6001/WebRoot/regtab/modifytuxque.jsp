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
				String tuxsrvname;			
				int  rows,cols;
				MyManager  db =  MyManager.getInstance();
				String sql = null;
				DBRowSet rs=null;
				String postmethod = null;
				String value = "",hostID=null;		
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
						设备名称
					</td>
					<td>
						服务进程名称
					</td>				
					<td  colspan="2">
						操  作
					</td>
				</tr>
				<%	
					sql="select r.hostID,r.srvname ,h.hostDesc from  tux_que_reg r, Hosts h where h.hostID = r.hostID ";				
				   	rs = db.selectSql(sql);
					cols = rs.getColumnCount();
					rows = rs.getRowCount();
				 	for(int i =0; i<rows;i++){
				%>
				<tr>
					<td>
						<input  type="text" readonly="readonly"  value=<%=i+1%>  >
					</td>
					<td>
						<select  name=putname[<%=i%>][0]  style="width:150px"   readonly='readonly'
						<%
						   hostID = rs.getString(i,0);
						   value = rs.getString(i,2);
												   
						   if(value==null)
						   {
						     	value = "";
						   }	
						   if(hostID==null)
						   {
						     	hostID = "";
						   }	  
							%>>
						   <option value="<%=hostID.trim()%>"> <%=value.trim()%></option>						
						</select>
					</td>
					<%
					for (int j = 1; j < cols-1; j++) {
					%>
					<td>
						<input name=putname[<%=i%>][<%=j%>]   type='text'   readonly='readonly'
						<%
						   value = rs.getString(i,j);
												   
						   if(value==null)
						   {
						     value = "";
						   }
						%>
						   value=<%=value.trim()%>   >
					</td>
					<%
					}
					%>
					<td>
						<input value="修改" type="button" name=update[<%=i%>] onclick="updaterecord(<%=i%>)";>

					</td>
					<td>
						<input value="删除" type="button" name=delete[<%=i%>] onclick="deleterecord(<%=i%>)";>
					</td>
				</tr>
				<%
				
				}
				%>
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
			
				String str1,str2;
		
				if (request.getParameter("recordindex") != null
					&& !request.getParameter("recordindex").trim().equals(""))
				{
					index = Integer.parseInt(request.getParameter("recordindex"));
					
					str1 = request.getParameter("putname[" + index + "][0]");
					str2 = encode(request.getParameter("putname[" + index + "][1]"));
					
					application.setAttribute("str1", str1);
					application.setAttribute("str2", str2);
					
			%>
				<script> window.open("updatetuxque.jsp");	</script>
			<%
				}
		%>
			<script type="text/javascript">
			    document.refreshform.submit();
			</script>
		<%
			} else if (postmethod.equals("delete")) {
				index = Integer.parseInt(request.getParameter("recordindex"));	
			
			    String str = "putname[" + index + "][0]";			 
		    	hostID = request.getParameter(str);
		    	str = "putname[" + index + "][1]";			 
		    	tuxsrvname = request.getParameter(str);
				sql = "delete from tux_que_reg where  srvname= '" + tuxsrvname.trim() + "' and hostID= '" + hostID.trim()+ "'";
		System.out.println(sql);	
				iRet = db.ModifySql(sql);
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

