<%@ page language="java" import="com.git.base.dbmanager.*"
	contentType="text/html;charset=GBK"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<script language="javascript">
function updaterecord()
{
	document.form1.updatedept.value="update";
	 // alert("aaaa");
    document.form1.submit();
}
function validateNum(text)
{
   if(!isnum(text.value))
   {
     alert("该文本框只能输入数字!");
     text.value = "";
   }
}
function isnum(str)
{
	rset="";
	for(i=0;i<str.length;i++)
	{
		if(str.charAt(i)>="0" && str.charAt(i)<="9")
		{
		}
		else
		{
			return false;
		}
	}
	return true;
}

</script>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<body>
		<form name="form1">
			<table>
			<%
			String sql = null,begintime=null,endtime=null;
		
			MyManager m = MyManager.getInstance();
		
			DBRowSet rs=null;
			String postmethod = null;
			String value = "",hostID=null;				
					
			postmethod = request.getParameter("postmethod");

			if (postmethod == null) {
			%>					
			<table  align="center"  width="324"  height="30">
			<tr align="center" >
			<td>
			</td>
			<td  style=" height: 20px; text-align: center; font:20  ;background-color: green ">
				   会计系统交易情况统计预警时间
			</td>
			<td>
			 </td>
			</tr>
			</table>
			<hr>
			<table  >				
				<%					
				   	sql="select beginTime , endTime  from  SdpTranTime ";				
				   	rs = m.selectSql(sql);					
				%>
				
				<tr>
					<td  colspan="2">
						时间格式为:HHmmss
					</td>
				</tr>
					<tr>
					<td>
						报警开始时间：
					</td>
					<td>						
						<input name="begintime"   type='text' size='12' 
						onkeyup="javascript:validateNum(document.all.begintime);"
						value = <%=rs.getString(0,0)%> >						
					</td>
				</tr>
				<tr>
					<td>
						报警结束时间：
					</td>
					<td>						
						<input name="endtime"   type='text'  size='12' 
						onkeyup="javascript:validateNum(document.all.endtime);"
						value = <%=rs.getString(0,1)%>  >						
					</td>			
					
				</tr>
				<%}%>
		</table>
		<table>
				<tr>
					<td >
						<input  type="hidden"  size='12'  width:50px   />
					</td>	
					<td >
						<input  type="hidden" />
					</td>	<td >
						<input  type="hidden" />
					</td>	
					<td  align="center"  >		
								
						<input value="提交" type="button" class="button"
							onclick=updaterecord();>
					</td>
				</tr>
			</table>
		<%					
			String isUpdate = request.getParameter("updatedept");
			int iRet= 0;
			if (isUpdate != null) {
									
				begintime=request.getParameter("begintime");
				endtime =request.getParameter("endtime");
	
				if (begintime == null) begintime="090000";
				if (endtime == null) endtime="170000";
				
				if(begintime.length() != 6 || endtime.length()!= 6)
				{
				  	System.out.println("时间长度必须为六位");
				 	%>				   
					<script language="javascript">
						alert("时间长度必须为六位"  );	
					</script>		
					<%
				
				}else if( Integer.parseInt(begintime.substring(0,2))> 24  || Integer.parseInt(endtime.substring(0,2))> 24)
				{
					System.out.println("小时错误");
				
				   %>
					<script >
						window.alert("11111S");	
					</script>		
					<%
				}else if( Integer.parseInt(begintime.substring(2,4))>= 60  || Integer.parseInt(endtime.substring(2,4))>= 60)
				{
					System.out.println("小时错误2");
				   %>
				   
					<script language="javascript">
						window.alert("现在系统时间为： 上次交易时间为："   );	
					</script>		
					
					<script language="javascript">
						window.alert("预警开始、结束时间中分钟必须在00至59区间"   );	
					</script>		
					<%
				}else if( Integer.parseInt(begintime.substring(4,6))>= 60  || Integer.parseInt(endtime.substring(4,6))>= 60)
				{
					System.out.println("小时错误3");
				   %>
					<script language="javascript">
						window.alert("预警开始、结束时间中秒必须在00至59区间"   );	
					</script>		
					<%
				}else
				{			
					sql = "update  SdpTranTime set     beginTime= '" + begintime.trim()
						+"', endTime= '"  + endtime.trim()+ "'" ;
					
					iRet = m.ModifySql(sql);
				}
				if (iRet > 0) {
				%>
					<jsp:forward page="../success.jsp"></jsp:forward>		
				<%
				} else {
				%>
					<jsp:forward page="../failure.jsp"></jsp:forward>		
			<%
				}
			}
		%>
		     <input name="updatedept" type="hidden" />	
		</form>
	</body>
</html>
