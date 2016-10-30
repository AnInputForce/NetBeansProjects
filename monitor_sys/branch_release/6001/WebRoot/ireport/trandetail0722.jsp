<%@ page language="java" import="java.util.*,java.sql.*,com.git.base.cfg.Service"  contentType="text/html;charset=GBK"%>
<html>
	<head>
		<title>打印预览</title>
	</head>
	<body style="margin:0px;overflow: hidden;border: none;">
<%
	List list = new ArrayList();
	try	{
		Class.forName(Service.getOracleDriverClass().trim());
	    String url = Service.getOracleDriverUrl();
	    Connection conn = DriverManager.getConnection(url, "sdp", "sdp");
		Statement stmt = conn.createStatement();;
	    ResultSet rs = null;
		
		
		// 得到日期条件值和当前日期
		String start = request.getParameter("start");
		String end = request.getParameter("end");
		String sCNT="0", sSucCNT="0", sFailCNT="0";
		Calendar calCurrent=Calendar.getInstance();
		int intDay=calCurrent.get(Calendar.DATE);
		int intMonth=calCurrent.get(Calendar.MONTH)+1;
		int intYear=calCurrent.get(Calendar.YEAR);
		String today = intYear+"年"+intMonth+"月"+intDay+"日";
		
		// 得到符合条件的记录条数
		rs = stmt.executeQuery("select count(*) as cnt from aspfz0 where asz0date >= '"+start+"' and substr(asz0date,0,10) <= '"+end+"'");
		if ( rs.next() )
		{
			sCNT = rs.getString("cnt");
			System.out.println("记录总数:["+sCNT+"]");
		}
		rs.close();
		
		// 得到交易成功的记录条数	
		rs = stmt.executeQuery("select count(*) as succnt from aspfz0 where (asz0rsco='0000' or asz0rsco='****') " +
						"and asz0date >= '"+start+"' and substr(asz0date,0,10) <= '"+end+"'");	
		if ( rs.next() )
		{
			sSucCNT = rs.getString("succnt");
			System.out.println("交易成功记录数:["+sSucCNT+"]");
		}
		rs.close();
		
		// 得到交易失败的记录条数	
		sFailCNT = Integer.toString(Integer.parseInt(sCNT)-Integer.parseInt(sSucCNT));
		
		// 查询记录详情
		
		rs = stmt.executeQuery("select trim(asz0date) as busidate," +
								"trim(asz0dpno) as instno, trim(pa30cname) as inst," +
								"trim(asz0trco) as trancodeno,trim(at00jymc) as trancode," +
								"asz0rsco as respno, trim(pa90rpsnm) as resp " +
								"from aspfz0 a " + 
								"left join atpf00 b on b.at00jydm = a.asz0trco " +
								"left join papf30 c on c.pa30dpno = a.asz0dpno " +
								"left join papf90 d on d.pa90rpsco = a.asz0rsco " +
								"where asz0date >= '"+start+"' and substr(asz0date,0,10) <= '"+end+"'");					
		System.out.println(rs.getRow());
		
		while (rs!=null && rs.next())
		{	
			String sDate = rs.getString("busidate");
			String sInstNo = rs.getString("instno");
			String sInst = rs.getString("inst");
			String sTranCodeNo = rs.getString("trancodeno");
			String sTranCode = rs.getString("trancode");
			String sRespNo = rs.getString("respno");
			String sResp = rs.getString("resp");
			
			if (sInst==null||sInst.trim().equals(""))sInst="无相应信息";
			if (sTranCode==null||sTranCode.trim().equals("")) sTranCode="无相应信息";
			if (sResp==null||sResp.trim().equals("")) sResp="无相应信息";
				
			Map map_inner = new HashMap();
			map_inner.put("a1",start);
			map_inner.put("a2",end);
			map_inner.put("a3",today);
			map_inner.put("a4",sDate);		
			map_inner.put("a5",sTranCode);
			map_inner.put("a6",sTranCodeNo);
			map_inner.put("a7",sInst);
			map_inner.put("a8",sInstNo);
			map_inner.put("a9",sResp);
			map_inner.put("a10",sRespNo);
			map_inner.put("a11",sCNT);
			map_inner.put("a12",sSucCNT);
			map_inner.put("a13",sFailCNT);
			list.add(map_inner);	
		}
		
		if (conn!=null)conn.close();
		if (stmt!=null)stmt.close();
		if (rs!=null)rs.close();
	}
	catch (Exception se) {
		se.printStackTrace();
	}

	session.setAttribute("printType", "applet");
	session.setAttribute("list",list);
	session.setAttribute("jrxmlName","trandetail");
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
						java打印功能需要jre1.4.2或更高的的运行环境支持
						<br>
						<br>
					</td>
				</tr>
			</table>
		</APPLET>
	</body>
</html>
