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
function detail(i)
{
	document.form.recordindex.value=i;
    
	document.form.postmethod.value="update";

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
			<form name="form" method="post" action="./TuxSvcList.jsp?rData=yes">
			 <input type="hidden" name="rData" value="">
			  
			<input name="postmethod" type="hidden" />
			<input name="recordindex" type="hidden" />	
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
			<table  border=1 cellspacing="0" cellpadding="5">
				 <tr bgcolor="#99CCCC">
					<th width="12%">
						设备名称
					</th>
					<th width="8%">
						服务名
					</th>
					<th>
						个数
					</th>
					<th width="8%">
						总计处理请求数
					</th>
					<th width="8%">
						最大处理请求数
					</th>
					<th width="8%">
						最小处理请求数
					</th>
					<th width="8%">
						活动状态服务数
					</th>
					<th width="9%">
						非活动状态服务数
					</th>
					<th width="10%">
						更新时间
					</th>
					<th>
						报警标志
					</th>
					<th>
						备注
					</th>
				</tr>
				<%					
				sql="select h.hostID,h.hostDesc,r.svcname,d.svcnum,d.dealednum,d.maxnum,d.minnum,d.activenum,d.inactivenum,d.updatetime, d.alertflag , " 
					+" d.alertcontent  from tux_service_reg r ,Hosts h left join "
				  	+" tux_service_data  d  on r.svcname=d.svcname  where r.hostID = h.hostID ";//and r.hostID=d.hostID";

				rs = db.selectSql(sql);
				cols = rs.getColumnCount();
				rows = rs.getRowCount();
				for(int r = 0;r < rows ; r++) {				
					strCurFlag = rs.getString(r,10);
					strNum = rs.getString(r,3);
					if(strNum==null){
					
						strDemo="服务"+rs.getString(r,2)+"不存在。";	
					
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
					<tr align="right" <%=strBgColor %>  onclick="javscript:parent.frames.app.location.href='TuxSvcDetail.jsp?hostID=<%=rs.getString(r,0)%>&hostDesc=<%=rs.getString(r,1)%>&svcname=<%=rs.getString(r,2)%>';">

					<%	
					for (int c = 1; c < cols-1; c++) {						
					%>
						<td style="color:#FFFFFF" >
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
					<td style="color:#FFFFFF" ><%=value %></td>
					</tr>
			    <%}%>
			</table>			
		</form>
	</body>
</html>
