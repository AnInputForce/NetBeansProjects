<%@ page language="java" import="com.git.base.dbmanager.*,com.app.RefreshData"
	contentType="text/html;charset=GBK"%>

<script language="javascript">
function refresh()
{		
	document.form.submit();
}
</script>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<style>
			.inputNoBorder{			
				 border-style:none;
				 border-width:0px;			
			} 
       	</style>      		
	</head>
	<body>  
		<form name="form" method="post" action="./FileSysDetail.jsp?rData=yes">
			 <input type="hidden" name="rData" value="">
			   
			<%
				String  sql, value;
				MyManager  db = MyManager.getInstance();
				int  rows,cols;
				int iCurFlag=0;
				String strBgColor="style=' background-color: green'";
				DBRowSet rs=null;	
				String rData = request.getParameter("rData");
				
				//System.out.println("rdata------"+rData);
				if(rData!=null && rData.trim().equals("yes"))
				{
					//System.out.println("begin");	
					RefreshData.refreshData("/home/monitor/cacti/monitor_poll/poller.sh");	
					//System.out.println("over");	
				}	
				
			%>
			
			<table>				
				<tr >
					<td>
					   <input type="button" name="Submit" value="刷新" onclick=refresh()>
					</td>			
				</tr>
			</table>				
	        <hr/>
	         <tr>
	         	<input  type="label"  size="4"  disabled="disabled" <%out.print("style=' background-color: green'");%> >运行正常	 
	         	<input  type="label"  size="4"  disabled="disabled" <% out.print("style=' background-color: red'");%> >运行失败 
	         	<input  type="label"  size="4"  disabled="disabled" <% out.print("style=' background-color: #FFA500'");%> >运行告警                	
	         </tr>  
	        <hr/>	          
			<table  border=1 cellspacing="0" cellpadding="0" >
				  <tr bgcolor="#99CCCC">
				   	 <th width='8%'>
	                         系统名称
	                 </th>
	                 <th width='18%'>
	                         安装目录
	                 </th>
	                  <th width='14%'>
	                         设备名称
	                 </th>
	                 <th>
	                         容量大小(KB)
	                 </th>
	                 <th>
	                         已使用(KB)
	                 </th>
	                 <th>
	                         可使用(KB)
	                 </th>
	                 <th>
	                         使用率(%)
	                 </th>
	                 <th width="10%">
	                         更新时间
	                 </th>
	                 <th width="5%">
	                         报警标志
	                 </th>
	                 <th width='12%'>
	                         备注
	                 </th>
				</tr>
				<%					
				sql="select h.hostDesc, t.fspath,t.fsname,t.fssize,t.usedsize,t.freesize,t.usedrate,t.updatetime,"
					+ " t.alertflag ,t.alertcontent from filesys_data t  , Hosts h where h.hostID=t.hostID";

				rs = db.selectSql(sql);
				cols = rs.getColumnCount();
				rows = rs.getRowCount();
				for(int r = 0;r < rows ; r++) {				
					iCurFlag = rs.getInt(r,"alertflag");

					if(iCurFlag==3){
						strBgColor="style=' background-color: red'";
					}else if(iCurFlag==2){
						strBgColor="style=' background-color: #ffa500'";
					}else{
						strBgColor="style=' background-color: green'";
					}
					%>
					<tr align="right" <%=strBgColor %>>
					<%				
					for (int c = 0; c < cols; c++) {						
					%>
						<td style="color:#FFFFFF">
						<%
							value = rs.getString(r,c);
						    if (value == null) {
								value = "";
							}						
						%><%=value %>
						</td>
					<%}%>	
					</tr>
			    <%}%>
			</table>			
		</form>
	</body>
</html>
