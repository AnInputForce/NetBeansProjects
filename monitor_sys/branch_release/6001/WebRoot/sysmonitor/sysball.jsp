<%@ page language="java"
         import="com.git.base.cfg.Service,com.git.base.dbmanager.*,java.sql.*"
         contentType="text/html;charset=GBK"%>
<%@ page import="java.util.Date"%>
<jsp:directive.page import="java.text.DateFormat" />
<jsp:directive.page import="java.text.SimpleDateFormat" />
<jsp:directive.page import="com.git.base.dbmanager.MyRep"/>
<jsp:directive.page import="com.git.base.dbmanager.RepData"/>
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
      body,input,table,tr,td,th,p{

        font-size:12px;

      }
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
            //���ʵʱ����
            /**  2010-10-31 by kch:����fbj��Ҫ�󣬴˴�������Ԥ�����ܣ�so��ɾ�����ӿ�����Ԥ���ڵط������ڲ˵������ø�����
            iFlag =1 ;
            if (iFlag == 3) {
            sColorBall = "r.gif";
            bSound = true;
            } else if (iFlag == 2) {
            sColorBall = "o.gif";
            bSound = true;
            } else {
            sColorBall = "g.gif";
            }
             */
          %>
          <!-- 2010-10-31 by kch:����fbj��Ҫ�󣬴˴�������Ԥ�����ܣ�so��ɾ�����ӿ�����Ԥ���ڵط������ڲ˵������ø�����
          <td style=" height: 20px; text-align: center; ">
                  <img src="<%=sColorBall%>" width='25' heigth='25'
                          onclick="parent.frames.app.location.href('SdpTranDetail.jsp')" />
                  <br>
                  ����Ԥ��
          </td>
          -->
          <%
            //�ӿ������������
            Manager dbelloc = Manager.getInstance();

            sql = "select count(0) as sFlag  from bat_taskproc t where t.curretrytimes=t.maxretrytimes";
            sFlag = null;
            sFlag = dbelloc.selFirstCol(sql);

            if (sFlag == null || sFlag.trim().equals("")) {
              iFlag = 3;
            } else {

              iFlag = Integer.parseInt(sFlag);

            }
            if (iFlag > 0) {
              sColorBall = "r.gif";
              bSound = true;
            } else {
              sColorBall = "g.gif";
            }
          %>
          <td style="height: 20px; text-align: center; ">
            <img src="<%=sColorBall%>" width='25' heigth='25'
                 onclick="parent.frames.app.location.href('QryTaskProc.jsp')" />
            <br>
            �ӿ�����Ԥ��</td>
        </tr>
        <tr style="font-size: 12px;">
          <%
            //Weblogic �� weblogic ���� oracle״̬
            sql = "select max(status) from WebPool ";
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
            <img src="<%=sColorBall%>" width='25' heigth='25'
                 onclick="parent.frames.app.location.href('WeblogicDetail.jsp')" />
            <br>
            Weblogic
          </td>
        </tr>
        <tr style="font-size: 12px;">
          <%
            //���������������
            MyLoan dbloan = MyLoan.getInstance();

            sql = "select max(batchstate)  from batchstepdic";
            sFlag = null;
            sFlag = dbloan.selFirstCol(sql);

            if (sFlag == null || sFlag.trim().equals("")) {
              iFlag = 3;
            } else {

              iFlag = Integer.parseInt(sFlag);

            }
            if (iFlag == 3) {
              sColorBall = "r.gif";
              bSound = true;
            } else if (iFlag == 5) {
              sColorBall = "o.gif";
              bSound = true;
            } else {
              sColorBall = "g.gif";
            }
          %>
          <td style="height: 20px; text-align: center; ">
            <img src="<%=sColorBall%>" width='25' heigth='25'
                 onclick="parent.frames.app.location.href('loanbatch.jsp')" />
            <br>
            ��������״̬</td>
        </tr>
        <tr style="font-size: 12px;">
          <%
            //�����������
            MyRep dbrep = MyRep.getInstance();

            sql = "select max(taskstatus)  from task";
            sFlag = null;
            sFlag = dbrep.selFirstCol(sql);

            if (sFlag == null || sFlag.trim().equals("")) {
              iFlag = 4;
            } else {

              iFlag = Integer.parseInt(sFlag);

            }
            if (iFlag == 4) {
              sColorBall = "r.gif";
              bSound = true;
            } else if (iFlag == 5) {
              sColorBall = "o.gif";
              bSound = true;
            } else {
              sColorBall = "g.gif";
            }
          %>
          <td style="height: 20px; text-align: center; ">
            <img src="<%=sColorBall%>" width='25' heigth='25'
                 onclick="parent.frames.app.location.href('RepTran.jsp')" />
            <br>
            �����������</td>
        </tr>
        <tr style="font-size: 12px;">
          <%
            //�������ݵ���
            RepData dbrepdata = RepData.getInstance();
            sql = "select  max(taskstatus)  from task ";
            sFlag = null;
            sFlag = dbrepdata.selFirstCol(sql);

            if (sFlag == null || sFlag.trim().equals("")) {
              iFlag = 4;
            } else {

              iFlag = Integer.parseInt(sFlag);

            }
            if (iFlag == 4) {
              sColorBall = "r.gif";
              bSound = true;
            } else if (iFlag == 5) {
              sColorBall = "o.gif";
              bSound = true;
            } else {
              sColorBall = "g.gif";
            }
          %>
          <td style="height: 20px; text-align: center; ">
            <img src="<%=sColorBall%>" width='25' heigth='25'
                 onclick="parent.frames.app.location.href('RepTranData.jsp')" />
            <br>
            �������ݵ���</td>
        </tr>
        <tr style="font-size: 12px;">
          <td style="height: 20px; text-align: center; ">
            <%
              /** ���ݿ�67ʵ�����start */
              int iFlag67 = 0;
              int iFlag68 = 0;
              MyViewLoan67 dbViewLoan67 = MyViewLoan67.getInstance();
              sql = "select instance_name,version,status,database_status from v$instance";

              rs = dbViewLoan67.selectSql(sql);
              rows = rs.getRowCount();
              iFlag = 0;
              sFlag = null;
              iCurFlag = 0;
              iFlag1 = 0;
              iFlag2 = 0;

              for (int i = 0; i < rows; i++) {
                //System.out.println("rows:"+rows +" currows:"+i +  " UID:" + rs.getString(i,0)+ " Name:" + rs.getString(i,1)+ " flag:" + rs.getString(i,2));
                sFlag = rs.getString(i, 3);

                if (sFlag == null || sFlag.trim().equals("")) {
                  iCurFlag = 3;
                } else {
                  iCurFlag = 0;  // ʵ������

                }
                if (iCurFlag > iFlag67) {
                  iFlag67 = iCurFlag;
                }
                if (iFlag67 >= 3) {
                  break;
                }
              }
              /** ���ݿ�67ʵ�����end */
              /** ���ݿ�68ʵ�����start */
              MyViewLoan68 dbViewLoan68 = MyViewLoan68.getInstance();
              sql = "select instance_name,version,status,database_status from v$instance";

              rs = dbViewLoan68.selectSql(sql);
              rows = rs.getRowCount();
              iFlag = 0;
              sFlag = null;
              iCurFlag = 0;
              iFlag1 = 0;
              iFlag2 = 0;

              for (int i = 0; i < rows; i++) {
                //System.out.println("rows:"+rows +" currows:"+i +  " UID:" + rs.getString(i,0)+ " Name:" + rs.getString(i,1)+ " flag:" + rs.getString(i,2));
                sFlag = rs.getString(i, 3);

                if (sFlag == null || sFlag.trim().equals("")) {
                  iCurFlag = 3;
                } else {
                  iCurFlag = 0;  // ʵ������

                }
                if (iCurFlag > iFlag68) {
                  iFlag68 = iCurFlag;
                }
                if (iFlag68 >= 3) {
                  break;
                }
              }
              /** ���ݿ�68ʵ�����end */
              iFlag = iFlag67 + iFlag68;
              if (iFlag >= 3) {
                sColorBall = "r.gif";
                bSound = true;
              } else {
                sColorBall = "g.gif";
              }
            %>
            <img src="<%=sColorBall%>" width='25' heigth='25'
                 onclick="parent.frames.app.location.href('getHealthSql_68.jsp')" />
            <br>
            ���ݿ�ʵ��</td>
        </tr>
        <tr style="font-size: 12px;">
          <%
            //application  process
            //sql = "select r.procUID , r.procName , d.alertflag  from appproc_reg  r left join   appproc_data d "
            //	+ " on  d.procUID=r.procUID and d.procName = r.procName where r.procUID not like 'WEB:%'";
            //	System.out.println("it is this page");
            sql = "select h.hostID,h.hostDesc,r.procUID,r.procName,d.procNum,d.updatetime, d.alertflag ,d.alertcontent from appproc_reg r ,Hosts h left join "
                    + " appproc_data  d  on r.procUID=d.procUID and r.procName=d.procName where h.hostID=r.hostID  ";

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
              if (iCurFlag > iFlag) {
                iFlag = iCurFlag;
              }
              if (iFlag >= 3) {
                break;
              }
            }

            rs = db.selectSql(sql);
            rows = rs.getRowCount();

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
            <img src="<%=sColorBall%>" width='25' heigth='25'
                 onclick="parent.frames.app.location.href('AppProcList.jsp')" />
            <br>
            Ӧ�ý���
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

              if (iCurFlag > iFlag) {
                iFlag = iCurFlag;
              }

              if (iFlag >= 3) {
                break;
              }
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
            <img src="<%=sColorBall%>" width='25' heigth='25'
                 onclick="parent.frames.app.location.href('TuxSvcList.jsp')" />
            <br>
            TUX����
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
              if (iCurFlag > iFlag) {
                iFlag = iCurFlag;
              }
              if (iFlag >= 3) {
                break;
              }
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
            <img src="<%=sColorBall%>" width='25' heigth='25'
                 onclick="parent.frames.app.location.href('TuxQueList.jsp')" />
            <br>
            TUX����
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
              if (iCurFlag > iFlag) {
                iFlag = iCurFlag;
              }
              if (iFlag >= 3) {
                break;
              }
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
            <img src="<%=sColorBall%>" width='25' heigth='25'
                 onclick="parent.frames.app.location.href('TuxSrvList.jsp')" />
            <br>
            TUX�������
          </td>
        </tr>

        <tr style="font-size: 12px;">
          <%
            //tuxedo  domain
            //sql = "select max(alertflag) from tux_dma_data ";
            sql = "select max(t.alertflag) from tux_dma_data t where t.rdomain not like 'chie%' and t.rdomain not like 'cloan%' and t.rdomain not like 'cpbank%' and t.rdomain not like 'split%' and t.rdomain not like 'dayend%' ";
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
            <img src="<%=sColorBall%>" width='25' heigth='25'
                 onclick="parent.frames.app.location.href('TuxDmaDetail.jsp')" />
            <br>
            TUX������
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
