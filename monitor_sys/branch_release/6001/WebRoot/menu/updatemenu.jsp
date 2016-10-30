<%@ page language="java" import="com.git.base.dbmanager.*,java.util.*"
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
	document.form1.updatemenu.value="update";
	  
    document.form1.submit();
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
	<body>		
		<form name="form1">
		<%
			Manager m = Manager.getInstance();	
			Vector v_rs= new Vector();						
			String strmenulevel1=null;
			String strmenulevel2=null;
			String strmenuwin1=null;
			String strmenuwin2=null;
			String menuupper=null,sql=null;	
			String menulevel,menuid,menuname,menupage,menudemo,menuwin;		
			String selected="";	
			int num = 0;
		%>
			<table>
			<tr>
				<td>
					菜单ID
				</td>
				<td>
					<input name="menuid" type="text" value=<%=application.getAttribute("str1")%> onkeyup="javascript:validateNum(document.all.menuid);">

				</td>
				<td>
					菜单名称
				</td>
				<td>
					<input name="menuname" type="text" value=<%=application.getAttribute("str2")%> />

				</td>	
				<td>
					菜单级别
				</td>
				<td>					
					<select  name="menulevel" style="width:152px" >	
					<%
						menulevel=(String)application.getAttribute("str3");
						if(menulevel==null)
						{
							menulevel="";							
						}		
						if(menulevel.trim().equals("1"))
						{
							strmenulevel1 = "selected='selected'";
							strmenulevel2 = "";
						}else if(menulevel.trim().equals("2"))
						{
							strmenulevel1 = "";
							strmenulevel2 = "selected='selected'";
						}
					%>					
					  <option value="1"  <%=strmenulevel1 %>  >一级菜单</option>
    				  <option value="2"  <%=strmenulevel2 %>  >二级菜单</option>						 
					</select>

				</td>	
			</tr>
			<tr>				
				<td>	
					上级菜单
				</td>
				<td  >						
					<select  name="menuupper" style="width:152px" >
					<%
						menuupper = (String)application.getAttribute("str5");
					    if(menuupper==null)
					    {
					       menuupper = "";
					    }
						%><option value="0" >无上级菜单</option>	
						<%

						sql = "select menu_id,menu_name from  mon_menu  where menu_level='1' order by menu_id";
						
						v_rs = m.execSQL(sql);
						
						if(v_rs!=null)
						{
							num = v_rs.size();
							for( int r =0 ; r< num ; r++)
							{
								 String[]  arr = (String [])v_rs.elementAt(r);	
								 menuid = arr[0];
						   		 menuname = arr[1];		
						   		 if(menuid==null)
							   	 {
							        menuid = "";
							     }
							     if(menuid.trim().equals(menuupper.trim()))
							     {
							   		selected = "selected='selected'";	
							     }else
							     {
							   		selected = "";
							     }	
							     %> 
					 			<option value="<%=menuid %>"  <%=selected%>><%=menuname%></option>
		    				<%}
						}						
					%> 					 
					</select>
				</td>

				<td>	
					菜单页面
				</td>
				<td  colspan="3"  >					
					<input name="menupage" type="text" style="width:376px"  value=<%=application.getAttribute("str4")%>  >
				</td>

			</tr>	
			<tr>	
				<td>
					新窗口
				</td>
				<td>					
					<select  name="menuwin" style="width:152px" >	
					<%
						menuwin=(String)application.getAttribute("str6");
						if(menuwin==null)
						{
							menuwin="";							
						}		
						if(menuwin.trim().equals("1"))
						{
							strmenuwin1 = "selected='selected'";
							strmenuwin2 = "";
						}else 
						{
							strmenuwin1 = "";
							strmenuwin2 = "selected='selected'";
						}
					%>					
					  <option value="1"  <%=strmenuwin1 %>  >是</option>
    				  <option value="0"  <%=strmenuwin2 %>  >否</option>						 
					</select>

				</td>	
				<td>	
					备注
				</td>
				<td  colspan="3">
					
					<input name="menudemo" type="text" style="width:224px" value=<%=application.getAttribute("str7")%>  >
				</td>

			</tr>
		
			<tr    height='25'>
				<td >
					<input  type="hidden" />
				</td>	
			</tr>	
						
			<tr>
				<td>
				</td>
				<td>
					<input value="提交" type="button" class="button"
						onclick=updaterecord();>
				</td>
				<td>

				</td>

			</tr>

		</table>
	
		<%
		String strWhere;
			
		String isUpdate = request.getParameter("updatemenu");
				
		if (isUpdate != null) {
								
			menuid=request.getParameter("menuid");
			menuname =encode(request.getParameter("menuname"));
			menulevel =request.getParameter("menulevel");
			menupage =request.getParameter("menupage");
			menuupper =request.getParameter("menuupper");
			menuwin =request.getParameter("menuwin");
			menudemo =request.getParameter("menudemo");
			
			if (menuid == null) menuid="";
			if (menuname == null) menuname="";
			if (menulevel == null) menulevel="";
			if (menupage == null) menupage="";
			if (menuupper == null) menuupper="";
			if (menuwin == null) menuwin="0";
			if (menudemo == null) menudemo="";
								
			strWhere= " menu_id='"+ ((String)application.getAttribute("str1")).trim() +"'";				
				
			sql = "update  mon_menu set    menu_id= '" + menuid.trim()
			+ "'  , menu_name= '" + menuname.trim()
			+ "'  , menu_level= '" + menulevel.trim()
			+ "'  , menu_page= '" + menupage.trim()
			+ "'  , menu_upper= '" + menuupper.trim()
			+ "'  , menu_newwin= '" + menuwin.trim()
			+ "'  , menu_demo= '" + menudemo.trim()
			+ "'  where  "+strWhere;
			

			int iRet = m.ModifySql(sql);
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
		     <input name="updatemenu" type="hidden" />	
		</form>
	</body>
</html>
