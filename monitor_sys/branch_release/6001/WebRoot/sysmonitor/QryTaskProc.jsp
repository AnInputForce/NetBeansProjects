<%@ page language="java" import="com.git.base.dbmanager.*"
	contentType="text/html;charset=GBK"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<script language="javascript">
function selectrecord()
{	
	document.form1.postmethod.value="select";
	
	document.form1.submit();
}
function refreshrecord()
{	
	document.refreshform.submit();
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
    {
      document.form1.checkfalse.value="false";
      document.all.Interval.value = "";
      document.all.Submit.value="刷新";
      document.all.Interval.disabled = true;
      document.all.FreshFlag.checked=false;      
      
    }else if ((document.all.FreshFlag.checked) &&( document.all.Interval.value!="" ))
	    {
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
	    body,input,table,tr,td,th,p{
 
		font-size:12px;
 
	    }
			.inputNoBorder{			
				 border-style:none;
				 border-width:0px;			
			} 
       	</style>   
		<%
		if (request.getParameter("leftclick") != null) {
			application.removeAttribute("interval");
			application.removeAttribute("busidate");
			application.removeAttribute("sysid");
			application.removeAttribute("taskno");
			application.removeAttribute("followid");
			application.removeAttribute("curretrytimes");

			application.removeAttribute("checkfalse");

			application.removeAttribute("status");
			response.sendRedirect("QryTaskProc.jsp");
		} else if (request.getParameter("checkfalse") != null
				&& request.getParameter("checkfalse").equals("true")) {
			application.setAttribute("checkfalse", "true");
			application.removeAttribute("interval");
			application.removeAttribute("busidate");
			application.removeAttribute("sysid");
			application.removeAttribute("taskno");
			application.removeAttribute("followid");
			application.removeAttribute("curretrytimes");

			application.removeAttribute("status");
			response.sendRedirect("QryTaskProc.jsp");
		} else if (request.getParameter("checkfalse") != null
				&& request.getParameter("checkfalse").equals("false")) {
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
				busidatee = request.getParameter("busidate") == null ? ""
				: request.getParameter("busidate");
				sysidd = request.getParameter("sysid") == null ? "" : request
				.getParameter("sysid");
	
				tasknoo = request.getParameter("taskno") == null ? "" : request
				.getParameter("taskno");
				followidd = request.getParameter("followid") == null ? ""
				: request.getParameter("followid");
				curretrytimess = request.getParameter("curretrytimes") == null ? ""
				: request.getParameter("curretrytimes");

				statuss = request.getParameter("status") == null ? "" : request
				.getParameter("status");

				application.setAttribute("interval", intervall);
				application.setAttribute("busidate", busidatee);
				application.setAttribute("sysid", sysidd);
				application.setAttribute("taskno", tasknoo);
				application.setAttribute("followid", followidd);
				application.setAttribute("curretrytimes", curretrytimess);

				application.setAttribute("status", statuss);

				application.setAttribute("refresh", "true");
			} else if (application.getAttribute("refresh") != null
					&& application.getAttribute("refresh").toString().equals(
					"true")) {
		%>
			<meta http-equiv="refresh"
				content="<%=application.getAttribute("interval")%>">
		<%
				intervall = (String) application.getAttribute("interval");
				busidatee = (String) application.getAttribute("busidate");
				sysidd = (String) application.getAttribute("sysid");
				if(sysidd==null)
				{
					sysidd="0";
				}
				tasknoo = (String) application.getAttribute("taskno");
				followidd = (String) application.getAttribute("followid");
				curretrytimess = (String) application.getAttribute("curretrytimes");

				statuss = (String) application.getAttribute("status");
			} else {
				intervall = "";
				busidatee = "";
				sysidd = "";
				tasknoo = "";
				followidd = "";
				curretrytimess = "";
				maxretrytimess = "";
				statuss = "";
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
				String busidate, sysid, taskno, followid;
				String curretrytimes, status;
				String strSql = null;
				String sql, value, sSize,sysname;
				int  rows=0,cols=0;
				Manager m = Manager.getInstance();
				DBRowSet rs = null;
			%>
			<table>
				<tr >
					<td>
						当前日期
					</td>
					<td>
						<input name="busidate" type="text"  size="4"
							onkeyup="javascript:validateNum(document.all.busidate);"
							value="<%=busidatee == null ? "" : busidatee%>">
					</td>
					<td>
						系统名称
					</td>
					<td>
						<select name="sysid" style="width:50px" >
						<option value=0 selected='selected'>全部</option>
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
									
									if( sysidd.equals(sysid))
								   		sel="selected='selected'";
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
						<input name="taskno" type="text" size="4"
							onkeyup="javascript:validateNum(document.all.taskno);"
							value="<%=tasknoo == null ? "" : tasknoo%>">
					</td>
				
					<td>
						流程号
					</td>
					<td>
						<input name="followid" type="text" size="4"
							onkeyup="javascript:validateNum(document.all.followid);"
							value="<%=followidd == null ? "" : followidd%>">
					</td>

					<td>
						失败次数
					</td>
					<td>
						<input name="curretrytimes" type="text"  size="4"
							onkeyup="javascript:validateNum(document.all.curretrytimes);"
							value="<%=curretrytimess == null ? "" : curretrytimess%>">
					</td>

					<td>
						当前状态
					</td>
					<td>
						<input name="status" type="text"  size="4"
							onkeyup="javascript:validateInt(document.all.status);"
							value="<%=statuss == null ? "" : statuss%>">
					</td>
				</tr>
				<tr></tr>
				<tr></tr>
				<tr></tr>
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
					<td>
				
					</td>
					<td>
					   <input value="查询" type="button" class="button" onclick=selectrecord();>
					</td>
				</tr>
			</table>	
			
	        <hr/>
	         <tr>
	         	<input  type="label"  size="4"  disabled="disabled" <%out.print("style=' background-color: green'");%> >任务完成	 
	         	<input  type="label"  size="4"  disabled="disabled" <% out.print("style=' background-color: red'");%> >任务失败 
	         	<input  type="label"  size="4"  disabled="disabled" <% out.print("style=' background-color: #FFA500'");%> >出现错误        
	         	<input  type="label"  size="4"  disabled="disabled"  <%out.print("style=' background-color: white'");%> >初始状态 		         	
	         </tr>  
	        <hr/>	          
			<input name="postmethod" type="hidden" />
			<input name="recordindex" type="hidden" />
			<%
				String postmethod = request.getParameter("postmethod");
				if (application.getAttribute("refresh") != null) 
				{				
					postmethod = "tmd";
				}
				if (postmethod == null && application.getAttribute("refresh") == null) {
			%>
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
						流程号
					</th>
					<th>
						任务名称
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
					
					sql="select  t.busidate, t.sysid ,t.taskno ,t.followid, t.taskno,t.status,t.curflag,t.elserial,t.filename,t.curretrytimes,t.maxretrytimes ,t.curpid,t.starttime ,t.endtime ,t.failcode   from bat_taskproc t   order by t.status";

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
	
								if (c == 0 || c == 1 ||  c == 6 || c == 10 || c == 11
										|| c == 12 || c == 13 || c == 9) {
									sSize = "size='9'";
	
								} else if (c == 2  || c == 14 || c == 3
										|| c == 7) {
									sSize = "size='7'";
	
								} else if (c == 4 || c == 5 ) {
									sSize = "size='13'";
	
								} else if (c == 8) {
									sSize = "size='25'";
	
								} else {
	
									sSize = "";
								}
	
								if (c == 1) {
									provName += " and sysid =" + value;
	
									value =  m.selFirstCol(provName);	
									
								}
								if (c == 2) {
								    if(value.length()!=0)
										taskName += " and tasknolastone=" + value.substring(value.length()-1,value.length());
									else
									    taskName += " and tasknolastone=" + 0 ;
	
								}
								if (c == 3) {
									statusName += " and followid=" + value;
									taskName += " and followid=" + value;
								}
								if (c == 5) {
									String namestatus = null;
	
									if (value.equals("0")) {
										namestatus = "(0)" + "任务完成";
									} else {
										statusName += " and curstatus=" + value.trim();
									
									//System.out.println("statusNamerefresh="+statusName);
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
							if(rs.getString(r,5)!=null&& rs.getString(r,5).equals("0")) 
								out.print("style=' background-color: green'");
							else if(rs.getString(r,5)!=null&&!rs.getString(r,5).equals("0")&&!rs.getString(r,5).equals("-1")&&
							       rs.getString(r,9)!=null&& rs.getString(r,10)!=null &&!rs.getString(r,9).equals(rs.getString(r,10))&&
							       !rs.getString(r,9).equals("0"))
								out.print("style=' background-color: #ffa500'");
							else if(rs.getString(r,5)!=null&& 
							        !rs.getString(r,5).equals("0")&& 
							        !rs.getString(r,5).equals("-1")&&
							        rs.getString(r,9)!=null &&
							        rs.getString(r,10)!=null &&
							        rs.getString(r,9).equals(rs.getString(r,10))&&
							        !rs.getString(r,9).equals("0"))
								out.print("style=' background-color: red'");								
						%>
							type="text" readonly size="18" value="<%=namestatus%> " />
						<%
								continue;
								}
								if (c == 4) {
									//System.out.println("taskNamerefresh="+taskName);
									String name = m.selFirstCol(taskName);
						%>
						<input  class="inputNoBorder"
							<% 
							if(rs.getString(r,5)!=null&& rs.getString(r,5).equals("0")) 
								out.print("style=' background-color: green'");
							else if(rs.getString(r,5)!=null&& 
							       !rs.getString(r,5).equals("0")&& 
							       !rs.getString(r,5).equals("-1")&&
							       rs.getString(r,9)!=null&&
							       rs.getString(r,10)!=null &&							       
							       !rs.getString(r,9).equals(rs.getString(r,10))&&
							       !rs.getString(r,9).equals("0"))
								out.print("style=' background-color: #ffa500'");
							else if(rs.getString(r,5)!=null&& 
							        !rs.getString(r,5).equals("0")&& 
							        !rs.getString(r,5).equals("-1")&&
							        rs.getString(r,9)!=null &&
							        rs.getString(r,10)!=null &&
							        rs.getString(r,9).equals(rs.getString(r,10))&&
							        !rs.getString(r,9).equals("0"))
								out.print("style=' background-color: red'");								
						%>
							type="text" readonly size="24" value="<%=name%> " />
						<%
								continue;
								}
						%>
						<input class="inputNoBorder"
							<% 
							if(rs.getString(r,5)!=null&& rs.getString(r,5).equals("0")) 
								out.print("style=' background-color: green'");
							else if(rs.getString(r,5)!=null&& 
							       !rs.getString(r,5).equals("0")&& 
							       !rs.getString(r,5).equals("-1")&&
							       rs.getString(r,9)!=null&&
							       rs.getString(r,10)!=null &&							       
							       !rs.getString(r,9).equals(rs.getString(r,10))&&
							       !rs.getString(r,9).equals("0"))
								out.print("style=' background-color: #ffa500'");
							else if(rs.getString(r,5)!=null&& 
							        !rs.getString(r,5).equals("0")&& 
							        !rs.getString(r,5).equals("-1")&&
							        rs.getString(r,9)!=null &&
							        rs.getString(r,10)!=null &&
							        rs.getString(r,9).equals(rs.getString(r,10))&&
							        !rs.getString(r,9).equals("0"))
								out.print("style=' background-color: red'");								
						%>
							name=putname[<%=r%>][<%=c+1%>] readonly='readonly' type="text"
							<%=sSize%> value="<%=value%>">
					</td>
					<%}%>
				</tr>
				<%}}%>
			</table>			
			<%
				} else if (postmethod.equals("select") 	|| application.getAttribute("refresh") != null) {

					busidate = request.getParameter("busidate");
					sysid = request.getParameter("sysid");
					taskno = request.getParameter("taskno");
					followid = request.getParameter("followid");
					curretrytimes = request.getParameter("curretrytimes");

					status = request.getParameter("status");

					if (application.getAttribute("refresh") != null) {
						busidate = busidatee;
						sysid = sysidd;
						taskno = tasknoo;
						followid = followidd;
						curretrytimes = curretrytimess;
						status = statuss;
					}

					if (busidate == null)
						busidate = "";
					if (sysid == null)
						sysid = "";
					if (taskno == null)
						taskno = "";
					if (followid == null)
						followid = "";
					if (curretrytimes == null)
						curretrytimes = "";
					if (status == null)
						status = "";

					strSql = "1>0";

					if (busidate.trim().length() != 0) {
						strSql = strSql + "  and  t.busidate = " + busidate;
					}

					if (sysid.trim().length() != 0) {
						if(!sysid.trim().equals("0"))
						{
							strSql = strSql + "  and t.sysid  =" + sysid;
						}
					}
					if (taskno.trim().length() != 0) {
						strSql = strSql + "  and t.taskno =  " + taskno;

					}
					if (followid.trim().length() != 0) {
						strSql = strSql + "  and t.followid =  " + followid;

					}
					if (curretrytimes.trim().length() != 0) {
						strSql = strSql + "  and t.curretrytimes =" + curretrytimes;

					}
					if (status.trim().length() != 0) {
						strSql = strSql + "  and t.status = " + status;

					}
			%>
			<table border=1>
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
						流程号
					</th>
					<th>
						任务名称
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
					sql = "select  t.busidate, t.sysid ,t.taskno , t.followid,t.taskno,t.status,t.curflag,t.elserial,t.filename,t.curretrytimes,t.maxretrytimes ,t.curpid,t.starttime ,t.endtime ,t.failcode   from bat_taskproc t  where  "
						+ strSql + " order by t.status";

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
	
								if (c == 0 || c == 1 ||  c == 6 || c == 10 || c == 11
										|| c == 12 || c == 13 || c == 9) {
									sSize = "size='9'";
	
								} else if (c == 2  || c == 14 || c == 3
										|| c == 7) {
									sSize = "size='7'";
	
								} else if (c == 4 || c == 5) {
									sSize = "size='13'";
	
								} else if (c == 8) {
									sSize = "size='25'";
	
								} else {
	
									sSize = "";
								}
	
								if (c == 1) {
									
	
									provName += " and sysid =" + value;
	
									value =  m.selFirstCol(provName);	
									
								}
								if (c == 2) {
								 	if(value.length()!=0)
										taskName += " and tasknolastone=" + value.substring(value.length()-1,value.length());
									else
									    taskName += " and tasknolastone=" + 0 ;
	
								}
								if (c == 3) {
									taskName += " and followid=" + value;
									statusName += " and followid=" + value;
								}
								if (c == 5) {
									String namestatus = null;
	
									if (value.equals("0")) {
										namestatus = "(0)" + "任务完成";
									} else {
										statusName += " and curstatus=" + value.trim();
										//System.out.println("statusNameselect="+statusName);
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
							if(rs.getString(r,5)!=null&& rs.getString(r,5).equals("0")) 
								out.print("style=' background-color: green'");
							else if(rs.getString(r,5)!=null&& 
							       !rs.getString(r,5).equals("0")&& 
							       !rs.getString(r,5).equals("-1")&&
							       rs.getString(r,9)!=null&&
							       rs.getString(r,10)!=null &&							       
							       !rs.getString(r,9).equals(rs.getString(r,10))&&
							       !rs.getString(r,9).equals("0"))
								out.print("style=' background-color: #ffa500'");
							else if(rs.getString(r,5)!=null&& 
							        !rs.getString(r,5).equals("0")&& 
							        !rs.getString(r,5).equals("-1")&&
							        rs.getString(r,9)!=null &&
							        rs.getString(r,10)!=null &&
							        rs.getString(r,9).equals(rs.getString(r,10))&&
							        !rs.getString(r,9).equals("0"))
								out.print("style=' background-color: red'");								
						%>
							type="text" readonly size="18" value="<%=namestatus%> " />
						<%
								continue;
								}
								if (c == 4) {
									//System.out.println("taskNameselect="+taskName);
									String name = m.selFirstCol(taskName);
						%>
						<input  class="inputNoBorder"
							<% 
							if(rs.getString(r,5)!=null&& rs.getString(r,5).equals("0")) 
								out.print("style=' background-color: green'");
							else if(rs.getString(r,5)!=null&& 
							       !rs.getString(r,5).equals("0")&& 
							       !rs.getString(r,5).equals("-1")&&
							       rs.getString(r,9)!=null&&
							       rs.getString(r,10)!=null &&							       
							       !rs.getString(r,9).equals(rs.getString(r,10))&&
							       !rs.getString(r,9).equals("0"))
								out.print("style=' background-color: #ffa500'");
							else if(rs.getString(r,5)!=null&& 
							        !rs.getString(r,5).equals("0")&& 
							        !rs.getString(r,5).equals("-1")&&
							        rs.getString(r,9)!=null &&
							        rs.getString(r,10)!=null &&
							        rs.getString(r,9).equals(rs.getString(r,10))&&
							        !rs.getString(r,9).equals("0"))
								out.print("style=' background-color: red'");								
						%>
							type="text" readonly size="24" value="<%=name%> " />
						<%
								continue;
								}
						%>
						<input class="inputNoBorder"
							<% 
							if(rs.getString(r,5)!=null&& rs.getString(r,5).equals("0")) 
								out.print("style=' background-color: green'");
							else if(rs.getString(r,5)!=null&& 
							       !rs.getString(r,5).equals("0")&& 
							       !rs.getString(r,5).equals("-1")&&
							       rs.getString(r,9)!=null&&
							       rs.getString(r,10)!=null &&							       
							       !rs.getString(r,9).equals(rs.getString(r,10))&&
							       !rs.getString(r,9).equals("0"))
								out.print("style=' background-color: #ffa500'");
							else if(rs.getString(r,5)!=null&& 
							        !rs.getString(r,5).equals("0")&& 
							        !rs.getString(r,5).equals("-1")&&
							        rs.getString(r,9)!=null &&
							        rs.getString(r,10)!=null &&
							        rs.getString(r,9).equals(rs.getString(r,10))&&
							        !rs.getString(r,9).equals("0"))
								out.print("style=' background-color: red'");								
						%>
							name=putname[<%=r%>][<%=c+1%>] readonly='readonly' type="text"
							<%=sSize%> value="<%=value%>">
					</td>
					<%}%>
				</tr>
				<%}}%>
			</table>			
			<%}%>
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
