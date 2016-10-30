<%@ page language="java" import="com.git.base.dbmanager.*"
	contentType="text/html;charset=GBK"%>
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
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<body><br>  
		<form name="form" method="post">
			<table  border=1 cellspacing="0" cellpadding="0">
				<tr>
					<th>
						设备名称
					</th>
					<th>
						进程拥有者
					</th>
					<th>
						进程名称
					</th>
					<th>
						进程ID
					</th>
					<th>
						父进程ID
					</th>
					<th>
						CPU占用率
					</th>
					<th>
						虚存占用
					</th>
					<th>
						实存占用
					</th>
					<th>
						常驻内存
					</th>
					<th>
						更新时间
					</th>
				</tr>
				<%					
				String  sql, value;
				MyManager  db = MyManager.getInstance();
				int  rows,cols;
				DBRowSet rs=null;	
				String procName = request.getParameter("procName");
				String procUID = request.getParameter("procUID");
				String hostID = request.getParameter("hostID");
				String hostDesc = encode(request.getParameter("hostDesc"));
				if(procUID!=null&&procName!=null){	
	
					sql="select d.procUID,d.procName,d.procPID,d.procPPID,d.cpuusedrate,d.vmused,d.phyused,d.commemory,d.updatetime from appproc_detail d  "
					  	+" where d.procName = '"+ procName + "' and d.procUID = '"+procUID+"' and d.hostID ='"+hostID+"'";
	
					rs = db.selectSql(sql);
					cols = rs.getColumnCount();
					rows = rs.getRowCount();
					for(int r = 0;r < rows ; r++) {				
						%>
						<tr >
							<td ><%=hostDesc %>
							</td>
						<%	
						for (int c = 0; c < cols; c++) {						
						%>
							<td >
							<%
								value = rs.getString(r,c);
							    if (value == null) {
									value = "";
								}						
							%><%=value %>
							</td>
						<%}%>
						</tr>
				    <%}
				    }%>
			</table>			
		</form>
	</body>
</html>
