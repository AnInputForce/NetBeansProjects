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
			String menuid,menuname,menunewwin;			
			int  num;
			Manager m = Manager.getInstance();	
			Vector v_rs= new Vector();			
			String sql = null;				
			String postmethod = null;
			String menulevel=null;
			String value = "";				
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
						菜单ID
					</td>
					<td>
						菜单名称
					</td>
					<td>
						菜单级别
					</td>
					<td>
						菜单页面
					</td>					
					<td>
						上级菜单
					</td>
					<td>
						新窗口
					</td>
					<td>
						备注
					</td>	
					<td  colspan="2">
						操  作
					</td>
				</tr>
				<%					
				 sql="select "+" m.menu_id,"+" m.menu_name,"+" m.menu_level ,"
				      	+" m.menu_page,"+" m.menu_upper as menuupper  , "+"m.menu_newwin as menunewwin , "
				      	+" m.menu_demo, "+" n.menu_name  from  mon_menu m left join mon_menu n " 				      	
						+"on  m.menu_upper=n.menu_id  order by m.menu_id";
				
				v_rs = m.execSQL(sql);
				
				if(v_rs !=null)
				{
					num = v_rs.size();
				    for( int r=0;r< num; r++)
				    {
					    String[]  arr = (String [])v_rs.elementAt(r);	
				    %>
				    <tr>
						<td>
							<input  type="text" readonly="readonly"  value=<%=r+1%>  size="4">
						</td>
				        <td>
							<input name=putname[<%=r%>][0]  type='text'   readonly='readonly'  size='6' 
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
							<input name=putname[<%=r%>][1]  type='text'   readonly='readonly'  size='14' 
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
							<select  name=putname[<%=r%>][2] style="width:90px" 
							<%
							   value =  arr[2];
													   
							   if(value==null)
							   {
							     	value = "";
							     	
							   }else if(value.trim().equals("1"))
							   {
							   		menulevel="一级菜单";
							   
							   }else if(value.trim().equals("2"))
							   {
							   		menulevel="二级菜单";
							   }							  
							%>>
							 <option value="<%=value.trim()%>"> <%=menulevel%></option>
						
							</select>
						 </td>
						 <td>
							<input name=putname[<%=r%>][3]  type='text'   readonly='readonly'  size='22' 
							<%
							   value = arr[3];
													   
							   if(value==null)
							   {
							     value = "";
							   }
							%>
							value=<%=value.trim()%>   >
						</td>
						<td>
							<select  name=putname[<%=r%>][4] style="width:90px" 
							<%							  
							   value = arr[4];
							   menuname = arr[7];
													   
							   if(value==null)
							   {
							     	value = "";							     	
							   }		
							    if(menuname==null)
							   {
							     	menuname = "";							     	
							   }				  
							%>>
							 <option value="<%=value.trim()%>"> <%=menuname.trim()%></option>						
							</select>
						</td>
						<td>
							<select  name=putname[<%=r%>][5] style="width:90px" 
							<%
							   value = arr[5];
							
							   menunewwin="否";		
							   			   
							   if(value==null)
							   {
							     	value = "";
							     	
							   }else if(value.trim().equals("1"))
							   {
							   		menunewwin="是";
							   
							   }						  
							%>>
							 <option value="<%=value.trim()%>"> <%=menunewwin%></option>						
							</select>
						</td>
					 	<td>
							<input name=putname[<%=r%>][6]  type='text'   readonly='readonly'  size='14' 
							<%
							   value = arr[6];
													   
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
				<tr height='25'>
					<td >
						<input  type="hidden" />
					</td>	
				</tr>
				<tr>					
					<td  align="center"   >	
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;											
						<input value="刷新" type="button" class="button"
							onclick=refreshrecord();>	
					</td>
				</tr>
			
			</table>
			<%
			} 
			else if (postmethod.equals("update")) {		
			
				String str1,str2,str3,str4,str5,str6,str7;
		
				if (request.getParameter("recordindex") != null
					&& !request.getParameter("recordindex").trim().equals(""))
				{
					index = Integer.parseInt(request.getParameter("recordindex"));
					
					str1 = request.getParameter("putname[" + index + "][0]");
					
					application.setAttribute("str1", str1);
					
					str2 = encode(request.getParameter("putname[" + index + "][1]"));
					
					application.setAttribute("str2", str2);
					
					str3 = request.getParameter("putname[" + index + "][2]");
					
					application.setAttribute("str3", str3);
					
					str4 = request.getParameter("putname[" + index + "][3]");
					
					application.setAttribute("str4", str4);
					
					str5 = request.getParameter("putname[" + index + "][4]");
					
					application.setAttribute("str5", str5);
					
					str6 = encode(request.getParameter("putname[" + index + "][5]"));
					
					application.setAttribute("str6", str6);		
					
					str7 = encode(request.getParameter("putname[" + index + "][6]"));
					
					application.setAttribute("str7", str7);		
					
			%>
				<script> window.open("updatemenu.jsp");	</script>
			<%
				}
		%>
			<script type="text/javascript">
			    document.refreshform.submit();
			</script>
		<%
			} else if (postmethod.equals("delete")) {
				index = Integer.parseInt(request.getParameter("recordindex"));	
			
			    String str = "putname[" + index + "][0]";

		    	menuid = request.getParameter(str);
				
				sql = "delete from mon_menu where menu_id = '" + menuid.trim() + "'";
				iRet = m.ModifySql(sql);
				%>
				<script type="text/javascript">
				    document.refreshform.submit();
				</script>
			<%}%>	
		</form>
	</body>
</html>

