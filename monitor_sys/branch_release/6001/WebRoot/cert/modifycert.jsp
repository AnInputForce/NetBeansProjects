<%@ page language="java" import="com.git.base.dbmanager.*,java.util.*"
	contentType="text/html;charset=GBK"%>
<%
	int index, iRet;
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<script language="javascript" type="text/javascript">
　
function updaterecord(i)
{
    document.form1.recordindex.value=i;
    
	document.form1.postmethod.value="update";

    document.form1.submit();   
}
function selectrecord()
{	
	document.form1.postmethod.value="select";
	document.form1.submit();
}
function refreshrecord()
{	
	document.refreshform.submit();
}

function deleterecord(i)
{
	if(confirm("确认删除吗?")){
	    document.form1.postmethod.value="delete";
	    document.form1.recordindex.value=i;
		document.form1.submit();
	}
}
function validateNum(text)
{
   if(!isnum(text.value))
   {
     alert("该文本框只能输入数字!");
     text.value = "";
   }
}
function validateInt(text)
{
   if(!isInt(text.value))
   {
     alert("该文本框只能输入数字或者负号!");
     text.value = "";
   }
}
function isInt(str)
{
	rset="";
	for(i=0;i<str.length;i++)
	{
		if((str.charAt(i)>="0" && str.charAt(i)<="9")||str.charAt(i)=="-")
		{
		}
		else
		{
			return false;
		}
	}
	return true;
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
</script>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

	</head>
	<body>
		<form name="refreshform" />
		</form>
		<form name="form1" method="post">
			<%
				String certid;			
				int  num;
				Manager m = Manager.getInstance();	
				String sql = null;				
				String postmethod = null;
				String value = "";	
				Vector v_rs= new Vector();	
			%>			
			<input name="postmethod" type="hidden" />
			<input name="recordindex" type="hidden" />		
			<%
			postmethod = request.getParameter("postmethod");

			if (postmethod == null) {

			%>		
			<table border="1" >
				<tr  align="center">
					<td>
						序号
					</td>
					<td>
						 证件类型ID
					</td>
					<td>
						证件名称
					</td>				
					<td  colspan="2">
						操  作
					</td>
				</tr>
				<%		
				v_rs = m.execSQL("select cert_id,cert_name  from  mon_certinfo order by cert_id");

				if(v_rs != null){					
					num  = v_rs.size();						
					for(int r=0 ; r < num;r++){	
						String[]  arr = (String [])v_rs.elementAt(r);
				%>
				<tr>
					<td>
						<input  type="text" readonly="readonly"  value=<%=r+1%>  size="4">
					</td>
					<td>
						<input name=putname[<%=r%>][0]   type='text'   readonly='readonly'
						<%  				
						   value = arr[0];
						   if(value==null)
						   {
						     value = "";
						   }
						%>
						   value=<%=value.trim()%>   >
					</td>
					<td>
						<input name=putname[<%=r%>][1]   type='text'   readonly='readonly'
						<%
						   value = arr[1];											   
						   if(value==null)
						   {
						     value = "";
						   }
						%>
						   value=<%=value.trim()%>   >
					</td>					
					<td>
						<input value="修改" type="button" name=update[<%=r%>] onclick="updaterecord(<%=r%>)";>
					</td>
					<td>
						<input value="删除" type="button" name=delete[<%=r%>] onclick="deleterecord(<%=r%>)";>
					</td>
				</tr>
				<%				
				}}
				%>
			</table>
			<table>				
				<tr>
					<td >
						<input  type="hidden" />
					</td>	
					<td >
						<input  type="hidden" />
					</td>		
					&nbsp;	&nbsp;	&nbsp;	&nbsp;	&nbsp;	&nbsp;
					
					<td  align="center" size='20'  >		
						&nbsp;	&nbsp;	&nbsp;	&nbsp;	&nbsp;	&nbsp;			
						<input value="刷新" type="button" class="button"
							onclick=refreshrecord();>	
					</td>
				</tr>			
			</table>
		<%
			} 
			else if (postmethod.equals("update")) {		
			
				String str1=null, str2=null;
		
				if (request.getParameter("recordindex") != null
					&& !request.getParameter("recordindex").trim().equals(""))
				{
					index = Integer.parseInt(request.getParameter("recordindex"));
					
					str1 = request.getParameter("putname[" + index + "][0]");
					str2 = encode(request.getParameter("putname[" + index + "][1]"));
					
					application.setAttribute("str1", str1);
					application.setAttribute("str2", str2);					
			%>
				<script> window.open("updatecert.jsp");	</script>
			<%
				}
		%>
			<script type="text/javascript">
			    document.refreshform.submit();
			</script>
		<%
			} else if (postmethod.equals("delete")) {
				if (request.getParameter("recordindex") != null
					&& !request.getParameter("recordindex").trim().equals(""))
				{
					index = Integer.parseInt(request.getParameter("recordindex"));	
				
				    String str = "putname[" + index + "][0]";
	
			    	certid = request.getParameter(str);
				
					sql = "delete from mon_certinfo where cert_id = '" + certid.trim() + "'";
	
					iRet = m.ModifySql(sql);
				}
				%>
				<script type="text/javascript">
				    document.refreshform.submit();
				</script>
		<%} %>	
		</form>
	</body>
</html>

