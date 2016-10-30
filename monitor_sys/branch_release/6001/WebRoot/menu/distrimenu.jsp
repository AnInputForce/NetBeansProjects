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
　
function selectchg(roletype)
{	
  
  	document.form1.postmethod.value="roletype";
	document.form1.submit();
}
function insertrecord()
{	
	document.form1.postmethod.value="insertrecord";
	document.form1.submit();
}
function deleterecord()
{	
	document.form1.postmethod.value="deleterecord";
	document.form1.submit();
}
</script>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
	</head>
	<body>
		<form name="form1" method="post" >
			<%				 
				String roleid,rolename,menuid,menuname; 
				Manager m = Manager.getInstance();	
				Vector v_rs= new Vector();			
				String sql = null; 
				String postmethod = null; 
				String roletype = null; 
				String selected = null; 
				String menuno = null; 
				int rows = 0;				
			%>
			<table>
				<tr>
					<td>	
						用户角色
					</td>
					<td>
						 <select  onchange=selectchg(this.value) name="roletype" style="width:152px" >
						 <option value="0" >无</option>
						<%						
						sql = "select role_id,role_name from  mon_role order by role_id";
						
						v_rs = m.execSQL(sql);
						if(v_rs !=null)
						{
							rows = v_rs.size();
							for(int r = 0 ; r < rows ; r++ ) 
							{
								 String[]  arr = (String [])v_rs.elementAt(r);	
								 roleid = arr[0];
						   		 rolename = arr[1];		
						   		 roletype = request.getParameter("roletype");	
						   		 if(roleid==null)
							   	 {
							        roleid = "";
							     }
							     if(rolename==null)
							   	 {
							        rolename = "";
							     }
							     if(roletype==null)
							   	 {
							        roletype = "";
							     }
								 if( roleid.trim().equals(roletype.trim()))
							     {	
							   	 	selected="selected='selected'";
							     }else
							     {
							   	 	selected="";
							     }
							     %> 
						  		<option value="<%=roleid %>"  <%=selected%> ><%=rolename%></option>
							<%} 
						}			
						%>				
						</select>
					</td>
				</tr>
			</table>
			<table>
				<tr    height='25'>
				<td >
					<input  type="hidden" />
				</td>	
			</tr>	
			<% 
				postmethod = request.getParameter("postmethod");
				roletype = request.getParameter("roletype");

				if(postmethod!=null && postmethod.trim().equals("insertrecord")&&roletype!=null &&!roletype.trim().equals("0"))
				{				
					menuno = request.getParameter("srcmenu");
					if(menuno!=null)
					{
						iRet = m.ModifySql("insert into mon_menurolemap(role_id,menu_id) values('"+roletype.trim()+"','"+menuno.trim()+"')");						
					}
				}else if(postmethod!=null && postmethod.trim().equals("deleterecord")&&roletype!=null &&!roletype.trim().equals("0"))
				{
					menuno = request.getParameter("destmenu");
					if(menuno!=null)
					{
						iRet = m.ModifySql("delete from  mon_menurolemap where (role_id='"+roletype.trim()+"' and menu_id='"+menuno.trim()+"')");						
					}
				}
			%>	
				<tr>
					<td>
						<select name="srcmenu" size=20 style="width:150px" >
						<%					
						postmethod = request.getParameter("postmethod");
						roletype = request.getParameter("roletype");
						if (postmethod != null && roletype!=null) 
						{				
							sql="select m.menu_id, r.role_id,m.menu_name from mon_menu  m ,mon_role r "+
								" where r.role_id='"+roletype.trim()+"' and  not exists ("+
								" select mrm.role_id from mon_menurolemap mrm where mrm.menu_id=m.menu_id and mrm.role_id=r.role_id) order by m.menu_id";
							
							v_rs = m.execSQL(sql);
							if(v_rs !=null)
							{
								rows = v_rs.size();
								for(int r = 0 ; r < rows ; r++ ) 
								{
									 String[]  arr1 = (String [])v_rs.elementAt(r);	
									 menuid = arr1[0];
							   		 menuname = arr1[2];		
							   		
								     if(menuid==null)
								   	 {
								        menuid = "";
								     }
								     if(menuname==null)
								   	 {
								        menuname = "";
								     }									
								     %> 
									 <option value="<%=menuid %>" ><%=menuname%></option>
							<%} 	
						}
					}%>
					</select>
					</td>		
					<td>
						<input  name="btn1" type="button" value="》" onclick=insertrecord() style="width:60px" >					
					</td>
					<td>
						<input  name="btn2" type="button" value="《" onclick=deleterecord() style="width:60px" >				
					</td>
					<td>
						<select name="destmenu" size=20 style="width:150px" >
						<%
						postmethod = request.getParameter("postmethod");
						roletype = request.getParameter("roletype");
					
						if (postmethod != null && roletype!=null) 
						{	
					   		sql = "select m.menu_id,m.menu_name from  mon_menu m , mon_menurolemap mrm "
					   			+" where m.menu_id= mrm.menu_id  and mrm.role_id= '"+request.getParameter("roletype")+"' order by m.menu_id  ";
						
							v_rs = m.execSQL(sql);
						
							if(v_rs !=null)
							{
								rows = v_rs.size();
								for(int r = 0 ; r < rows ; r++ ) 
								{
									 String[]  arr2 = (String [])v_rs.elementAt(r);	
									 menuid = arr2[0];
							   		 menuname = arr2[1];		
							   		
								     if(menuid==null)
								   	 {
								        menuid = "";
								     }
								     if(menuname==null)
								   	 {
								        menuname = "";
								     }
									
								     %> 
									 <option value="<%=menuid %>" ><%=menuname%></option>
								<%} 	
							}
						}%>
						</select>						
					</td>
				</tr>
			</table>
			<input name="postmethod" type="hidden" />
		</form>
	</body>
</html>

