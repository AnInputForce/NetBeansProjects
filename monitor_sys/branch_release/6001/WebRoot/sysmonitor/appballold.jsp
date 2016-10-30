<%@  page language="java" import="com.app.*,java.util.*,com.git.base.cfg.*,com.git.base.dbmanager.Manager"
	contentType="text/html;charset=GBK"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta http-equiv="refresh" content="<%=Service.getRefreshTime()%>" >

<script language="JavaScript" type="text/JavaScript" src="js/map.js"></script>
</head>
<body     background="./images/background.gif" LeftMargin=0 TopMargin=0>
<!-- #BeginLibraryItem "/Library/head2.lbi" -->
<!--Popup-->

<%
	String sqlstr=null,sProvName=null,sSysid=null;
	boolean bRed=false,bOrange=false,bExist=false;
	String sColorBall="g.gif",sCurStatus,sCurRetry,sMaxRetry;
	int xpos,ypos;
	boolean bSound=false;
	Manager m = Manager.getInstance();

	sqlstr= "select sysid,sysname ,xpos,ypos  from  bat_provname   order by sysid";	
	
	Vector v_Prov= m.execSQL(sqlstr);

	ProvProc[]  provs=null;
		
	if(v_Prov!=null){

		provs = new ProvProc[v_Prov.size()];
		
           for(int i=0;i<v_Prov.size();i++)
           {
	           	provs[i] = new ProvProc();
	      	  	String[] arr = (String [])v_Prov.elementAt(i);
	      	  	try {
	      	  
	   	      	  	provs[i].setProvID(arr[0]);
		      	  	provs[i].setProvName(arr[1]);
		      	  	provs[i].setXPos(Integer.parseInt(arr[2]));
		      	  	provs[i].setYPos(Integer.parseInt(arr[3]));
		      	 
	          	}catch(NullPointerException ex){
	          		ex.printStackTrace();
	          	}	          	
           }
     }
     
     for(int j=0;j<v_Prov.size();j++)
     {
     	xpos=provs[j].getXPos();
     	ypos=provs[j].getYPos();
	    sProvName=provs[j].getProvName();    
		sSysid=provs[j].getProvID();
		bOrange=false;
		bRed=false;							
		sColorBall="g.gif";			  			
	 	bExist=false;			     	
	
		sqlstr= "select t.sysid ,p.sysname,t.status ,t.curretrytimes ,t.maxretrytimes   from bat_taskproc t , bat_provname p  where t.sysid = p.sysid and t.sysid = '" + sSysid + "' ";
	
		Vector v_ProvProc= m.execSQL(sqlstr);
	
	 	ProvProc[]  provprocs=null;
	
		if(v_ProvProc!=null)
		{	
			provprocs = new ProvProc[v_ProvProc.size()];
			bExist=true;
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
					sCurStatus=provprocs[n].getProvStatus();
					sCurRetry=provprocs[n].getProvCurTimes();
					sMaxRetry=provprocs[n].getProvMaxTimes();
     
					if(sCurRetry.trim().equals(sMaxRetry.trim())&&!sCurRetry.trim().equals("0")&&!sCurStatus.trim().equals("-1") && !sCurStatus.trim().equals("0"))
					{
						bRed=true;
					}else if(!sCurRetry.trim().equals("0")&&!sCurStatus.trim().equals("-1") && !sCurStatus.trim().equals("0"))
					{
						bOrange=true;
					}			      
				}catch(NullPointerException ex)
				{
					ex.printStackTrace();	
				}
			}
		}
	    if(bExist){
	    		 	    
		    if(bRed){
		    	sColorBall="r.gif";
		    	bSound=true;
		    }else if(bOrange){
		    	bSound=true;
		    	sColorBall="o.gif";
		    }else 
		    	sColorBall="g.gif";
		}
 		%>		
	    <div id=<%=sProvName%>  style="position:absolute; width=1;height=1;left:<%=xpos%>; top:<%=ypos%>;   visibility: visible; cursor:hand;"  onclick="javscript:parent.location.href='TaskDetail.jsp?sysid=<%=sSysid%>';">
	    	<table width="16" cellspacing="0" cellpadding="0">  
 	 			<tr>
    				<td style="font:12" ><img src="<%=sColorBall%>" width="16" height="16" ></td>
	 			</tr>
  			</table>  
		</div>   
		<% 
	}
 %>

<div id=香港 style="position:absolute; left:589; top:472;   visibility: visible;">
  <table width="247" cellspacing="0" cellpadding="0">  
 	 <tr>
    	<td style="font:12" ><img src="g.gif" width="16" height="16" ></td>
	 </tr>
  </table>  
