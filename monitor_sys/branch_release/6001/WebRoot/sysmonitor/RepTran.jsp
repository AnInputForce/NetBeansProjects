<%@ page language="java" import="java.util.*,java.sql.*,com.git.base.cfg.Service"  contentType="text/html;charset=GBK"%>
<jsp:directive.page import="com.git.base.dbmanager.MyRep"/>
<jsp:directive.page import="com.git.base.dbmanager.DBRowSet"/>
<jsp:directive.page import="com.git.base.dbmanager.MyManager"/>
<jsp:directive.page import="com.git.base.dbmanager.Manager"/>
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
    if(document.all.Submit.value=="ֹͣ")
    {
      document.form1.checkfalse.value="false";
      document.all.Interval.value = "";
      document.all.Submit.value="ˢ��";
      document.all.Interval.disabled = true;
      document.all.FreshFlag.checked=false;
      
    }else if ((document.all.FreshFlag.checked) &&( document.all.Interval.value!="" ))
    {
      document.form1.refreshtime.value=document.all.Interval.value;
      document.form1.checkfalse.value="true";
    }
    document.form1.submit();
  }
  function formtaskalertsubmit()
  {
    document.formtaskalert.formtaskalertflag.value="true";    
    document.formtaskalert.submit();
  }
  
</script>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <style>
      body,input,table,tr,td,th,p{

        font-size:12px;

      }
      .inputNoBorder {
        border-style:none;
        border-width:0px;
      }
    </style>
    <%

            if (request.getParameter("leftclick") != null) {
                application.removeAttribute("interval");
                application.removeAttribute("maxtime");

                application.removeAttribute("checkfalse");
                response.sendRedirect("RepTran.jsp");
            } else if (request.getParameter("checkfalse") != null
                    && request.getParameter("checkfalse").equals("true")) {
                application.setAttribute("checkfalse", "true");
                application.removeAttribute("interval");
                response.sendRedirect("RepTran.jsp");
            } else if (request.getParameter("checkfalse") != null
                    && request.getParameter("checkfalse").equals("false")) {
                application.removeAttribute("checkfalse");
            }
    %>
    <%!String intervall = "";%>
    <%
            if (request.getParameter("refreshtime") != null) {
    %>
    <meta http-equiv="refresh" 	content="<%=request.getParameter("refreshtime")%>;">
    <%
                intervall = request.getParameter("refreshtime");
                application.setAttribute("interval", intervall);
                application.setAttribute("refresh", "true");
            } else if (application.getAttribute("refresh") != null
                    && application.getAttribute("refresh").toString().equals("true")) {
    %>
    <meta http-equiv="refresh"
          content="<%=application.getAttribute("interval")%>">
    <%
                intervall = (String) application.getAttribute("interval");

            } else {
                intervall = "";
            }
    %>
  </head>
  <body>
    <br>
    <form name="refreshform" method="post">
    </form>
    <!-- ����taskalert����ʱ����״̬ start -->
    <form name="formtaskalert" method="post">
      <input type="hidden" name="formtaskalertflag"/>
    </form>

    <%
    if  ("true".equals(request.getParameter("formtaskalertflag"))){
      try {
        String sqltaskalert = null ; 
        MyRep dbrepsqltaskalert = MyRep.getInstance();
        int updatenums = 0;
        sqltaskalert = "update task set taskstatus='2' where taskname in ('taskalert2','taskalert4','taskalert9')";
        updatenums = dbrepsqltaskalert.ModifySql(sqltaskalert);
      } catch (Exception se) {
        se.printStackTrace();
      }
    }else{
          %><%="formtaskalertflag" + request.getParameter("formtaskalertflag")%>
    }
    %>

    <!-- ����taskalert����ʱ����״̬ end -->
    <form name="form1" method="post" >
      <input  type="hidden" name="checkfalse"/>
      <input  type="hidden" name="maxtime"/>
      <input type="hidden" name="refreshtime" />
      <table>
        <tr >
          <td> ��ʱˢ�� </td>
          <td><input type="checkbox" name="FreshFlag" onclick=EnableInterval() >
          </td>
          <td> ˢ�¼�� </td>
          <td><input type="text" name="Interval" onKeyUp="javascript:validateNum(document.all.Interval);"
                     size="5"	value="<%=intervall == null ? "" : intervall%>">
          </td>
          <td  align="left">�� </td>
          <td><input type="button" name="Submit" value="ˢ��" onclick=refresh()>
          </td>
        </tr>
      </table>
      <hr/>
      ����״̬�� 0-��ʼ״̬  1-��������  2-������� 4-����ʧ��  5-������ͣ
      <hr/>
      <!--  2010.05.28 add by kangcunhua :start -->
      <tr>
      <input  type="label"  size="4"  disabled="disabled" <%out.print("style=' background-color: #FFFF00'");%> >
      ��������
      <input  type="label"  size="4"  disabled="disabled" <%out.print("style=' background-color: green'");%> >
      ���гɹ�
      <input  type="label"  size="4"  disabled="disabled" <% out.print("style=' background-color: red'");%> >
      ����ʧ��
      <input  type="label"  size="4"  disabled="disabled" <% out.print("style=' background-color: #FFA500'");%> >
      ���и澯 
      <input type="button" name="Submit" value="Ԥ����������" 
             onclick="formtaskalertsubmit()">Ԥ����������
      </tr>
      <!--  2010.05.28 add by kangcunhua :end -->
      <hr/>
      <table  border=1 cellspacing="0" cellpadding="5">
        <tr>
          <th> �������� </th>
          <th> �������� </th>
          <th> �������� </th>
          <th> ����״̬ </th>
          <th> �������� </th>
          <th> ��ʼʱ�� </th>
          <th> ����ʱ�� </th>                    
        </tr>
        <%
                try {
                    String sql = null, sqlsdp = null, value = null, value1 = null;
                    int cols = 0, rows = 0;
                    // 2010.05.28 add by kangcunhua :start
                    int iCurFlag = 0;
                    String strBgColor = "style=' background-color: green'";
                    // 2010.05.28 add by kangcunhua :end

                    MyRep dbrep = MyRep.getInstance();
                    //Manager dbsdp = Manager.getInstance();

                    DBRowSet rsrep = null;

                    sql = "select taskname,taskdescribe,tasktype, taskstatus,to_char(taskrundate,'yyyyMMdd'),to_char(taskstart,'yyyy-MM-dd hh24:mi:ss'),to_char(taskend,'yyyy-MM-dd hh24:mi:ss')taskend from task order by tasktype,taskstatus,taskname ";


                    rsrep = dbrep.selectSql(sql);

                    cols = rsrep.getColumnCount();
                    rows = rsrep.getRowCount();

                    for (int i = 0; i < rows; i++) {
                        // 2010.05.28 add by kangcunhua :start
                        iCurFlag = Integer.parseInt(rsrep.getString(i, "taskstatus"));

                        if ((iCurFlag == 2)) {

                            strBgColor = "style=' background-color: green'";

                        } else if (iCurFlag == 5) {
                            strBgColor = "style=' background-color: #ffa500'";
                        } else if (iCurFlag == 1) {
                            strBgColor = "style=' background-color: #FFFF00'";
                        } else if (iCurFlag == 0) {
                            strBgColor = "style=' background-color: #FFFFFF'";
                        } else {
                            strBgColor = "style=' background-color: red'";
                        }
    // 2010.05.28 add by kangcunhua :end
        %>
        <tr  align="right"  <%=strBgColor%>>
          <!-- strBgColor:  2010.05.28 add by kangcunhua -->
          <%
                              for (int j = 0; j < cols; j++) {
          %>
          <td><%
                              value = rsrep.getString(i, j);
                              if (value == null) {
                                  value = "";
                              }
            %>
            <%=value%>
          </td>
          <%}%>
        </tr>
        <%}

          } catch (Exception se) {
            se.printStackTrace();
          }%>
      </table>
    </form>
    <%
      if (application.getAttribute("checkfalse") == null) {
    %>
    <script type="text/javascript">
		  
      document.all.FreshFlag.checked=false;
      document.all.Interval.disabled = true;
    </script>
    <%        } else {
    %>
    <script type="text/javascript">
		  
      document.all.Submit.value="ֹͣ";
		       
      document.all.FreshFlag.checked=true;
      document.all.Interval.disabled = false;
    </script>
    <%}
    %>
  </body>
</html>
