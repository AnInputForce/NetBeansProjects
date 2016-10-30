<%@ page language="java" import="java.util.*,java.sql.*,com.git.base.cfg.Service"  contentType="text/html;charset=GBK"%>
<jsp:directive.page import="com.git.base.dbmanager.MySdp"/>
<jsp:directive.page import="com.git.base.dbmanager.DBRowSet"/>
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
			.inputNoBorder{			
				 border-style:none;
				 border-width:0px;			
			} 
       	</style>   
		<%
		
		if (request.getParameter("leftclick") != null) {
			application.removeAttribute("interval");	
			application.removeAttribute("maxtime");	
		
			application.removeAttribute("checkfalse");
			response.sendRedirect("SdpTran.jsp");
		} else if (request.getParameter("checkfalse") != null
				&& request.getParameter("checkfalse").equals("true")) {
			application.setAttribute("checkfalse", "true");
			application.removeAttribute("interval");			
			response.sendRedirect("SdpTran.jsp");
		} else if (request.getParameter("checkfalse") != null
				&& request.getParameter("checkfalse").equals("false")) {
			application.removeAttribute("checkfalse");
		}
       	%>
		<%!String intervall = "";%>
		<%
		if (request.getParameter("refreshtime") != null) 
		{
		%>
			<meta http-equiv="refresh" 	content="<%=request.getParameter("refreshtime")%>;">
		<%
			intervall = request.getParameter("refreshtime");
			application.setAttribute("interval", intervall);
			application.setAttribute("refresh", "true");
		} else if (application.getAttribute("refresh") != null
			&& application.getAttribute("refresh").toString().equals("true")) 
		{
		%>
			<meta http-equiv="refresh"
				content="<%=application.getAttribute("interval")%>">
		<%
			intervall = (String) application.getAttribute("interval");
				
		} else 
		{
			intervall = "";
		}
	%>
	</head>
	<body><br>  
		<form name="refreshform" method="post">		   
		</form>			
		<form name="form1" method="post" >
		    <input  type="hidden" name="checkfalse"/>
		     <input  type="hidden" name="maxtime"/>
		   
			<input type="hidden" name="refreshtime" />
			
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
		<table  border=1 cellspacing="0" cellpadding="0">
			<tr>
				<th>
					交易日期
				</th>
				<th>
					交易时间
				</th>
				<th>
					交易代码
				</th>					
				<th>
					交易名称
				</th>
				<th>
					机构代码
				</th>
				<th>
					机构名称
				</th>
				<th>
					响应代码
				</th>
				<th>
					响应说明
				</th>					
			</tr>
			<%
			try	{				
			String sql=null ,sqlsdp=null, value = null, value1 = null;	
				int cols=0 , rows=0;		
		
			
			MySdp  dbsdp =  MySdp.getInstance();
		
			DBRowSet rssdp=null;
		
			sqlsdp = "select to_char(sysdate,'yyyyMMddHHmiss' )  from dual ";

				value= dbsdp.selFirstCol(sqlsdp);
				
				if (value == null)
					value = "00000000000000";
				
				if ( application.getAttribute("maxtime")==null ) 				
				{
					sqlsdp = "select max(asz0date || asz0lctm ) from aspfz0";
					//sqlsdp = "select max(asz0date || asz0lctm ) from aspfz0,atpf00,papf30,papf90 where asz0trco=at00jydm and asz0dpno=pa30dpno and asz0rsco=pa90rpsco ";
					value1= dbsdp.selFirstCol(sqlsdp);
					if (value1 == null)
						value1 = "00000000000000";
					
					application.setAttribute("maxtime", value1);	
				
	 			}else 
	 			{
	 			    value1 = application.getAttribute("maxtime").toString();
	 			 
	 			}					
				sql="select asz0date,asz0lctm,asz0trco,at00jymc,asz0dpno,pa30cname,asz0rsco,pa90rpsnm from aspfz0,atpf00,papf30,papf90 where asz0trco=at00jydm and asz0dpno=pa30dpno and asz0rsco=pa90rpsco " + 
			      " and (asz0date|| asz0lctm) >= '" + value1 + "' order by  asz0date||asz0lctm desc";
	
				rssdp = dbsdp.selectSql(sql);
				
				cols = rssdp.getColumnCount();
				rows = rssdp.getRowCount();
                                if( rows> 30 )
                                    rows = 30;
				for(int i =0; i<rows;i++)
				{
				
				%><tr><%
				for (int j = 0; j < cols; j++) 
				{
					%><td><%
					value = rssdp.getString(i,j);
					if (value == null) 
					{
						value = "";
					}	
					%>
						<input	type="text" readonly size="18" value="<%=value%> " />
					</td>
				<%}%>
				</tr>
			<%}		
			
		}
		catch (Exception se) {
			se.printStackTrace();
		}%>
		
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
		<%}
	%>
	
	</body>
</html>
