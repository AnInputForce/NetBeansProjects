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
	document.form1.updateproc.value="update";
	  
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
			<table>
				<%				
					Manager m = Manager.getInstance();
					DBRowSet rs = null;
					int rows=0,cols=0;
					String oldprovid=null;
					String sysid=null,sysname=null;				
				%>
				<tr>	
					<td>
						当前日期
					</td>
					<td>
						<input name="busidate" type="text"
							 value=<%=application.getAttribute("str1")%>>
					</td>
					<td>
						系统名称
					</td>
					<td>
						<select name="sysid" style="width:150px" >
						<%	
							String sel ="";	
							rs = m.selectSql("select sysid,sysname from  bat_provname order by sysid");
							
							if(rs!=null)
							{
								rows = rs.getRowCount();
								cols = rs.getColumnCount();

								for(int r=0 ; r< rows;r++)
								{
									sysid = rs.getString(r,0);
									sysname = rs.getString(r,1);

									if( sysname.equals(application.getAttribute("str2")))
									{
								   		sel="selected='selected'";
								   		oldprovid=sysid;
								   	}
								   	else 
								   		sel="";
									%> 
						  			<option value="<%=sysid %>"  <%=sel%> ><%=sysname%></option>
						  		<%}
						  	}%>
						</select>						
					</td>	
					<td>
						任务号
					</td>
					<td>
						<input name="taskno" type="text"
							 value=<%=application.getAttribute("str3")%>>
					</td>
				</tr>
				<tr>
					<td>
						流程号
					</td>
					<td>
						<input name="followid" type="text"
							 value=<%=application.getAttribute("str4")%>>
					</td>
					<td>
						当前标志
					</td>
					<td>
						<input name="curflag" type="text"
							 value=<%=application.getAttribute("str5")%>>
					</td>
				
					<td>
						当前重复次数
					</td>
					<td>
						<input name="curretrytimes" type="text"
							 value=<%=application.getAttribute("str6")%>>
					</td>
				</tr>
				<tr>
					<td>
						最大重复次数
					</td>
					<td>
						<input name="maxretrytimes" type="text"
							 value=<%=application.getAttribute("str7")%>>
					</td>
				
					<td>
						当前状态
					</td>
					<td>
						<input name="status" type="text"
							 value=<%=application.getAttribute("str8")%>>
					</td>			
				</tr>				
				<tr>
					<td>
					</td>
					<td>
						<input value="提交" type="button" class="button"
							onclick=updaterecord();>
					</td>				
				</tr>
			</table>		
		<%
			String busidate,taskno,followid,curflag;
			String curretrytimes,maxretrytimes,status, sSize;;
			String strWhere1,strWhere2,strWhere3,strWhere4;
			String strWhere5,strWhere6,strWhere7,strWhere8;
			
			String isUpdate = request.getParameter("updateproc");
			
			if (isUpdate != null) {
									
				busidate=request.getParameter("busidate");
				sysid=request.getParameter("sysid");
				taskno=request.getParameter("taskno");
				followid=request.getParameter("followid");
				curflag=request.getParameter("curflag");
				curretrytimes=request.getParameter("curretrytimes");
				maxretrytimes=request.getParameter("maxretrytimes");
				status=request.getParameter("status");
			
				if (busidate == null) busidate="";
				if (sysid == null) sysid="";
				if (taskno == null) taskno="";
				if (followid == null) followid="";
				if (curflag == null) curflag="";
				if (curretrytimes == null) curretrytimes="";
				if (maxretrytimes == null) maxretrytimes="";
				if (status == null) status="";
				
				if(application.getAttribute("str1")!=null &&
					!application.getAttribute("str1").equals(""))
				{
					strWhere1=" and busidate= '"+ application.getAttribute("str1") +"'" ;				
				
				}else
				{
					strWhere1="";
				}
				if(application.getAttribute("str3")!=null &&
					!application.getAttribute("str3").equals(""))
				{
					strWhere3=" and taskno="+ application.getAttribute("str3") ;				
				
				}else
				{
					strWhere3="";
				}
				
				if(application.getAttribute("str4")!=null &&
					!application.getAttribute("str4").equals(""))
				{
					strWhere4=" and followid="+ application.getAttribute("str4") ;				
				
				}else
				{
					strWhere4="";
				}
				if(application.getAttribute("str5")!=null &&
					!application.getAttribute("str5").equals(""))
				{
					strWhere5=" and curflag="+ application.getAttribute("str5");				
				 
				}else
				{
					strWhere5="";
				}
				if(application.getAttribute("str6")!=null &&
					!application.getAttribute("str6").equals(""))
				{
					strWhere6=" and curretrytimes="+ application.getAttribute("str6");				
				 
				}else
				{
					strWhere6="";
				}
				if(application.getAttribute("str7")!=null &&
					!application.getAttribute("str7").equals(""))
				{
					strWhere7=" and maxretrytimes="+ application.getAttribute("str7") ;				
				
				}else
				{
					strWhere7="";
				}
				if(application.getAttribute("str8")!=null &&
					!application.getAttribute("str8").equals(""))
				{
					strWhere8=" and status="+ application.getAttribute("str8") ;				
				
				}else
				{
					strWhere8="";
				}
				String sql = "update  bat_taskproc set    busidate= '" + busidate.trim()
					+ "'  , sysid= " + sysid.trim()
					+ "  , taskno= " + taskno.trim()
					+ "  , followid= " + followid.trim()		
					+ "  , curflag= " + curflag.trim()				
					+ "  , curretrytimes= " + curretrytimes.trim()
					+ "  , maxretrytimes= " + maxretrytimes.trim()
					+ "  , status= " + status.trim()				
					+ "  where sysid ="
					+ oldprovid	+strWhere1  +strWhere3+strWhere4
					+strWhere5 +strWhere6 +strWhere7+strWhere8 ;

				int iRet = m.ModifySql(sql);

				if (iRet > 0) {
				%>
					<jsp:forward page="success.jsp"></jsp:forward>		
				<%
				} else {
				%>
					<jsp:forward page="failure.jsp"></jsp:forward>		
			<%
				}
			}
		%>
		     <input name="updateproc" type="hidden" />	
		</form>
	</body>
</html>
