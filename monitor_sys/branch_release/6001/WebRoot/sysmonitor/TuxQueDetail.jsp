<%@ page language="java" import="com.git.base.dbmanager.*"
	contentType="text/html;charset=GBK"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
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
						服务进程名
					</th>
					<th>
						服务进程ID
					</th>					 
					<th>
						队列名称
					</th>
					<th>
						未处理请求数
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
				String srvname = request.getParameter("srvname");
				String hostID = request.getParameter("hostID");
				String hostDesc = encode(request.getParameter("hostDesc"));
			
				if(srvname!=null){	
		 
					sql="select d.srvname,d.procPID,d.quename,d.undealnum,d.updatetime from tux_que_detail d  "
					  	+" where d.srvname = '"+ srvname + "' and d.hostID ='"+hostID+"'";
	
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
