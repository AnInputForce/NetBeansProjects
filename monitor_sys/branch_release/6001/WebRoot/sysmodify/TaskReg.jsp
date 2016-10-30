<%@ page language="java" import="com.git.base.dbmanager.*"
	contentType="text/html;charset=GBK"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<script language="javascript">

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
function insertrecord()
{	
	document.form1.postmethod.value="insert";
	document.form1.submit();
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
	
	<body>
		<form name="refreshform" />
		</form>
		<form name="form1" method="post">
		<%
			String statusname,followid,tasknolastone;		
			String strSql=null;
			String sql,value, sSize;
			int index, iRet, num;
			int  rows=0,cols=0;
			Manager m = Manager.getInstance();
			DBRowSet rs = null;
		%>
			
			<table  >
				<tr  >				
					<td>
						流程号
					</td>
					<td>
						<input name="followid" type="text" size="6"   onkeyup="javascript:validateNum(document.all.followid);">
					</td>
					<td>
						任务号(后一位)
					</td>
					<td>
						<input name="tasknolastone" type="text" size="6"   onkeyup="javascript:validateNum(document.all.tasknolastone);">
					</td>
			
					<td>
						任务名称
					</td>
					<td>
						<input name="statusname" type="text">
					</td>
				</tr>
				<tr>&nbsp;
					
					<td>
					</td>
					<td>
						<input value="添加" type="button" class="button" 
							onclick=insertrecord();>
					</td>
					<td>
					<input value="查询" type="button" class="button" 
							onclick=selectrecord();>
					</td>
					<td>
						<input value="刷新" type="button" class="button"
							onclick=refreshrecord();>
					</td>
				</tr>

			</table>
			<input name="postmethod" type="hidden" />
			<input name="recordindex" type="hidden" />
		  <%
			String postmethod = request.getParameter("postmethod");
            if(postmethod == null)
            {
          %>
            <table border=1> 
				<tr align="center">
					<td>
						序号
					</td>
					
					<td>
						流程号
					</td>
					<td>
						任务号
					</td>
					<td>
						任务名称
					</td>
					<td  colspan="2">
						操  作
					</td>
					
				</tr>
				<%
					rs = m.selectSql("select followid,tasknolastone,tranname  from  bat_taskreg  order by followid");					
					if(rs!=null){
						rows = rs.getRowCount();
						cols = rs.getColumnCount();
						
						for(int r=0 ; r< rows;r++)
						{
						%>
						<tr >
							<td>
								<input  type="text" readonly="readonly"  value=<%=r+1%>  size="4">
							</td>
							<%
							for (int c = 0; c < cols; c++) {
							%>
							<td>
								<input  name=putname[<%=r%>][<%=c+1%>] readonly='readonly'  type="text"
								<%
								   value = rs.getString(r,c);
														   
								   if(value==null)
								   {
								     value = "";
								   }
								  
								   if(c==1 ||c==0 )
								   {
								      sSize= "size='6'";
								      						   
								   }  else {
								     
								       sSize= "";
								   }
								 %>
									 <%= sSize%> value="<%=value%>"    >							 
							</td>
							<%}%>
							<td>
								<input  value="修改" type="button" name=update[<%=r%>] onclick="updaterecord(<%=r%>)";>
							</td>
							<td>
								<input value="删除" type="button" name=delete[<%=r%>] onclick="deleterecord(<%=r%>)";>
							</td>
						</tr>
				<%}}%>
			</table>
            <%
            } else if(postmethod.equals("select"))
            {           
				followid=request.getParameter("followid");
				tasknolastone=request.getParameter("tasknolastone");
				
				statusname=encode(request.getParameter("statusname"));
									
				if ( followid == null) followid="";		
				if ( tasknolastone == null) tasknolastone="";		
				if ( statusname == null  ) statusname="";		
			            
           		strSql = "1=1";
				
				if ( followid.trim().length() != 0) 
				{					
					strSql = strSql + "  and t.followid =  " + followid;
				}

				if ( tasknolastone.trim().length() != 0) 
				{					
					strSql = strSql + "  and t.tasknolastone =  " + tasknolastone;					
				}
				if ( statusname.trim().length() != 0) 
				{					
					strSql = strSql + "  and t.tranname like  '%" + statusname  +"%'";					
				}				
          		%>
	            <table border=1> 
					<tr align="center">
						<td>
							序号
						</td>
						
						<td>
							流程号
						</td>
						<td>
							任务号
						</td>
						<td>
							任务名称
						</td>
						<td  colspan="2">
							操  作
						</td>
						
					</tr>
				<%
					
					sql = "select t.followid,t.tasknolastone,t.tranname  from bat_taskreg t where  " + strSql + " order by t.followid";

					rs = m.selectSql(sql);					
					if(rs!=null){
						rows = rs.getRowCount();
						cols = rs.getColumnCount();
						
						for(int r=0 ; r< rows;r++)
						{
						%>
						<tr >
							<td>
								<input  type="text" readonly="readonly"  value=<%=r+1%>  size="4">
							</td>
							<%
							for (int c = 0; c < cols; c++) {
							%>
							<td>
								<input  name=putname[<%=r%>][<%=c+1%>] readonly='readonly'  type="text"
								<%
								   value = rs.getString(r,c);
														   
								   if(value==null)
								   {
								     value = "";
								   }
								  
								   if(c==1 ||c==0 )
								   {
								      sSize= "size='6'";
								      						   
								   }  else {
								     
								       sSize= "";
								   }
								 %>
									 <%= sSize%> value="<%=value%>"    >							 
							</td>
							<%}%>
							<td>
								<input  value="修改" type="button" name=update[<%=r%>] onclick="updaterecord(<%=r%>)";>
							</td>
							<td>
								<input value="删除" type="button" name=delete[<%=r%>] onclick="deleterecord(<%=r%>)";>
							</td>
						</tr>
				<%}}%>
			</table>							
            <%            
            }
			else if (postmethod.equals("insert")) {
			
				followid=request.getParameter("followid");
				tasknolastone=request.getParameter("tasknolastone");
				statusname=encode(request.getParameter("statusname"));
				
				
				if ( followid == null) followid="";		
				if ( tasknolastone == null) tasknolastone="";		
				if ( statusname == null || statusname.trim().length()==0) statusname="";		
 
				if (!followid.equals("")&&!tasknolastone.equals("")) {
			
					sql = "insert into bat_taskreg values('" + followid.trim()
							+ "','" + tasknolastone.trim() + "','" + statusname.trim()
							+ "',1,1,1)";
					iRet = m.ModifySql(sql);		
				}
			%>
				<script type="text/javascript">
				    document.refreshform.submit();
				 </script>
			<%
			} else if (postmethod.equals("update")) {
				String str1, str2, str3;
		
				if (request.getParameter("recordindex") != null
					&& !request.getParameter("recordindex").trim().equals(""))
				{
					index = Integer.parseInt(request.getParameter("recordindex"));
					
					str1 = request.getParameter("putname[" + index + "][1]");
					str2 = request.getParameter("putname[" + index + "][2]");
					str3 = encode(request.getParameter("putname[" + index + "][3]"));				
				
					if ( str1 == null) str1="";		
					if ( str2 == null) str2="";		
					if ( str3 == null) str3="";		
					
					application.setAttribute("str1", str1);
					application.setAttribute("str2", str2);
					application.setAttribute("str3", str3.trim());				
					
			%>
				<script> window.open("updatereg.jsp");	</script>
			<%
				}
		%>
			<script type="text/javascript">
			    document.refreshform.submit();
			</script>
		<%
			} else if (postmethod.equals("delete")) {
			
				index = Integer.parseInt(request.getParameter("recordindex"));	
		    	
				followid = request.getParameter("putname[" + index + "][1]");
				tasknolastone = request.getParameter("putname[" + index + "][2]");				
			
				if ( followid == null) followid="";		
				if ( tasknolastone == null) tasknolastone="";		
				
				sql = "delete from bat_taskreg where  followid= '" + followid.trim() + 
					"'  and  tasknolastone= '" + tasknolastone.trim()+ "'";
			
				iRet = m.ModifySql(sql);
			%>
				<script type="text/javascript">
				    document.refreshform.submit();
				</script>
		<%}%>
		</form>
	</body>
</html>
