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
        	body,input,table,tr,td,th,p{
        			 margin:2px;
            	 font-size:12px;
            	} 
        </style>
 </head>
	<body> 
		
		<form name="form" method="post" action="./AppProcList.jsp?rData=yes">
			 <input type="hidden" name="rData" value="">
			  
			<%
				String  sql, value;
				MyManager  db = MyManager.getInstance();
				int  rows,cols;
				String strCurFlag=null;
				String strBgColor="style=' background-color: green'";
				String strDemo=null,strNum=null;
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
			<table  border=1 cellspacing="0" cellpadding="5">
				 <tr bgcolor="#99CCCC">
				 	<th width="14%">
						�豸����
					</th>
					<th width="14%">
						����ӵ����
					</th>
					<th width="14%">
						��������
					</th>
					<th width="14%">
						��������(��)
					</th>
					<th >
						����ʱ��
					</th>
					<th >
						������־
					</th>
					<th>
						��ע
					</th>
					
				</tr>
				<%	
				System.out.println("it is this page:appproclist");								
				sql="select h.hostID,h.hostDesc,r.procUID,r.procName,d.procNum,d.updatetime, d.alertflag ,d.alertcontent from appproc_reg r ,Hosts h left join "
				  	+" appproc_data  d  on r.procUID=d.procUID and r.procName=d.procName where h.hostID=r.hostID  and h.hostDesc not like '%����%'";

				rs = db.selectSql(sql);
				cols = rs.getColumnCount();
				rows = rs.getRowCount();
				for(int r = 0;r < rows ; r++) {				
					strCurFlag = rs.getString(r,6);
					strNum = rs.getString(r,4);
					if(strNum==null){
					
						strDemo=rs.getString(r,2)+"�Ľ���"+rs.getString(r,3)+"�����ڡ�";					
					}

					if(strCurFlag==null){
						strBgColor="style=' background-color: red'";						
					}else if(strCurFlag.trim().equals("2")){
						strBgColor="style=' background-color: #ffa500'";
						
					}else if(strCurFlag.trim().equals("1")){
						strBgColor="style=' background-color: green'";
						
					}else if(strCurFlag.trim().equals("3")){
						strBgColor="style=' background-color: red'";
						
					}
					%>
					<tr align="right"  <%=strBgColor %>  onclick="javscript:parent.frames.app.location.href='AppProcDetail.jsp?hostID=<%=rs.getString(r,0)%>&hostDesc=<%=rs.getString(r,1)%>&procUID=<%=rs.getString(r,2)%>&procName=<%=rs.getString(r,3)%>';">
					<%				
					for (int c = 1; c < cols-1; c++) {						
					%>
						<td style="color:#FFFFFF">
						<%
							value = rs.getString(r,c);
						    if (value == null) {
								value = "";
							}						
						%><%=value %>
						</td>
					<%}
					if(strNum!=null)
					{
						value=rs.getString(r,cols-1);					
					
					}else {
					
						value=strDemo;					
					}
					%>	
					<td style="color:#FFFFFF"><%=value %></td>
					</tr>
			    <%}%>
			</table>		
		</form>
	</body>
</html>
