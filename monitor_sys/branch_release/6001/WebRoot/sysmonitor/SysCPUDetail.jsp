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
		<form name="form" method="post" action="./SysCPUDetail.jsp?rData=yes">
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
					   <input type="button" name="Submit" value="ˢ��" onclick=refresh()>
					</td>			
				</tr>
			</table>				
	        <hr/>
	         <tr>
	         	<input  type="label"  size="4"  disabled="disabled" <%out.print("style=' background-color: green'");%> >��������	 
	         	<input  type="label"  size="4"  disabled="disabled" <% out.print("style=' background-color: red'");%> >����ʧ�� 
	         	<input  type="label"  size="4"  disabled="disabled" <% out.print("style=' background-color: #FFA500'");%> >���и澯                	
	         </tr>  
	        <hr/>	          
			<table  border=1 cellspacing="0" cellpadding="0">
				 <tr bgcolor="#99CCCC">
				 	<th width='12%'>
						�豸����
					</th>
					<th width='8%'>
						CPU���
					</th>
					<th width='10%'>
						�û�ռ�ñ���(%)
					</th>
					<th width='10%'>
						ϵͳռ�ñ���(%)
					</th>
					<th width='10%'>
						���б���(%)
					</th>
					<th width='10%'>
						IO�ȴ�(%)
					</th>
					<th width='10%'>
						����ʱ��
					</th>
					<th width='8%'>
						������־
					</th>
					<th>
						��ע
					</th>
				</tr>
				<%					
				sql="select h.hostDesc, t.cpuid,t.userusing,t.sysusing,t.idleusing,t.iowait,t.updatetime,"
					+ " t.alertflag , t.alertcontent from cpu_data t,Hosts h where h.hostID=t.hostID ";

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
