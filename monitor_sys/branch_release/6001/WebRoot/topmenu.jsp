<%@ page language="java" import="com.git.base.dbmanager.*,com.forms.login.*,java.util.*" contentType="text/html;charset=GBK"%>

<html>
<head>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<style>
	body,td{font:normal 12px Tahoma}
	#menu{display:none}
</style>
<script language="javascript">
			var oPop=window.createPopup();
			oPop.document.body.style.cssText="padding:3 0 3 0;margin:0px;width:200px;font:normal 14px Tahoma;text-align:left;border:1px solid green;overflow:hidden";
			function expand(){ 
			    var obj = event.srcElement;
			    var item = menu.document.all.tags("pre")[obj.cellIndex];    
			    var w = obj.offsetWidth+2;
			    var h = (item.innerText.split("\n").length)*18;
			    var x = document.body.scrollLeft+event.x-event.offsetX-1;
			    var y = document.body.scrollTop+event.y-event.offsetY+obj.offsetHeight;
			    /*var linkStyle = "text-decoration:none;color:#000000;cursor:hand";*/
			    var linkStyle =" text-decoration:none;color:green;cursor:hand;position:relative;padding-left:0px;"; 
			  
			    oPop.document.body.style.background = obj.bgColor;
				/*因为 popup 窗口的特殊性，链接不能直接打开，需要用onClick="parent.open(this.href)" 这种方式打开，所以在菜单组中查找匹配的HTML代码(即链接)，将它加上 onClick 动作*/
				/*oPop.document.body.innerHTML = item.outerHTML.replace(/<a ([^>]*)>/gi,"<a $1 style='"+linkStyle+"' onClick='parent.goToPage(this.href);' hidefocus>");*/
				oPop.document.body.innerHTML = item.outerHTML.replace(/[ ]*<a ([^>]*)>/gi,"<a $1 style='"+linkStyle+"' onClick='parent.goToPage(this.href,this.target);' hidefocus>");
	
    			oPop.show(x,y,w,h,document.body);   
			}
			function goToPage(url,target)
			{
				if(target=='_blank')
				{
					parent.open(url);
				}else
				{	
					parent.frames.main.location.href=url;
				}
			}
</script> 
</head>
<body bgcolor="#CBD9E0" topmargin="0" >
	<%
		String  role=(String)session.getAttribute("role");	
		Manager m = Manager.getInstance();	
		String sql=null;		
		Vector v_Menu= new Vector();
		Menu[]  mainMenus=null;
	%>	
	<table>
		<tr height="12" width="100%" bgcolor="#CBD9E0"><td></td></tr>	
	</table>		
	<table width="1000"  cellpadding="1" cellspacing="1" style="background:green"> 
		<tr bgcolor="#CBD9E0" style="text-align:center"> 
		<% 		 
			
			sql= "select   m.menu_name  ,m.menu_page ,"+
			    " m.menu_upper ,m.menu_id ,m.menu_level from  mon_role r , mon_menu m ,"+
			    " mon_menurolemap mrm  where   m.menu_id = mrm.menu_id and "+ 
			    "  r.role_id = mrm.role_id  and m.menu_level=1 and mrm.role_id='"+ role.trim()+"' order by m.menu_id";
			
			v_Menu = m.execSQL(sql);
					
			if(v_Menu!=null)
			{
			
				mainMenus=new Menu[v_Menu.size()];
			
		        for(int i=0;i<v_Menu.size();i++)
		        {		       
			       	mainMenus[i] = new Menu();
			   	  	String[] arr = (String [])v_Menu.elementAt(i);
			   	  	try 
			   	  	{	                  	
			    	  	mainMenus[i].setMenuName(arr[0]);
			    	  	mainMenus[i].setMenuPage(arr[1]);
			    	  	mainMenus[i].setMenuUpper(arr[2]);
			    	  	mainMenus[i].setMenuID(arr[3]);
			   	  		mainMenus[i].setMenuLevel(arr[4]);
	//		   	  	System.out.println(" "+ arr[0].trim()+" "+ arr[1].trim()+" "+ arr[2].trim()+" "+ arr[3].trim()+" "+ arr[4].trim());
			       	}catch(NullPointerException ex)
			       	{
			       		ex.printStackTrace();
			       	}  	
			       	%>
				<td bgcolor="#CBD9E0" style="color:green; height:25px;" onmouseover="expand()"><%=mainMenus[i].getMenuName().trim()%></td> 
				<%      		
		       }   
		 	}		
			%> 	  		    
		 </tr> 
	</table> 	
	
	<span id="menu"> 
	<%
	for(int k = 0; k < v_Menu.size();k++) {
		
		String menuid= mainMenus[k].getMenuID().trim();
		String menuname= mainMenus[k].getMenuName().trim();
		
	    sql= "select   m.menu_name  ,m.menu_page ,m.menu_upper ,"+
		    " m.menu_id ,m.menu_level,m.menu_newwin from  mon_role r , mon_menu m ,"+
		    " mon_menurolemap mrm  where    m.menu_id = mrm.menu_id and "+ 
		    " r.role_id = mrm.role_id and m.menu_upper = '" + menuid.trim()+ 
		    "' and m.menu_level=2 and r.role_id ='"+ role.trim()+"' order by m.menu_id ";
		
	     Vector v_SubMenu= new Vector();
		 v_SubMenu= m.execSQL(sql);
		 Menu[]  subMenus=null;
		 %><pre><%
		 if(v_SubMenu!=null){
		 	subMenus=new Menu[v_SubMenu.size()];
		 	for(int i=0;i<v_SubMenu.size();i++){
		 		subMenus[i] = new Menu();
		 		String[] arr = (String [])v_SubMenu.elementAt(i);
		 		try {
		 			subMenus[i].setMenuName(arr[0]);
		 			subMenus[i].setMenuPage(arr[1]);
		 			subMenus[i].setMenuUpper(arr[2]);
		 			subMenus[i].setMenuID(arr[3]);
		 			subMenus[i].setMenuLevel(arr[4]);
		 			subMenus[i].setMenuNewwin(arr[5]);
		 			//System.out.println(" "+ arr[0].trim()+" "+ arr[1].trim()+" "+ arr[2].trim()+" "+ arr[3].trim()+" "+ arr[4].trim()+" "+ arr[5].trim());
		       	}catch(NullPointerException ex){}    	       		
	        }
	        for(int y=0;y<v_SubMenu.size();y++) {
	        	String submenupage= subMenus[y].getMenuPage();
	        	String submenuname= subMenus[y].getMenuName();
	        	String submenunewwin = subMenus[y].getMenuNewwin();
	        	String target=null;
	        	if(submenunewwin.trim().equals("1"))
	        	{
	        		target="target='_blank'";
	        	}else
	        	{
	        		target="target='main'";
	        	}
	        %><a href="<%=submenupage.trim()%>" <%=target%> > <%=submenuname.trim()%></a>
<%}}%></pre>
	        <%} %>
	  </span> 
</body>
</html>