</div>
<div id=澳门 style="position:absolute; left:571; top:475;   visibility: visible;">
  <table width="247" cellspacing="0" cellpadding="0">  
 	 <tr>
    	<td style="font:12" ><img src="g.gif" width="16" height="16" ></td>
	 </tr>
  </table>  
</div>
<div id=台湾 style="position:absolute; left:684; top:426;   visibility: visible;">
  <table width="247" cellspacing="0" cellpadding="0">  
 	 <tr>
    	<td style="font:12" ><img src="g.gif" width="16" height="16" ></td>
	 </tr>
  </table>  
</div>

<div id=运行正常 style="position:absolute; left:120; top:400; text-valign:center;  visibility: visible;">
  <table >  
 	 <tr>
    	<td  ><img src="g.gif" width="30" height="30" ></td>
    	<td style="font:15;" >运行正常</td>
	 </tr>
  </table>  
</div>
<div id=运行告警 style="position:absolute; left:120; top:430; text-valign:center;  visibility: visible;">
  <table >  
 	 <tr>
    	<td ><img src="o.gif" width="30" height="30" ></td>
    	<td style="font:15;" >运行告警</td>
	 </tr>
  </table>  
</div>
<div id=运行错误 style="position:absolute; left:120; top:460; text-valign:center;  visibility: visible;">
  <table >  
 	 <tr>
    	<td ><img src="r.gif" width="30" height="30" ></td>
    	<td style="font:15;" >运行失败</td>
	 </tr>
  </table>  
</div>
<!-- <div  style="position:absolute; left:830; top:20;   visibility: visible;">
  <table width="247" cellspacing="0" cellpadding="0">  
 	 <tr>
    	<td style="font:20" >中</td>
	 </tr>
  </table>  
</div>
<div  style="position:absolute; left:830; top:60;   visibility: visible;">
  <table width="247" cellspacing="0" cellpadding="0">  
 	 <tr>
    	<td style="font:20" >国</td>
	 </tr>
  </table>  
</div>
<div  style="position:absolute; left:830; top:100;   visibility: visible;">
  <table width="247" cellspacing="0" cellpadding="0">  
 	 <tr>
    	<td style="font:20" >邮</td>
	 </tr>
  </table>  
</div>
<div  style="position:absolute; left:830; top:140;   visibility: visible;">
  <table width="247" cellspacing="0" cellpadding="0">  
 	 <tr>
    	<td style="font:20" >政</td>
	 </tr>
  </table>  
</div>
<div  style="position:absolute; left:830; top:180;   visibility: visible;">
  <table width="247" cellspacing="0" cellpadding="0">  
 	 <tr>
    	<td style="font:20" >小</td>
	 </tr>
  </table>  
</div>
<div  style="position:absolute; left:830; top:220;   visibility: visible;">
  <table width="247" cellspacing="0" cellpadding="0">  
 	 <tr>
    	<td style="font:20" >额</td>
	 </tr>
  </table>  
</div>
<div  style="position:absolute; left:830; top:260;   visibility: visible;">
  <table width="247" cellspacing="0" cellpadding="0">  
 	 <tr>
    	<td style="font:20" >信</td>
	 </tr>
  </table>  
</div>
<div  style="position:absolute; left:830; top:300;   visibility: visible;">
  <table width="247" cellspacing="0" cellpadding="0">  
 	 <tr>
    	<td style="font:20" >贷</td>
	 </tr>
  </table>  
</div>

<div  style="position:absolute; left:830; top:340;   visibility: visible;">
  <table width="247" cellspacing="0" cellpadding="0">  
 	 <tr>
    	<td style="font:20" >监</td>
	 </tr>
  </table>  
</div>
<div  style="position:absolute; left:830; top:380;   visibility: visible;">
  <table width="247" cellspacing="0" cellpadding="0">  
 	 <tr>
    	<td style="font:20" >控</td>
	 </tr>
  </table>  
</div>

<div  style="position:absolute; left:830; top:420;   visibility: visible;">
  <table width="247" cellspacing="0" cellpadding="0">  
 	 <tr>
    	<td style="font:20" >系</td>
	 </tr>
  </table>  
</div>

<div  style="position:absolute; left:830; top:460;   visibility: visible;">
  <table width="247" cellspacing="0" cellpadding="0">  
 	 <tr>
    	<td style="font:20" >统</td>
	 </tr>
  </table>  
</div>
-->
<table width="800"  height="550" border="0" bgcolor="#FFFFFF">
	<tr>
	<td width="100" ></td>
  		<td valign="top"  >
  			<img src="china_map.jpg" width="670" height="550" border="0" usemap="#Map">
  				
		</td>
	</tr>
</table>
<%if(bSound){ %>
	<bgsound  src="<%=Service.getSoundFile()%>"  loop="<%=Service.getSoundTimes()%>" >
<%} %>
</body>
</html>