<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
  </head> 
  
  <body >
  
<SCRIPT src="../js/calendar.js">
</SCRIPT>
<SCRIPT src="../js/checkDate.js">
</SCRIPT>
    <form method="POST"  action="./ireport/trandetail.jsp">
  
    <table align = "center">
    	<tr>  &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp会计交易统计报表
    	</tr>
    	<hr>    	
    	<tr>
    		<td>
    			开始日期: 
    		</td>
    		<td>    		
				<INPUT name="start" onblur="checkDate(this);"onclick="calendar(this);"> 
    		</td>
    		
    	</tr>
    	<tr>
    		<td>
    			结束日期: 
    		</td>
    		<td>    		
				<INPUT name="end"  onblur="checkDate(this);"onclick="calendar(this);"> 
    		</td>
    		
    	</tr>
    	<tr>
    		<td colspan="4" align="center">
    			<input type="submit" value="打印会计交易统计报表">
    		</td>
    	</tr>
    </table>
  </form>
  </body>
</html>
