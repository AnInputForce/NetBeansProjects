<%@ page language="java" import="java.util.*,com.git.base.dbmanager.*"  contentType="text/html;charset=GBK"%>
<html>
	<head>
		<title>��ӡԤ��</title>
	</head>
	<body style="margin:0px;overflow: hidden;border: none;">
<%

	MyManager m = MyManager.getInstance();	
	
	List list = new ArrayList();
	String iCount = null;
	int rows=0;
	
	// �õ���������ֵ�͵�ǰ����
	String start = request.getParameter("start");
	String end = request.getParameter("end");
	String sCNT="0", sSucCNT="0", sFailCNT="0";
	Calendar calCurrent=Calendar.getInstance();
	int intDay=calCurrent.get(Calendar.DATE);
	int intMonth=calCurrent.get(Calendar.MONTH)+1;
	int intYear=calCurrent.get(Calendar.YEAR);
	String today = intYear+"��"+intMonth+"��"+intDay+"��";
	String sDate=null,sClassID=null,sHostID=null,sAlertColor=null,sAlertContent=null;
        String endTime = end.substring(0,4)+"-"+end.substring(4,6)+"-"+end.substring(6,8);
	

	// �õ����������ļ�¼����
	iCount = m.selFirstCol("select count(*) as cnt from AlertLog where alertTime >= '"+start+"' and " +
                               "  substr(alertTime,1,10)  <= '"+endTime+"'");	
	if ( iCount !=null && iCount!="" )
	{
		sCNT = iCount;
	}
	
	// �õ����׳ɹ��ļ�¼����	
	iCount = m.selFirstCol("select count(*) as succnt from AlertLog where alertColor='2' " +
					"and alertTime >= '"+start+"' and substr(alertTime,1,10) <= '"+endTime+"'");	
	if ( iCount !=null && iCount!="" )
	{
		sSucCNT = iCount;
	}
	
	// �õ�����ʧ�ܵļ�¼����	
	sFailCNT = Integer.toString(Integer.parseInt(sCNT)-Integer.parseInt(sSucCNT));
	
	// ��ѯ��¼����
	
	DBRowSet rs = m.selectSql("select  trim(a.alertTime),  trim(m.classValue), trim(h.hostName) , " + 
                        "  (case alertcolor when 2 then '��ɫ' when 3 then '��ɫ' end)  as alertcolor , " +
			"  trim(a.alertContent)   from AlertLog   a , Hosts h ,MonitorClass m   " +
			"  where a.hostID = h.hostID and a.classID = m.classID and alertTime >= '"+start+"' and   " + 
                        "  substr(alertTime,1,10)  <= '"+endTime+"'");	

	rows = rs.getRowCount();
	
	
	if(rows >= 1 ){
	
		for(int r = 0;r < rows ; r++) {				
			sDate = rs.getString(r,0);
			sClassID = rs.getString(r,1);
			sHostID = rs.getString(r,2);
			sAlertColor = rs.getString(r,3);
			sAlertContent = rs.getString(r,4)
			;
	Map map_inner = new HashMap();
	map_inner.put("a1",start);
	map_inner.put("a2",end);
	map_inner.put("a3",today);
			map_inner.put("a4",sDate);		
			map_inner.put("a5",sClassID);
			map_inner.put("a6",sHostID);
			map_inner.put("a7",sAlertColor);
			map_inner.put("a8",sAlertContent);
			map_inner.put("a11",sCNT);
			map_inner.put("a12",sSucCNT);
			map_inner.put("a13",sFailCNT);
			list.add(map_inner);		
		}
		session.setAttribute("list",list);
		session.setAttribute("jrxmlName","alertlog");
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
