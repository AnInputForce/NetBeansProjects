<%@ page language="java" import="java.util.*,com.git.base.dbmanager.*"  contentType="text/html;charset=GBK"%>
<html>
	<head>
		<title>��ӡԤ��</title>
	</head>
	<body style="margin:0px;overflow: hidden;border: none;">
<%

//	MyManager m = MyManager.getInstance();	
	Manager m = Manager.getInstance();
	
	List list = new ArrayList();
	String iCount = null;
	
	int rows=0;
	
	// �õ���������ֵ�͵�ǰ����
	String start = request.getParameter("start");
	String end = request.getParameter("end");
	String sCNT="0", sSucCNT="0", sFailCNT="0",sInitCNT="0";
	Calendar calCurrent=Calendar.getInstance();
	int intDay=calCurrent.get(Calendar.DATE);
	int intMonth=calCurrent.get(Calendar.MONTH)+1;
	int intYear=calCurrent.get(Calendar.YEAR);
	String today = intYear+"��"+intMonth+"��"+intDay+"��";
	String sBusidate=null ,sSysname= null,sTranname=null,sFilename=null,sCurretry=null,sStarttime=null,sStatus=null;

	System.out.println("ceshi");
	// �õ����������ļ�¼����
	//iCount = m.selFirstCol("select count(*) as cnt from bat_taskproc_his where status<>-1 and busidate >= '"+start+"' and substr(busidate,0,10) <= '"+end+"'");	
	iCount = m.selFirstCol("select count(*) as cnt from bat_taskproc_his where  busidate >= '"+start+"' and substr(busidate,0,10) <= '"+end+"'");	
	if ( iCount !=null && iCount!="" )
	{
		sCNT = iCount;
	}
	
	// �õ����׳ɹ��ļ�¼����	
	iCount = m.selFirstCol("select count(*) as succnt from bat_taskproc_his where status=0 " +
					"and busidate >= '"+start+"' and substr(busidate,0,10) <= '"+end+"'");	
	if ( iCount !=null && iCount!="" )
	{
		sSucCNT = iCount;
	}
	
	// �õ�����ʧ�ܵļ�¼����	
	sFailCNT = Integer.toString(Integer.parseInt(sCNT)-Integer.parseInt(sSucCNT));
	
	// ��ѯ��¼����
	//DBRowSet rs = m.selectSql("select  trim(a.busidate),  trim(p.sysname) ,trim(t.tranname), trim(a.filename), " +
	//		"    trim(a.curretrytimes),  trim(a.starttime),  trim(a.status) from bat_taskproc_his   a , bat_provname p ,  bat_taskreg t  " +
	//		"  where a.sysid = p.sysid and p.sysid = t.sysid  and a.taskno = t.taskno  and a.busidate >= '"+start+"' and substr(a.busidate,0,10) <= '"+end+"'");
	DBRowSet rs = m.selectSql("select  trim(a.busidate),  trim(p.sysname) ,trim(t.tranname), trim(a.filename), " +
			"    trim(a.curretrytimes),  trim(a.starttime),  trim(a.status) from bat_taskproc_his   a , bat_provname p ,  bat_taskreg t  " +
			"  where a.sysid = p.sysid and a.followid= t.followid and a.busidate >= '"+start+"' and substr(a.busidate,0,10) <= '"+end+"'");
			

	rows = rs.getRowCount();	
	
	if(rows >= 1 ){
		for(int r = 0;r < rows ; r++) {				
			sBusidate = rs.getString(r,0);
			sSysname = rs.getString(r,1);
			sTranname = rs.getString(r,2);
			sFilename = rs.getString(r,3);
			sCurretry = rs.getString(r,4);
			sStarttime= rs.getString(r,5);
			sStatus = rs.getString(r,6);
				
			Map map_inner = new HashMap();
			map_inner.put("a1",start);
			map_inner.put("a2",end);
			map_inner.put("a3",today);
			map_inner.put("a4",sBusidate);					
			map_inner.put("a5",sSysname);
			map_inner.put("a6",sTranname);
			map_inner.put("a7",sFilename);
			map_inner.put("a8",sCurretry);
			map_inner.put("a9",sStarttime);
			map_inner.put("a10",sStatus);
			map_inner.put("a11",sCNT);
			map_inner.put("a12",sSucCNT);
			map_inner.put("a13",sFailCNT);
			list.add(map_inner);		
		}
		session.setAttribute("list",list);
		session.setAttribute("jrxmlName","batproc");
%>

	<APPLET code="net.sf.jasperreports.applet.PrinterApplet.class"
		codebase="." archive="PrintApplet.jar" align="middle" width="100%"
		height="100%" name="PrintApplet" MAYSCRIPT>
		<PARAM name="REPORT_URL" value="../ReportPrintController">
		<br>
		<br>
		<table width="100%" height="100%">
			<tr>
				<td align="center" valign="middle">
					java��ӡ������Ҫjre1.4.2����ߵĵ����л���֧��
					<br>
					<br>
				</td>
			</tr>
		</table>
	</APPLET>
	<%}else{%>
	<script>	
		window.alert("��ʱ�����û�м�¼��������ѡ��ʼ���ڼ���������");
		window.history.back();
	</script>
	<% } %>
	</body>
</html>
