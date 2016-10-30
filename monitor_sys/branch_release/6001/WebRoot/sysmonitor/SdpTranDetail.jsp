<%@ page language="java"
	import="java.util.*,java.sql.*,com.git.base.cfg.Service"
	contentType="text/html;charset=GBK"%>
<jsp:directive.page import="java.text.DateFormat" />
<jsp:directive.page import="java.text.SimpleDateFormat" />
<jsp:directive.page import="java.util.Date" />
<jsp:directive.page import="com.git.base.cfg.Service" />
<jsp:directive.page import="com.git.base.dbmanager.MySdp" />
<jsp:directive.page import="com.git.base.dbmanager.DBRowSet" />
<jsp:directive.page import="com.git.base.dbmanager.MyManager" />
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<script language="javascript">
function refresh()
{	
	document.form.submit();
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
	</head>
	<body>
		<form name="form" method="post">
			<input type="hidden" name="rData" value="">

			<table>
				<tr>
					<td>
						<input type="button" name="Submit" value="刷新" onclick=refresh()>
					</td>
				</tr>
			</table>
			<%
				DBRowSet rssdp = null;
				String strContent = null, strBgColor = null;
				String sql = null, sqlsdp = null, sTime = null, eTime = null, systime = null, maxtime = null, value = null;
				int cols = 0, rows = 0;
				String iCorrect, iAll,strRateTemp;
				String strRate = null;
				int iS;
				
				MyManager dbsql = MyManager.getInstance();
				MySdp db = MySdp.getInstance();

				sqlsdp = "select count(*)  from aspfz0 where asz0rsco='0000' or asz0rsco='****' ";

				iCorrect = db.selFirstCol(sqlsdp);

				sqlsdp = "select count(*)  from aspfz0  ";

				iAll = db.selFirstCol(sqlsdp);

				if (Integer.parseInt(iAll) == 0)
					strRate = "100";
				else
				{
					//rate =Double.parseDouble(String.valueOf((Integer.parseInt(iCorrect)*10000/ Integer.parseInt(iAll))))/100;
					//rate =Integer.parseInt(iCorrect)*100/ Integer.parseInt(iAll);
				
					strRateTemp =String.valueOf(Double.parseDouble(iCorrect)*100/Double.parseDouble(iAll));
             
                	iS = strRateTemp.indexOf('.');
             
                	strRate= strRateTemp.substring(0,iS+3);
			    }

				strRate = " 小额信贷会计系统交易成功率为：" + strRate+ "%";
			%>

			<hr />			
			<tr border=0 style='font:red'>		
			    <%=strRate %>   以下为最近出现的错误交易：					
			</tr>		
			<hr />
			<table border=1 cellspacing="0" cellpadding="0">
				<tr bgcolor="#99CCCC">
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
						try {

						sqlsdp = "select to_char(sysdate,'yyyyMMddhh24miss')  from dual ";

						systime = db.selFirstCol(sqlsdp);

						if (systime == null)
							systime = "00000000000000";

						DateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");

						Date d1 = df.parse(systime);

						//playTime = "20080821"+systime.substring(8,14);

						sql = "select beginTime , endTime from SdpTranTime ";
						rssdp = dbsql.selectSql(sql);
						sTime = rssdp.getString(0, 0);
						eTime = rssdp.getString(0, 1);

						//System.out.println("sTime:"+sTime);
						//System.out.println("eTime:"+eTime);
						// System.out.println("sysTime:"+systime.substring(8,14));             

						if (Integer.parseInt(systime.substring(8, 14)) > Integer
						.parseInt(sTime)
						&& Integer.parseInt(systime.substring(8, 14)) < Integer
								.parseInt(eTime)) {
							//sqlsdp="select max(asz0date || asz0lctm ) from aspfz0,atpf00,papf30,papf90 where asz0trco=at00jydm and asz0dpno=pa30dpno and asz0rsco=pa90rpsco " ;
							sqlsdp = "select max(asz0date || asz0lctm ) from aspfz0";

							maxtime = db.selFirstCol(sqlsdp);

							if (maxtime == null)
						maxtime = "00000000000000";

							Date d3 = df.parse(maxtime);

							if ((d1.getTime() - d3.getTime()) > 10 * 60 * 1000) {
						strContent = "现在系统时间为：" + systime + ",上次交易距离现在已经超过十分钟";
						strBgColor = "style=' background-color: red'";

							} else if ((d1.getTime() - d3.getTime()) > 5 * 60 * 1000) {
						strContent = "现在系统时间为：" + systime + ",上次交易距离现在已经超过五分钟";
						strBgColor = "style=' background-color:  #ffa500'";

							} else {
						strContent = "现在系统时间为：" + systime + ",系统交易正常";
						strBgColor = "style=' background-color:  green'";

							}
						} else {
							strContent = "现在系统时间为：" + systime + ",不在预警时间段内";
							strBgColor = "style=' background-color:  green'";
						}

						sqlsdp = "select * from (select asz0date , asz0lctm,asz0trco,at00jymc,asz0dpno,pa30cname,asz0rsco,pa90rpsnm from aspfz0,atpf00,papf30,papf90 where asz0rsco<>'0000' and  asz0rsco<>'****' and asz0trco=at00jydm and asz0dpno=pa30dpno and asz0rsco=pa90rpsco "
						+ " order by  asz0date||asz0lctm desc) where rownum<=10 ";

						rssdp = db.selectSql(sqlsdp);

						cols = rssdp.getColumnCount();
						rows = rssdp.getRowCount();
						if (rows > 10)
							rows = 10;
						for (int i = 0; i < rows; i++) {
				%>
				<tr align="right" <%=strBgColor %>>
					<%
					for (int j = 0; j < cols; j++) {
					%>
					<td style="color:#FFFFFF" <%=strBgColor %>>
						<input type="text" readonly size="18"
							<%
							   value = rssdp.getString(i,j);
													   
							   if(value==null)
							   {
							     value = "";
							   }
							%>
							value=<%=value.trim()%>>
					</td>
					<%
					}
					%>
				</tr>
				<%
					}

					} catch (Exception se) {
						se.printStackTrace();
					}
				%>
			</table>
			<hr />
			<table>
				<tr align="center">
					<td <%=strBgColor %>>
						<%=strContent%>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>
