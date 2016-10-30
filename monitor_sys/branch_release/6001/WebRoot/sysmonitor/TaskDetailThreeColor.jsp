<%@ page language="java" import="com.git.base.dbmanager.*"
	contentType="text/html;charset=GBK"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<script language="javascript">

function refreshrecord()
{	
	document.refreshform.submit();
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
function EnableInterval()
{
	if (document.all.FreshFlag.checked)
	{
	    document.all.Interval.disabled = false;	  
	}
	else
	{
	    document.all.Interval.value = "";
	    document.all.Interval.disabled = true;
	}
}
function refresh()
{
    if(document.all.Submit.value=="停止")
    {//不刷新
      document.form1.checkfalse.value="false";
      document.all.Interval.value = "";
      document.all.Submit.value="刷新";
      document.all.Interval.disabled = true;
      document.all.FreshFlag.checked=false;      
      
    }else if ((document.all.FreshFlag.checked) &&( document.all.Interval.value!="" ))
    {//刷新
    	document.form1.refreshtime.value=document.all.Interval.value;
    	document.form1.checkfalse.value="true";
    }   
    document.form1.submit();
}
</script>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<style>
			.inputNoBorder{			
				 border-style:none;
				 border-width:0px;			
			} 
       	</style>       	
		<%
			if (request.getParameter("checkfalse") == null)
			{				
			}else if (request.getParameter("checkfalse") != null
					&& request.getParameter("checkfalse").equals("true")) {
					//刷新
				application.setAttribute("checkfalse", "true");						
			} else if (request.getParameter("checkfalse") != null
					&& request.getParameter("checkfalse").equals("false")) {
					//不刷新
				application.removeAttribute("checkfalse");
			}
		%>
		<%!String intervall = "", busidatee = "", sysidd = "", tasknoo = "",
			followidd = "", curretrytimess = "", maxretrytimess = "",
			statuss = "";%>
		<%
		if (request.getParameter("refreshtime") != null) {
		%>
			<meta http-equiv="refresh" 	content="<%=request.getParameter("refreshtime")%>;">
		<%
				intervall = request.getParameter("refreshtime");
				
				application.setAttribute("interval", intervall);
			

				application.setAttribute("refresh", "true");
			} else if (application.getAttribute("refresh") != null
					&& application.getAttribute("refresh").toString().equals(
					"true")) {
		%>
			<meta http-equiv="refresh"
				content="<%=application.getAttribute("interval")%>">
		<%				
				intervall = (String) application.getAttribute("interval");
			
			} else {
				intervall = "";				
			}
		%>
	</head>
	<body><br>  
		<form name="refreshform" method="post">		   
		</form>		
		<form name="form1" method="post">
		     <input name="checkfalse" type="hidden"/>
			<input type="hidden" name="refreshtime" />
			<%
				String  sysid, sql, value, sSize;
				int  rows=0,cols=0;
				Manager m = Manager.getInstance();
				DBRowSet rs = null;
			%>
			<table>				
				<tr >
					<td>
						定时刷新
					</td>
					<td>
						<input type="checkbox" name="FreshFlag" onclick=EnableInterval() >
					</td>
					<td>
						刷新间隔
					</td>
					<td>		
						<input type="text" name="Interval" onkeyup="javascript:validateNum(document.all.Interval);"
							size="5"	value="<%=intervall == null ? "" : intervall%>">
		
					</td>
					<td  align="left">秒					    
					</td>
					<td>
					   <input type="button" name="Submit" value="刷新" onclick=refresh()>
					</td>			
				</tr>
			</table>				
	        <hr/>
	         <tr>
	         	<input  type="label"  size="4"  disabled="disabled" <%out.print("style=' background-color: green'");%> >任务完成	 
	         	<input  type="label"  size="4"  disabled="disabled" <% out.print("style=' background-color: red'");%> >任务失败 
	         	<input  type="label"  size="4"  disabled="disabled" <% out.print("style=' background-color: #FFA500'");%> >出现错误        
	         </tr>  
	        <hr/>	          
			<input name="postmethod" type="hidden" />
			<input name="recordindex" type="hidden" />
			
			<table  border=1 cellspacing="0" cellpadding="0">
				<tr>
					<th>
						当前日期
					</th>
					<th>
						系统名称
					</th>
					<th>
						任务号
					</th>

					<th>
						任务名称
					</th>
					<th>
						流程号
					</th>

					<th>
						当前状态
					</th>

					<th>
						当前标志
					</th>

					<th>
						流水号
					</th>
					<th>
						文件名称
					</th>
					<th>
						当前次数
					</th>
					<th>
						最大次数
					</th>
					<th>
						当前进程
					</th>
					<th>
						开始时间
					</th>
					<th>
						结束时间
					</th>
					<th>
						错误码
					</th>

				</tr>
				<%
					sysid=request.getParameter("sysid");
					sql="select  t.busidate, t.sysid ,t.taskno , t.taskno,t.followid,"+
						" t.status,t.curflag,t.elserial,t.filename,t.curretrytimes,t.maxretrytimes ,"+
						" t.curpid,t.starttime ,t.endtime ,t.failcode   from bat_taskproc t  " +
						" where t.sysid='"+sysid+"' order by t.status";
					rs = m.selectSql(sql);

					if(rs !=null)
					{
						rows = rs.getRowCount();
						cols = rs.getColumnCount();

						for(int r=0 ; r< rows;r++)
						{
							%><tr><%

							String taskName = "select tranname from bat_taskreg where 1>0";
							String statusName = "select note from bat_taskoperation where 1>0";
							String provName = "select sysname from bat_provname where 1>0 ";
					
							for(int c = 0 ; c< cols; c++)
							{
							%><td><%
								value = rs.getString(r,c);
	
								if (value == null) {
									value = "";
								}
	
								if (c == 0 ||  c == 6 || c == 10 || c == 11
										|| c == 12 || c == 13 || c == 9) {
									sSize = "size='9'";
	
								} else if (c == 2 || c == 1 || c == 14 || c == 4
										|| c == 7) {
									sSize = "size='7'";
	
								} else if (c == 3 || c == 5) {
									sSize = "size='13'";
	
								} else if (c == 8) {
									sSize = "size='25'";
	
								} else {
	
									sSize = "";
								}
	
								if (c == 1) {
									taskName += " and sysid=" + value;
	
									provName += " and sysid =" + value;
	
									value =  m.selFirstCol(provName);	
									
								}
								if (c == 2) {
									taskName += " and taskno=" + value;
	
								}
								if (c == 4) {
									statusName += " and followid=" + value;
								}
								if (c == 5) {
									String namestatus = null;
	
									if (value.equals("0")) {
										namestatus = "(0)" + "任务完成";
									} else {
										statusName += " and curstatus=" + value.trim();
										namestatus = m.selFirstCol(statusName);
	
										if (namestatus == null
										|| namestatus.trim().length() == 0) {
									namestatus = "(" + value.trim() + ")"
											+ "流程表中未定义该状态";
										} else {
									namestatus = "(" + value.trim() + ")"
											+ namestatus.trim();
										}
									}
						%>
						<input  class="inputNoBorder"
							<% 								
							if(rs.getString(r,5)!=null&& 
							        !rs.getString(r,5).equals("0")&& 
							        !rs.getString(r,5).equals("-1")&&
							        rs.getString(r,9)!=null &&
							        rs.getString(r,10)!=null &&
							        rs.getString(r,9).equals(rs.getString(r,10))&&
							        !rs.getString(r,9).equals("0"))
								out.print("style=' background-color: red'");
							else if(rs.getString(r,5)!=null&& 
							       !rs.getString(r,5).equals("0")&& 
							       !rs.getString(r,5).equals("-1")&&
							       rs.getString(r,9)!=null&&
							       rs.getString(r,10)!=null &&							       
							       !rs.getString(r,9).equals(rs.getString(r,10))&&
							       !rs.getString(r,9).equals("0"))
								out.print("style=' background-color: #ffa500'");	
							else {
								out.print("style=' background-color: green'");
								}										
						%>
							type="text" readonly size="18" value="<%=namestatus%> " />
						<%
								continue;
								}
								if (c == 3) {
									String name = m.selFirstCol(taskName);
						%>
						<input  class="inputNoBorder"
							<% 
							if(rs.getString(r,5)!=null&& 
							        !rs.getString(r,5).equals("0")&& 
							        !rs.getString(r,5).equals("-1")&&
							        rs.getString(r,9)!=null &&
							        rs.getString(r,10)!=null &&
							        rs.getString(r,9).equals(rs.getString(r,10))&&
							        !rs.getString(r,9).equals("0"))
								out.print("style=' background-color: red'");
							else if(rs.getString(r,5)!=null&& 
							       !rs.getString(r,5).equals("0")&& 
							       !rs.getString(r,5).equals("-1")&&
							       rs.getString(r,9)!=null&&
							       rs.getString(r,10)!=null &&							       
							       !rs.getString(r,9).equals(rs.getString(r,10))&&
							       !rs.getString(r,9).equals("0"))
								out.print("style=' background-color: #ffa500'");	
							else {								
								out.print("style=' background-color: green'");
							}								
						%>
							type="text" readonly size="24" value="<%=name%> " />
						<%
								continue;
								}
						%>
						<input class="inputNoBorder"
							<% 
							if(rs.getString(r,5)!=null&& 
							        !rs.getString(r,5).equals("0")&& 
							        !rs.getString(r,5).equals("-1")&&
							        rs.getString(r,9)!=null &&
							        rs.getString(r,10)!=null &&
							        rs.getString(r,9).equals(rs.getString(r,10))&&
							        !rs.getString(r,9).equals("0"))
								out.print("style=' background-color: red'");
							else if(rs.getString(r,5)!=null&& 
							       !rs.getString(r,5).equals("0")&& 
							       !rs.getString(r,5).equals("-1")&&
							       rs.getString(r,9)!=null&&
							       rs.getString(r,10)!=null &&							       
							       !rs.getString(r,9).equals(rs.getString(r,10))&&
							       !rs.getString(r,9).equals("0"))
								out.print("style=' background-color: #ffa500'");	
							else {								
								out.print("style=' background-color: green'");
							}											
						%>
							name=putname[<%=r%>][<%=c+1%>] readonly='readonly' type="text"
							<%=sSize%> value="<%=value%>">
					</td>
					<%}%>
				</tr>
				<%}}%>
			</table>			
		</form>
		<%
		if (application.getAttribute("checkfalse") == null) {
		%>
		     <script type="text/javascript">
		       document.all.FreshFlag.checked=false;
		       document.all.Interval.disabled = true;
		     </script>
		<%
		} else {		
		%>
		     <script type="text/javascript">
		       document.all.Submit.value="停止";
		       document.all.FreshFlag.checked=true;
		       document.all.Interval.disabled = false;
		     </script>	
	     <%}%>
	</body>
</html>
