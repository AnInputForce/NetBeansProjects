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
     alert("���ı���ֻ����������!");
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
				   ���ϵͳ�������ͳ��Ԥ��ʱ��
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
						ʱ���ʽΪ:HHmmss
					</td>
				</tr>
					<tr>
					<td>
						������ʼʱ�䣺
					</td>
					<td>						
						<input name="begintime"   type='text' size='12' 
						onkeyup="javascript:validateNum(document.all.begintime);"
						value = <%=rs.getString(0,0)%> >						
					</td>
				</tr>
				<tr>
					<td>
						��������ʱ�䣺
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
								
						<input value="�ύ" type="button" class="button"
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
				  	System.out.println("ʱ�䳤�ȱ���Ϊ��λ");
				 	%>				   
					<script language="javascript">
						alert("ʱ�䳤�ȱ���Ϊ��λ"  );	
					</script>		
					<%
				
				}else if( Integer.parseInt(begintime.substring(0,2))> 24  || Integer.parseInt(endtime.substring(0,2))> 24)
				{
					System.out.println("Сʱ����");
				
				   %>
					<script >
						window.alert("11111S");	
					</script>		
					<%
				}else if( Integer.parseInt(begintime.substring(2,4))>= 60  || Integer.parseInt(endtime.substring(2,4))>= 60)
				{
					System.out.println("Сʱ����2");
				   %>
				   
					<script language="javascript">
						window.alert("����ϵͳʱ��Ϊ�� �ϴν���ʱ��Ϊ��"   );	
					</script>		
					
					<script language="javascript">
						window.alert("Ԥ����ʼ������ʱ���з��ӱ�����00��59����"   );	
					</script>		
					<%
				}else if( Integer.parseInt(begintime.substring(4,6))>= 60  || Integer.parseInt(endtime.substring(4,6))>= 60)
				{
					System.out.println("Сʱ����3");
				   %>
					<script language="javascript">
						window.alert("Ԥ����ʼ������ʱ�����������00��59����"   );	
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
