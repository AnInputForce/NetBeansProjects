<%@ page language="java" import="com.git.base.dbmanager.*,com.app.RefreshData"
	contentType="text/html;charset=GBK"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
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
			<form name="form" method="post" action="./SysMemoryDetail.jsp?rData=yes">
			 <input type="hidden" name="rData" value="">
			  
			<%
				String  sql, value;
				MyManager  db = MyManager.getInstance();
				int  rows,cols;
				int iCurFlag=0;
				String strBgColor="style=' background-color: green'";
				DBRowSet rs=null;
				String rData = request.getParameter("rData");
				
				if(rData!=null && rData.trim().equals("yes"))
				{
					
					RefreshData.refreshData("/home/monitor/cacti/monitor_poll/poller.sh");	
					
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
			<table  border=1 cellspacing="0" cellpadding="0">
				 <tr bgcolor="#99CCCC">
				 	<th width='12%'>
						设备名称
					</th>
	                <th width='8%'>
						内存编号
					</th>
					<th width='8%'>
						对换区容量(KB)
					</th>
					<th width='8%'>
						对换区可用量(KB)
					</th>
					<th width='8%'>
						对换区可用比例(KB)
					</th>
					<th width='8%'>
						物理内存容量(KB)
					</th>
					<th width='8%'>
						物理内存可用量(KB)
					</th>
					<th width='8%'>
						物理内存可用比例(%)
					</th>
					<th width='8%'>
						虚存空闲总量(KB)
					</th>
					<th width='10%'>
						更新时间
					</th>
					<th width='5%'>
						报警标志
					</th>
					<th>
						备注
					</th>
				</tr>
				<%
				sql="select h.hostDesc, t.memoryid,t.swapsize,t.swapfreesize,t.swapfreerate,t.physize,t.phyfreesize,"+
					"t.phyfreerate,t.vmfreesize, t.updatetime, t.alertflag, t.alertcontent from memory_data t ,Hosts h where h.hostID=t.hostID";

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
					<tr align="right"  <%=strBgColor %>>
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
