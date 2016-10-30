<%@ page language="java"
	import="com.git.base.cfg.Service,com.git.base.dbmanager.*,java.sql.*"
	contentType="text/html;charset=GBK"%>
<%@ page import="java.util.Date"%>
<jsp:directive.page import="java.text.DateFormat" />
<jsp:directive.page import="java.text.SimpleDateFormat" />
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<style>
			.inputNoBorder{			
				 border-style:none;
				 border-width:0px;			
			} 
       	</style>
		<meta http-equiv="refresh" content="<%=Service.getRefreshTime()%>">
	</head>

	<body>
		<form name="form1" method="post">
			<%
				String sColorBall = "g.gif";
				boolean bSound = false;
				MyManager db = MyManager.getInstance();
				DBRowSet rs = null;
				int rows;
				String sql = null;
				String sFlag = null;
				int iCurFlag = 0;
				int iFlag = 0;
				int iFlag1 = 0;
				int iFlag2 = 0;
			%>
			<table>
				<tr style="font-size: 12px;">
					<%
						//会计实时交易
						try {
							String sqlsdp, value1 = null, systime = null,maxtime=null,sTime=null , eTime=null;
							MySdp  dbsdp =  MySdp.getInstance();
		
							sqlsdp = "select to_char(sysdate,'yyyyMMddhh24mmss')  from dual ";
			
							systime = dbsdp.selFirstCol(sqlsdp);
			
							if (systime == null)
									systime = "00000000000000";
							//systime="20080822211932";
							sqlsdp="select max(asz0date || asz0lctm ) from aspfz0,atpf00,papf30,papf90 where asz0trco=at00jydm and asz0dpno=pa30dpno and asz0rsco=pa90rpsco " ;
					    	
					    	maxtime  =  dbsdp.selFirstCol(sqlsdp);				
							if (maxtime == null)
								maxtime = "00000000000000";
							
							DateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
					
							Date d1 = df.parse(systime);
							Date d2 = df.parse(maxtime);
							if ( (d1.getTime() - d2.getTime())>= 10*60*1000)
							{ 
								iFlag = 3;
								bSound = true;
							}else if ( (d1.getTime() - d2.getTime())>= 5*60*1000)
							{ 
								iFlag = 2;
								bSound = true;
							}else 
							{ 
								iFlag = 1;
							}							
                            sql = "select beginTime , endTime from SdpTranTime ";
                            rs = db.selectSql(sql);
                            sTime = rs.getString(0,0);
                            eTime = rs.getString(0,1);
           //         System.out.println("111sTime:"+sTime);
        //   System.out.println("111eTime:"+eTime);
        //  System.out.println("111sysTime:"+systime.substring(8,14));             
                           if ( Integer.parseInt(systime.substring(8,14))< Integer.parseInt(sTime) || Integer.parseInt(systime.substring(8,14))>Integer.parseInt(eTime) ) 
                           {
                              iFlag = 1;
                           }
                          							
						} catch (Exception se) {
							se.printStackTrace();
						}
						if (iFlag == 3) {
							sColorBall = "r.gif";
							bSound = true;
						} else if (iFlag == 2) {
							sColorBall = "o.gif";
							bSound = true;
						} else {
							sColorBall = "g.gif";
						}
					%>
					<td style=" height: 20px; text-align: center; ">
						<img src="<%=sColorBall%>" width='40' heigth='40'
							onclick="parent.frames.app.location.href('SdpTranDetail.jsp')" />
						<br>
						实时交易
					</td>
				</tr>
				<tr style="font-size: 12px;">
					<%
						//memory
						sql = "select max(alertflag) from memory_data where memoryid='memory'";
						sFlag = null;
						sFlag = db.selFirstCol(sql);

						if (sFlag == null || sFlag.trim().equals("")) {
							iFlag = 3;
						} else {

							iFlag = Integer.parseInt(sFlag);

						}
						if (iFlag == 3) {
							sColorBall = "r.gif";
							bSound = true;
						} else if (iFlag == 2) {
							sColorBall = "o.gif";
							bSound = true;
						} else {
							sColorBall = "g.gif";
						}
					%>
					<td style="height: 20px; text-align: center; ">
						<img src="<%=sColorBall%>" width='40' heigth='40'
							onclick="parent.frames.app.location.href('SysMemoryDetail.jsp')" />
						<br>
						内存
					</td>
				</tr>
				<tr style="font-size: 12px;">
					<%
						//filesystem
						sql = "select max(alertflag)  from filesys_data ";
						sFlag = null;
						sFlag = db.selFirstCol(sql);

						if (sFlag == null || sFlag.trim().equals("")) {
							iFlag = 3;
						} else {
							iFlag = Integer.parseInt(sFlag);

						}
						if (iFlag == 3) {
							sColorBall = "r.gif";
							bSound = true;
						} else if (iFlag == 2) {
							sColorBall = "o.gif";
							bSound = true;
						} else {
							sColorBall = "g.gif";
						}
					%>
					<td style=" height: 20px; text-align: center; ">
						<img src="<%=sColorBall%>" width='40' heigth='40'
							onclick="parent.frames.app.location.href('FileSysDetail.jsp')" />
						<br>
						文件系统
					</td>
				</tr>
				<tr style="font-size: 12px;">
					<%
						//dbtablespace
						sql = "select max(alertflag)  from dbspace_data ";
						sFlag = null;
						sFlag = db.selFirstCol(sql);

						if (sFlag == null || sFlag.trim().equals("")) {
							iFlag = 3;
						} else {
							iFlag = Integer.parseInt(sFlag);

						}
						if (iFlag == 3) {
							sColorBall = "r.gif";
							bSound = true;
						} else if (iFlag == 2) {
							sColorBall = "o.gif";
							bSound = true;
						} else {
							sColorBall = "g.gif";
						}
					%>
					<td style="height: 20px; text-align: center; ">
						<img src="<%=sColorBall%>" width='40' heigth='40'
							onclick="parent.frames.app.location.href('DBSpaceDetail.jsp')" />
						<br>
						表空间
					</td>
				</tr>
				<tr style="font-size: 12px;">
					<%
						//application  process
						//sql = "select r.procUID , r.procName , d.alertflag  from appproc_reg  r left join   appproc_data d "
						//	+ " on  d.procUID=r.procUID and d.procName = r.procName where r.procUID not like 'WEB:%'";
						//	System.out.println("it is this page");		
						sql = "select h.hostID,h.hostDesc,r.procUID,r.procName,d.procNum,d.updatetime, d.alertflag ,d.alertcontent from appproc_reg r ,Hosts h left join "
								+ " appproc_data  d  on r.procUID=d.procUID and r.procName=d.procName where h.hostID=r.hostID  and h.hostDesc not like '%管理%'";

						rs = db.selectSql(sql);
						rows = rs.getRowCount();
						iFlag = 0;
						sFlag = null;
						iCurFlag = 0;
						iFlag1 = 0;
						iFlag2 = 0;

						for (int i = 0; i < rows; i++) {
							//System.out.println("rows:"+rows +" currows:"+i +  " UID:" + rs.getString(i,0)+ " Name:" + rs.getString(i,1)+ " flag:" + rs.getString(i,2));
							sFlag = rs.getString(i, 6);

							if (sFlag == null || sFlag.trim().equals("")) {
								iCurFlag = 3;
							} else {
								iCurFlag = Integer.parseInt(sFlag);

							}
							if (iCurFlag > iFlag)
								iFlag = iCurFlag;
							if (iFlag >= 3)
								break;
						}

						sql = "	select h.hostID,h.hostDesc,r.procUID,r.procName,d.updatetime, d.alertflag ,d.alertcontent from appproc_reg r ,Hosts h left join "
								+ " webapp_data  d  on r.procUID=d.servname and r.procName=d.conpool where h.hostID=r.hostID and h.hostDesc  like '%管理%'";

						rs = db.selectSql(sql);
						rows = rs.getRowCount();

						sFlag = null;
						iCurFlag = 0;

						for (int i = 0; i < rows; i++) {
							//System.out.println("rows:"+rows +" currows:"+i +  " UID:" + rs.getString(i,0)+ " Name:" + rs.getString(i,1)+ " flag:" + rs.getString(i,2));
							sFlag = rs.getString(i, 5);

							if (sFlag == null || sFlag.trim().equals("")) {
								iCurFlag = 3;
							} else {
								iCurFlag = Integer.parseInt(sFlag);

							}
							if (iCurFlag > iFlag1)
								iFlag = iCurFlag;
							if (iFlag >= 3)
								break;
						}

						if (iFlag == 3) {
							sColorBall = "r.gif";
							bSound = true;
						} else if (iFlag == 2) {
							sColorBall = "o.gif";
							bSound = true;
						} else {
							sColorBall = "g.gif";
						}
					%>
					<td style=" height: 20px; text-align: center; ">
						<img src="<%=sColorBall%>" width='40' heigth='40'
							onclick="parent.frames.app.location.href('AppProcList.jsp')" />
						<br>
						应用进程
					</td>
				</tr>
				<tr style="font-size: 12px;">
					<%
						//tuxedo service
						sql = "select r.svcname , d.alertflag  from tux_service_reg  r left join  tux_service_data d  "
								+ " on  d.svcname=r.svcname and  r.hostID=d.hostID ";
						sql += " where r.hostID in (select hostID from Hosts)";
						rs = db.selectSql(sql);
						rows = rs.getRowCount();
						iFlag = 0;
						sFlag = null;
						iCurFlag = 0;

						for (int i = 0; i < rows; i++) {
							//System.out.println("rows:"+rows +" currows:"+i +  " Name:" + rs.getString(i,0)+ " flag:" + rs.getString(i,1));

							sFlag = rs.getString(i, 1);

							if (sFlag == null || sFlag.trim().equals("")) {
								iCurFlag = 3;
							} else {
								iCurFlag = Integer.parseInt(sFlag);
							}

							if (iCurFlag > iFlag)
								iFlag = iCurFlag;

							if (iFlag >= 3)
								break;
						}

						if (iFlag >= 3) {
							sColorBall = "r.gif";
							bSound = true;
						} else if (iFlag == 2) {
							sColorBall = "o.gif";
							bSound = true;
						} else {
							sColorBall = "g.gif";
						}
					%>
					<td style=" height: 20px; text-align: center; ">
						<img src="<%=sColorBall%>" width='40' heigth='40'
							onclick="parent.frames.app.location.href('TuxSvcList.jsp')" />
						<br>
						TUX服务
					</td>
				</tr>
				<tr style="font-size: 12px;">
					<%
						//tuxedo  queue
						sql = "select r.srvname , d.alertflag  from tux_que_reg  r left join  tux_que_data d  "
								+ " on  d.srvname=r.srvname and d.hostID= r.hostID ";
						rs = db.selectSql(sql);
						rows = rs.getRowCount();
						iCurFlag = 0;
						iFlag = 0;
						sFlag = null;

						for (int i = 0; i < rows; i++) {
							//System.out.println("rows:"+rows +" currows:"+i +  " Name:" + rs.getString(i,0)+ " flag:" + rs.getString(i,1));
							sFlag = rs.getString(i, 1);

							if (sFlag == null || sFlag.trim().equals("")) {
								iCurFlag = 3;
							} else {
								iCurFlag = Integer.parseInt(sFlag);

							}
							if (iCurFlag > iFlag)
								iFlag = iCurFlag;
							if (iFlag >= 3)
								break;
						}

						if (iFlag >= 3) {
							sColorBall = "r.gif";
							bSound = true;
						} else if (iFlag == 2) {
							sColorBall = "o.gif";
							bSound = true;
						} else {
							sColorBall = "g.gif";
						}
					%>
					<td style=" height: 20px; text-align: center; ">
						<img src="<%=sColorBall%>" width='40' heigth='40'
							onclick="parent.frames.app.location.href('TuxQueList.jsp')" />
						<br>
						TUX队列
					</td>
				</tr>
				<tr style="font-size: 12px;">
					<%
						//tuxedo  server
						sql = "select r.srvname , d.alertflag  from tux_server_reg  r left join  tux_server_data d  "
								+ " on  d.srvname=r.srvname  and d.hostID=r.hostID";
						rs = db.selectSql(sql);
						rows = rs.getRowCount();
						iCurFlag = 0;
						sFlag = null;
						iFlag = 0;

						for (int i = 0; i < rows; i++) {
							//System.out.println("rows:"+rows +" currows:"+i +  " Name:" + rs.getString(i,0)+ " flag:" + rs.getString(i,1));
							sFlag = rs.getString(i, 1);

							if (sFlag == null || sFlag.trim().equals("")) {
								iCurFlag = 3;
							} else {
								iCurFlag = Integer.parseInt(sFlag);

							}
							if (iCurFlag > iFlag)
								iFlag = iCurFlag;
							if (iFlag >= 3)
								break;
						}

						if (iFlag >= 3) {
							sColorBall = "r.gif";
							bSound = true;
						} else if (iFlag == 2) {
							sColorBall = "o.gif";
							bSound = true;
						} else {
							sColorBall = "g.gif";
						}
					%>
					<td style=" height: 20px; text-align: center; ">
						<img src="<%=sColorBall%>" width='40' heigth='40'
							onclick="parent.frames.app.location.href('TuxSrvList.jsp')" />
						<br>
						TUX服务进程
					</td>
				</tr>

				<tr style="font-size: 12px;">
					<%
						//tuxedo  domain
						sql = "select max(alertflag) from tux_dma_data ";
						sFlag = null;
						sFlag = db.selFirstCol(sql);

						if (sFlag == null || sFlag.trim().equals("")) {
							iFlag = 3;
						} else {
							iFlag = Integer.parseInt(sFlag);
						}
						if (iFlag == 3) {
							sColorBall = "r.gif";
							bSound = true;
						} else if (iFlag == 2) {
							sColorBall = "o.gif";
							bSound = true;
						} else {
							sColorBall = "g.gif";
						}
					%>
					<td style="height:20px; text-align: center; ">
						<img src="<%=sColorBall%>" width='40' heigth='40'
							onclick="parent.frames.app.location.href('TuxDmaDetail.jsp')" />
						<br>
						TUX域连接
					</td>
				</tr>

			</table>
		</form>
		<%
		if (bSound) {
		%>
		<bgsound src="<%=Service.getSoundFile()%>"
			loop="<%=Service.getSoundTimes()%>">
		<%
		}
		%>
	</body>
</html>
