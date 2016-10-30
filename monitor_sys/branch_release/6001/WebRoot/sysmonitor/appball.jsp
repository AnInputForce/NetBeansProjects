<%@ page language="java" import="com.git.base.cfg.*"
	contentType="text/html;charset=GBK"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<script type="text/javascript" language="javascript" src="../js/ajax.js"></script>
<script language="javascript">
function showBall(str1,str2) {

 var req = newXMLHttpRequest();
 req.onreadystatechange = getReadyStateHandler(req);
// req.open("POST", "http://"+str1+"/AppBall.ajax", true);
req.open("POST", "/AppBall.ajax", true); 
req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
 req.send(null);
 setTimeout("showBall('"+str1+"',"+str2+")",str2);
}
</script>

<body onload="showBall('<%=Service.getHostPort()%>',<%=Integer.valueOf("300").intValue()*1000%>);" background="./images/background.gif" LeftMargin=0 TopMargin=0>
<%System.out.println("11111");%>
<!-- #BeginLibraryItem "/Library/head2.lbi" -->
<!--Popup-->

<div id="showBall">
</div>

<div id=香港 style="position:absolute;left:600;top:460;visibility:visible;">
  <table width="247" cellspacing="0" cellpadding="0">  
 	 <tr>
    	<td style="font:12"><img src="g.gif" width="22" height="22"></td>
	 </tr>
  </table>  
</div>
<div id=澳门 style="position:absolute;left:571;top:465;visibility:visible;">
  <table width="247" cellspacing="0" cellpadding="0">  
 	 <tr>
    	<td style="font:12"><img src="g.gif" width="22" height="22"></td>
	 </tr>
  </table>  
</div>
<div id=台湾 style="position:absolute;left:684;top:426;visibility:visible;">
  <table width="247" cellspacing="0" cellpadding="0">  
 	 <tr>
    	<td style="font:12"><img src="g.gif" width="22" height="22"></td>
	 </tr>
  </table>  
</div>


<table width="800" height="550" border="0" bgcolor="#FFFFFF">
	<tr>
	<td width="100"></td>
  		<td valign="top">
  			<img src="china_map.jpg" width="670" height="550" border="0" usemap="#Map">		
		</td>
	</tr>
</table>
</body>
</html>
