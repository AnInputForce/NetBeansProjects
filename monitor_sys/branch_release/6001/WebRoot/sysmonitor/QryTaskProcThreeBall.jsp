<%@ page language="java" import="com.app.*,java.util.*,com.git.base.dbmanager.Manager"
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

function EnableInterval()
{
	if (document.all.FreshFlag.checked)
	{
	   // document.refreshform.checkfalse.value="true";
	    document.all.Interval.disabled = false;
	   // document.refreshform.submit();		
	}
	else
	{
	   // document.refreshform.checkfalse.value="false";
	    document.all.Interval.value = "";
	    document.all.Interval.disabled = true;
	   // document.refreshform.submit();
	}
}

function refresh()
{
    if(document.all.Submit.value=="停止")
    {// 不刷新
      document.form1.checkfalse.value="false";
      document.all.Interval.value = "";
      document.all.Submit.value="刷新";
      document.all.Interval.disabled = true;
      document.all.FreshFlag.checked=false;   
     // document.form1.refreshtime.value="";   
      
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
			<meta http-equiv="refresh" 	content="2" >
	
</head>
	<body>
		<form name="refreshform" method="post">		   
		</form>
		
		<form name="form1" method="post">
		    <input name="checkfalse" type="hidden"/>
			<input type="hidden" name="refreshtime" />
		<%				
			int num=0;
			String  strstatus,strcurtimes,strmaxtimes;
			String  strcolor="g.gif";	
			boolean bExist=false;
			boolean bGreen=true;
			boolean bOrange=false;
			boolean bRed=false;
			String valuesysid,sqlstr;
		%>
			<table>					
				<tr style="font-size: 12px;">				
					<td style="width: 90px; height: 90px; text-align: center; vertical-align:middle;"><img  src="g.gif"><a href="TaskDetailThreeColor.jsp" /><br>CPU</td>
					<td style="width: 90px; height: 90px; text-align: center; vertical-align:middle;"><img  src="g.gif"><a href="TaskDetailThreeColor.jsp" /><br>交换区</td>
					<td style="width: 90px; height: 90px; text-align: center; vertical-align:middle;"><img  src="g.gif"><a href="TaskDetailThreeColor.jsp" /><br>文件系统</td>
					<td style="width: 90px; height: 90px; text-align: center; vertical-align:middle;"><img  src="g.gif"><a href="TaskDetailThreeColor.jsp" /><br>内存</td>
					<td style="width: 90px; height: 90px; text-align: center; vertical-align:middle;"><img  src="g.gif"><a href="TaskDetailThreeColor.jsp" /><br>表空间</td>
					<td style="width: 90px; height: 90px; text-align: center; vertical-align:middle;"><img  src="g.gif"><a href="TaskDetailThreeColor.jsp" /><br>应用系统</td>
					<td style="width: 90px; height: 90px; text-align: center; vertical-align:middle;"><img  src="g.gif"><a href="TaskDetailThreeColor.jsp" /><br>TUX服务</td>
					<td style="width: 90px; height: 90px; text-align: center; vertical-align:middle;"><img  src="g.gif"><a href="TaskDetailThreeColor.jsp" /><br>网络通讯</td>
		        </tr>
			</table>				
		   <hr/>
		  
			<table>
			
			<%
				Manager m = Manager.getInstance();
		
				sqlstr= "select sysid,sysname   from  bat_provname   order by sysid";	
				
				Vector v_Prov= m.execSQL(sqlstr);
		
				ProvProc[]  provs=null;
		
				if(v_Prov!=null){
			
					provs = new ProvProc[v_Prov.size()];
					
		            for(int i=0;i<v_Prov.size();i++){
		            	provs[i] = new ProvProc();
			      	  	String[] arr = (String [])v_Prov.elementAt(i);
			      	  	try {
		    	      	  	provs[i].setProvID(arr[0]);
				      	  	provs[i].setProvName(arr[1]);
				      	 
			          	}catch(NullPointerException ex){}
			          	
	            	}
	            }
         		for(int k=0;k<v_Prov.size();k++){	
				
					bExist=false;
		
					valuesysid=provs[k].getProvID();
				
  				    sqlstr= "select t.sysid ,p.sysname,t.status ,t.curretrytimes ,t.maxretrytimes   from bat_taskproc t , bat_provname p  where t.sysid = p.sysid and t.sysid = '" + valuesysid + "' ";
  	
  				    Vector v_ProvProc= m.execSQL(sqlstr);
  	
			  		ProvProc[]  provprocs=null;
				
					if(v_ProvProc!=null){
				
						provprocs = new ProvProc[v_ProvProc.size()];
						bOrange=false;
						bGreen=true;
						bRed=false;							
			  			strcolor="g.gif";			
			            for(int  n=0;n<v_ProvProc.size();n++)
			            {
			            	provprocs[n] = new ProvProc();
				      	  	String[] arr = (String [])v_ProvProc.elementAt(n);
				      	  	try {
			    	      	  	provprocs[n].setProvID(arr[0]);
					      	  	provprocs[n].setProvName(arr[1]);
					      	 	provprocs[n].setProvStatus(arr[2]);
					      	 	provprocs[n].setProvCurTimes(arr[3]);
					      	 	provprocs[n].setProvMaxTimes(arr[4]);
				          
		             			  			
			  				    bExist=true;			     			
		  					    strstatus=provprocs[n].getProvStatus();
		  				        strcurtimes=provprocs[n].getProvCurTimes();
		  				        strmaxtimes=provprocs[n].getProvMaxTimes();
		  			          
		  			            if(strcurtimes.trim().equals(strmaxtimes.trim())&&!strstatus.trim().equals("-1") && !strstatus.trim().equals("0"))
		  					    {
		  					      	bRed=true;
		  					    
		  					    }else if(!strcurtimes.trim().equals("0")&&!strstatus.trim().equals("-1") && !strstatus.trim().equals("0"))
						        {
						        	bOrange=true;
						        }else 
						        {
						        	bGreen=true;
						        }  				      
  				   			}catch(NullPointerException ex){}
  				   		}
	  				    if(bExist){
	  				 	    num++;
		  				    if(bRed){
		  				    	strcolor="r.gif";
		  				    }else if(bOrange){
		  				    	strcolor="o.gif";
		  				    }
		
						    if(num%8==1){
						    %>
							<tr style="font-size: 12px;">
							<%
							}
							%>
							<td style="width: 90px; height: 90px;  background-image: url('<%=strcolor%>'); text-align: center; vertical-align:middle;">
							<a href="TaskDetailThreeColor.jsp?sysid=<%=provs[k].getProvID()%>"  ><%=provs[k].getProvName()%></a>
							</td>
							<%
							if(num%8==0){
							%>
							</tr>
							<%
							}						
						}	
					}
				}%>					
				</table>
		</form>		
	</body>
</html>
