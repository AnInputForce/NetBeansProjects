<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %> 
<%@ page language="java" %>
<%@ page contentType="text/html; charset=GB2312" pageEncoding="GB2312" %> 


<% 
	response.setHeader("Pragma","No-cache"); 
	response.setHeader("Cache-Control","no-cache"); 
	response.setDateHeader("Expires", 0); 
%> 

<html> 
	<head> 
		<title>监控系统</title> 
	</head> 	
	<body> 
	 <center>
		<html:form action="/Login" focus="username"> 
		 <table>
      	    <tr>
			   <td>用户名:</td>
			   <td><html:text property="username" size="25" value=""/> </td>
			</tr>
			<tr>
			   <td>密   码:</td>
			   <td><html:password property="password" size="25" value="" /> </td>
			</tr>			
		 </table>
		 <br>		 
		 <table>
		    <tr>
			   <html:submit property="submit" value="登 陆"/> 
			</tr>
		 </table>
		</html:form> 
	</body> 
</html> 
