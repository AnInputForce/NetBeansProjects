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
			String busidate,sysid,taskno,followid,sysname;
			String curretrytimes,maxretrytimes,status;
			String strSql=null;
			String sql,value, sSize;
			int index, iRet;
			int  rows=0,cols=0;
			Manager m = Manager.getInstance();
			DBRowSet rs = null;
		%>
			<table  >
				<tr  >
					<td >
						当前日期
					</td>
					<td >
						<input name="busidate" type="text"  onkeyup="javascript:validateNum(document.all.busidate);">
					</td>
					<td>
						系统名称
					</td>
					<td>
						<select name="sysid" style="width:150px" >
						<option value=0 selected='selected'>全部</option>
						<%	
							rs = m.selectSql("select sysid,sysname from  bat_provname order by sysid");
							
							if(rs!=null)
							{
								rows = rs.getRowCount();
								cols = rs.getColumnCount();

								for(int r=0 ; r< rows;r++)
								{
									sysid = rs.getString(r,0);

									sysname = rs.getString(r,1);

									%> 
						  			<option value="<%=sysid %>"   ><%=sysname%></option>
						  		<%}
						  	}%>
						</select>						
					</td>	
					<td>
						任务号
					</td>
					<td>
						<input name="taskno" type="text"  onkeyup="javascript:validateNum(document.all.taskno);">
					</td>
				</tr>
				<tr>
					<td>
						流程号
					</td>
					<td>
						<input name="followid" type="text"  onkeyup="javascript:validateNum(document.all.followid);">
					</td>
				
					<td>
						当前重复次数
					</td>
					<td>
						<input name="curretrytimes" type="text"  onkeyup="javascript:validateNum(document.all.curretrytimes);">
					</td>

					<td>
						最大重复次数
					</td>
					<td>
						<input name="maxretrytimes" type="text" onkeyup="javascript:validateNum(document.all.maxretrytimes);">
					</td>
				</tr>
				<tr>
					<td>
						当前状态
					</td>
					<td>
						<input name="status" type="text"  onkeyup="javascript:validateInt(document.all.status);" >
					</td>
					<td>&nbsp;
					</td>
					<td>
						<input value="添加" type="button" class="button"
							onclick=insertrecord();>
							&nbsp;&nbsp;&nbsp;&nbsp;
						<input value="查询" type="button" class="button"
							onclick=selectrecord();>
					</td>
					
					<td>
						&nbsp;
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
				<tr>
					<th>
						序号
					</th>
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
						当前次数
					</th>  
					<th>
						最大次数
					</th>				
					<th>
						当前状态
					</th>
					<th>
						状态名称
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
					
					<th  colspan="2">
						操  作
					</th>
				</tr>
				<%
					rs = m.selectSql("select  t.busidate, t.sysid ,t.taskno , t.followid,t.taskno,t.curretrytimes,t.maxretrytimes ,t.status,t.status,t.curflag,t.elserial,t.filename,t.curpid,t.starttime ,t.endtime ,t.failcode  from bat_taskproc t order by t.status");					
					if(rs !=null)
					{
						rows = rs.getRowCount();
						cols = rs.getColumnCount();
						
						for(int r=0;r<rows;r++)
						{
						%>
						<tr >
							<td>
								<input type="text" readonly="readonly"  value=<%=r+1%>  size="4">
							</td>
							<%
								String taskName = "select tranname from bat_taskreg where 1>0";
								String statusName = "select note from bat_taskoperation where 1>0";
								String provName = "select sysname from bat_provname where 1>0 ";
					
								for(int c = 0; c< cols; c++ )
								{
								%><td><%
								   value = rs.getString(r,c);
														   
								   if(value==null)
								   {
								     value = "";
								   }
		
								  if(c==0 || c==1 ||c==6 ||c==7 ||c==5||c==9  ||c==12 ||c==13 ||c==14)
								   {
								       sSize= "size='8'";
								      						   
								   }  else if( c==2  || c ==15 || c ==3 ||c==10  )
								   {
								       sSize= "size='6'";
								       
								   }   else if( c==8 )
								   {						       
								   	   sSize= "size='12'";
								       
								   } else if( c==11 )
								   {						       
								   	   sSize= "size='24'";
								       
								   }   else {
								     
								       sSize= "";
								   }
								   
								  if(c==1){
								   // taskName  += " and sysid="+value;
								    
								    provName += " and sysid =" + value;
	
									value =  m.selFirstCol(provName);	
								
								  }
								  if(c==2){
								    if(value.length()!=0)
										taskName += " and tasknolastone=" + value.substring(value.length()-1,value.length());
									else
									    taskName += " and tasknolastone=" + 0 ;
								  }
								  if(c==3){
								    taskName  += " and followid="+value;
								    statusName  += " and followid=" +value;						   
								  }
								  if(c==7){
								    statusName  += " and curstatus=" +value;						   
								  }
								  if(c==8){
								  
									   String namestatus = m.selFirstCol(statusName);
									   if(value.equals("0"))
									   {
									   		namestatus="任务完成";
									   }										  
									  %>
										<input type ="text" readonly size="8" value="<%=namestatus %> "/>
							          <%
										continue;
								  }
								  if(c==4){
								  //System.out.println("taskName1="+taskName);
									   String name = m.selFirstCol(taskName);
									  
									  %>
										<input type ="text" readonly size="12" value="<%=name %> "/>
							          <%
										continue;
								  }
								 %>
									<input   name=putname[<%=r%>][<%=c+1%>] readonly='readonly'  type="text"
										 <%= sSize%> value="<%=value%>"    >
										 
								</td>
							<%}%>
								<td>
									<input  value="修改" type="button" name=update[<%=r%>] onclick="updaterecord(<%=r%>)";>
								</td>
								<td>	
									<input   value="删除" type="button" name=delete[<%=r%>] onclick="deleterecord(<%=r%>)";>
								</td>
						</tr>
						<%}}%>		
			</table>
            <%
            } else if(postmethod.equals("select"))
            {           
            	busidate=request.getParameter("busidate");
				sysid=request.getParameter("sysid");
				taskno=request.getParameter("taskno");
				followid=request.getParameter("followid");
				curretrytimes=request.getParameter("curretrytimes");
				maxretrytimes=request.getParameter("maxretrytimes");
				status=request.getParameter("status");
			
				if ( busidate == null) busidate="";		
				if ( taskno == null) taskno="";		
				if ( followid == null  ) followid="";		
				if ( curretrytimes == null ) curretrytimes="";		
				if ( maxretrytimes == null ) maxretrytimes="";		
				if ( status  == null ) status="";	
            
       			strSql = "1>0";
       			
				if ( busidate.trim().length() != 0) {
					strSql = strSql + " and  t.busidate = " + busidate ;
				}

				if ( sysid.trim().length() != 0) {
					if(!sysid.trim().equals("0"))
					{
						strSql = strSql + "  and sysid  =" + sysid;
					}					
				}
				if ( taskno.trim().length() != 0) {
					strSql = strSql + "  and taskno =  " + taskno;					
				}
				if ( followid.trim().length() != 0) {
					strSql = strSql + "  and followid =  " + followid;
				}
				if (curretrytimes.trim().length() != 0) {
					strSql = strSql + "  and curretrytimes =" + curretrytimes;
				}
				if (maxretrytimes.trim().length() != 0) {
					strSql = strSql + "  and maxretrytimes =" + maxretrytimes;
				}	
				if ( status.trim().length() != 0) {
					strSql = strSql + "  and status = " + status;
				}					
				
          %>
            <table border=1> 
				<tr >
					<th >
						序号
					</th>
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
						当前次数
					</th>  
					<th>
						最大次数
					</th>				
					<th>
						当前状态
					</th>
					<th>
						状态名称
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
					<th  colspan="2">
						操  作
					</th>
				</tr>
				<%
					sql = "select  t.busidate, t.sysid ,t.taskno , t.followid,t.taskno,t.curretrytimes,t.maxretrytimes ,t.status,t.status,t.curflag,t.elserial,t.filename,t.curpid,t.starttime ,t.endtime ,t.failcode  from bat_taskproc t  where  " + strSql + " order by t.status";
					rs = m.selectSql(sql);
					if(rs !=null)
					{
						rows = rs.getRowCount();
						cols = rs.getColumnCount();
						
						for(int r=0;r<rows;r++)
						{
						%>
						<tr >
							<td>
								<input type="text" readonly="readonly"  value=<%=r+1%>  size="4">
							</td>
							<%
								String taskName = "select tranname from bat_taskreg where 1>0";
								String statusName = "select note from bat_taskoperation where 1>0";
								String provName = "select sysname from bat_provname where 1>0 ";
					
								for(int c = 0; c< cols; c++ )
								{
								%>
								<td>
								<%
								   value = rs.getString(r,c);
														   
								   if(value==null)
								   {
								     value = "";
								   }
		
								  if(c==0 || c==1 ||c==6 ||c==7 ||c==5||c==9  ||c==12 ||c==13 ||c==14)
								   {
								       sSize= "size='8'";
								      						   
								   }  else if( c==2  || c ==15 || c ==3 ||c==10  )
								   {
								       sSize= "size='6'";
								       
								   }   else if( c==8 )
								   {						       
								   	   sSize= "size='12'";
								       
								   } else if( c==11 )
								   {						       
								   	   sSize= "size='24'";
								       
								   }   else {
								     
								       sSize= "";
								   }
								   
								  if(c==1){
								    //taskName  += " and sysid="+value;
								    
								    provName += " and sysid =" + value;
	
									value =  m.selFirstCol(provName);	
								  }
								 
								  if(c==2){
								    if(value.length()!=0)
										taskName += " and tasknolastone=" + value.substring(value.length()-1,value.length());
									else
									    taskName += " and tasknolastone=" + 0 ;
								  }
								  if(c==3){
								    taskName  += " and followid="+value;
								    statusName  += " and followid=" +value;				
								  }
								  if(c==7){
								    statusName  += " and curstatus=" +value;						   
								  }
								  if(c==8){
								  
									   String namestatus = m.selFirstCol(statusName);
									   if(value.equals("0"))
									   {
									   		namestatus="任务完成";
									   }										  
									  %>
										<input type ="text" readonly size="8" value="<%=namestatus %> "/>
							          <%
										continue;
								  }
								  if(c==4){
								  //System.out.println("tasknameselect="+taskName);
									   String name = m.selFirstCol(taskName);
									  
									  %>
										<input type ="text" readonly size="12" value="<%=name %> "/>
							          <%
										continue;
								  }
								 %>
									<input   name=putname[<%=r%>][<%=c+1%>] readonly='readonly'  type="text"
										 <%= sSize%> value="<%=value%>"    >							 
								</td>
							<%}%>
								<td>
									<input  value="修改" type="button" name=update[<%=r%>] onclick="updaterecord(<%=r%>)";>
								</td>
								<td>	
									<input   value="删除" type="button" name=delete[<%=r%>] onclick="deleterecord(<%=r%>)";>
								</td>
						</tr>
						<%}}%>		
			</table>						
            <%            
            }
			else if (postmethod.equals("insert")) {
			
				busidate=request.getParameter("busidate");
				sysid=request.getParameter("sysid");
				taskno=request.getParameter("taskno");
				followid=request.getParameter("followid");
				curretrytimes=request.getParameter("curretrytimes");
				maxretrytimes=request.getParameter("maxretrytimes");
				status=request.getParameter("status");
				
				if ( busidate == null) busidate="";		
				if ( sysid == null) sysid="";		
				if ( taskno == null) taskno="";		
				if ( followid == null || curretrytimes.trim().length()==0 ) followid="-1";		
				if ( curretrytimes == null || curretrytimes.trim().length()==0) curretrytimes="0";		
				if ( maxretrytimes == null || maxretrytimes.trim().length()==0) maxretrytimes="5";		
				if ( status == null || status.trim().length()==0) status="-1";		
 
				if (!busidate.equals("")&&!sysid.equals("")&&!taskno.equals("")) {
					sql = "insert into bat_taskproc values('" + busidate.trim()
							+ "','" + sysid.trim() + "','" + taskno.trim() + "','" + followid.trim()
							+ "'," + "0" + " , '' " + " , 0 " +" , 0 " +" , 0 " 
							+ " , 0 " + ",'" + curretrytimes.trim() + "','" + maxretrytimes.trim() 
							+ "','" + status.trim()	+ "'," + "''" +  ")";

					iRet = m.ModifySql(sql);
	
				}
			%>
				<script type="text/javascript">
				    document.refreshform.submit();
				 </script>
			<%
			} else if (postmethod.equals("update")) {

				String str1, str2, str3, str4,str5,str6,str7,str8;
		
				if (request.getParameter("recordindex") != null
					&& !request.getParameter("recordindex").trim().equals(""))
				{
					index = Integer.parseInt(request.getParameter("recordindex"));
					
					str1 = request.getParameter("putname[" + index + "][1]");
					str2 = request.getParameter("putname[" + index + "][2]");
					str3 = request.getParameter("putname[" + index + "][3]");
					str4 = request.getParameter("putname[" + index + "][4]");
					str5 = request.getParameter("putname[" + index + "][10]");
					str6 = request.getParameter("putname[" + index + "][6]");
					str7 = request.getParameter("putname[" + index + "][7]");
					str8 = request.getParameter("putname[" + index + "][8]");	
				
					if ( str1 == null) str1="";		
					if ( str2 == null) str2="";		
					if ( str3 == null) str3="";		
					if ( str4 == null) str4="";		
					if ( str5 == null) str5="";	
					if ( str6 == null) str6="";		
					if ( str7 == null) str7="";		
					if ( str8 == null) str8="";					
				
					application.setAttribute("str1", str1);
					application.setAttribute("str2", encode(str2));
					application.setAttribute("str3", str3);
					application.setAttribute("str4", str4);
					application.setAttribute("str5", str5);
					application.setAttribute("str6", str6);
					application.setAttribute("str7", str7);
					application.setAttribute("str8", str8);	
				//System.out.println("str2:"+str2);
			%>
				<script> window.open("updateproc.jsp");	</script>
			<%
				}
		%>
			<script type="text/javascript">
			    document.refreshform.submit();
			</script>
		<%
			} else if (postmethod.equals("delete")) {
			
				index = Integer.parseInt(request.getParameter("recordindex"));				
		    	
		    	busidate = request.getParameter("putname[" + index + "][1]");
				sysname = request.getParameter("putname[" + index + "][2]");
				taskno = request.getParameter("putname[" + index + "][3]");
			
			//System.out.println("busidate:"+busidate+"sysname:"+encode(sysname)+"taskno:"+taskno);	
		 		
				String provName = "select sysid from bat_provname where sysname='"+encode(sysname)+"'";
			//System.out.println("provName:"+provName);	
		 
				sysid =  m.selFirstCol(provName);	
		
				if ( busidate == null) busidate="";		
				if ( sysid == null) sysid="";		
				if ( taskno == null) taskno="";		
			//System.out.println("busidate:"+busidate+"sysid:"+sysid+"taskno:"+taskno);	
		   	
				sql = "delete from bat_taskproc where  busidate= '" + busidate.trim() + 
					"' and  sysid= '" + sysid.trim()+ "'  and  taskno= '" + taskno.trim()+ "'";
			//System.out.println(sql);	
				
				iRet = m.ModifySql(sql);
			%>
				<script type="text/javascript">
				    document.refreshform.submit();
				</script>
		<%}%>
		</form>
	</body>
</html>
