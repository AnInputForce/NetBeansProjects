<%@ page language="java" import="com.git.base.dbmanager.*,java.util.*"
	contentType="text/html;charset=GBK"%>
<%
	int  iRet;
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<script language="javascript" type="text/javascript">
function selectlevel(value)
{	
	if(value==1)
	{
		document.form1.menupage.disabled=true;
		document.form1.menuupper.value=0;
		
	}else 
	{
		document.form1.menupage.disabled=false;
	}	
}　

function refreshrecord()
{	
	document.refreshform.submit();
}
function insertrecord()
{	
	document.form1.postmethod.value="insert";
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
				String menuid,menuname,menupage,menuupper;
				String menulevel,menuwin,menudemo;				
				Manager m = Manager.getInstance();	
				Vector v_rs= new Vector();	
				String sql = null;
				int num=0;
				String postmethod = null;
			%>
			<table  border='0'>
				<tr>
					<td>
						菜单ID
					</td>
					<td>
						<input name="menuid" type="text" onkeyup="javascript:validateNum(document.all.menuid);">
					</td>
					<td>
						菜单名称
					</td>
					<td>
						<input name="menuname" type="text" />
					</td>	
					<td>
						菜单级别
					</td>
					<td>					
						<select  onchange=selectlevel(this.value) name="menulevel" style="width:152px" >						
						  <option value=1 >一级菜单</option>
     					  <option value=2 selected >二级菜单</option>		
     					 				 
						</select>
					</td>	
				</tr>
				<tr>
					<td>	
						上级菜单
					</td>
					<td  >						
						<select  name="menuupper" style="width:152px" >
						<option value="0" selected>无上级菜单</option>
						<%
						sql="select menu_id,menu_name from  mon_menu  where menu_level='1' order by menu_id";
						v_rs = m.execSQL(sql);	
					
						if(v_rs != null){									
							num  = v_rs.size();						
							for(int r=0 ; r < num;r++){	
								String[]  arr = (String [])v_rs.elementAt(r);	
								menuid = arr[0];
						   		menuname = arr[1];							   
												   
							    if(menuname==null)
							    {
							      menuname = "";
							    }
						%> 
						  <option value="<%=menuid %>"><%=menuname%></option>
						  <%}} %>						  
						</select>
					</td>
					
					<td>	
						菜单页面
					</td>
					<td  colspan="3"  >					
						<input name="menupage" type="text" style="width:376px"  />
					</td>
				</tr>	
				<tr>	
					<td>	
						新窗口
					</td>
					<td>
						<select  name="menuwin" style="width:152px" >						
						  <option value=1 >是</option>
     					  <option value=0 selected >否</option>	     					 				 
						</select>
					</td>
					<td>	
						备注
					</td>
					<td  colspan="3">
						
						<input name="menudemo" type="text" style="width:224px" />
					</td>
				</tr>
				
				<tr height='25'>				
					<td >
						<input  type="hidden" />
					</td>				
				</tr>
				<tr>				
					<td>
						<input  type="hidden" />
					</td>
					<td align="center">
						<input value="添加" type="button" class="button"
							onclick=insertrecord();>
					</td>				
				</tr>
			</table>
			<input name="postmethod" type="hidden" />
			<input name="recordindex" type="hidden" />		
		<%
			postmethod = request.getParameter("postmethod");

			if (postmethod == null) {
		
			} else if (postmethod.equals("insert")) {

				menuid=request.getParameter("menuid");
				menuname =encode(request.getParameter("menuname"));
				menuupper =request.getParameter("menuupper");
				menulevel=request.getParameter("menulevel");
				menudemo =encode(request.getParameter("menudemo"));
				menupage=request.getParameter("menupage");
				menuwin=request.getParameter("menuwin");
				
			
				if (menuid == null) menuid="";
				if (menuname == null) menuname="";
				if (menuupper == null) menuupper="";
				if (menulevel == null) menulevel="";
				if (menudemo == null) menudemo="";
				if (menupage == null) menupage="";
				if (menuwin == null) menuwin="0";
			
			
				if (!menuid.equals("")) {

					sql = "insert into mon_menu(menu_id,menu_name,menu_upper,"
						+"menu_level,menu_demo,menu_page,menu_newwin) "
						+"values('" + menuid.trim()
							+ "','" + menuname.trim() 
							+ "','" + menuupper.trim()
							+ "','" + menulevel.trim()
							+ "','" + menudemo.trim()
							+ "','" + menupage.trim()
							+ "','" + menuwin.trim()
							+ "')" ;
		
					iRet = m.ModifySql(sql);
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
			<script type="text/javascript">
				document.refreshform.submit();
			</script>
			<%
			}
			%>
		</form>
	</body>
</html>

