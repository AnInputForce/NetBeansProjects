<%-- 
    Document   : getProcessOfResource
    Created on : 2011-2-22, 18:39:13
    Author     : kang.cunhua
--%>

<%@ page language="java" import="java.util.*,java.sql.*,com.git.base.cfg.Service"  contentType="text/html;charset=GBK"%>
<jsp:directive.page import="com.git.base.dbmanager.MyViewLoan"/>
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
    if(document.all.Submit.value=="停止")
    {
      document.form1.checkfalse.value="false";
      document.all.Interval.value = "";
      document.all.Submit.value="刷新";
      document.all.Interval.disabled = true;
      document.all.FreshFlag.checked=false;

    }else if ((document.all.FreshFlag.checked) &&( document.all.Interval.value!="" ))
    {
      document.form1.refreshtime.value=document.all.Interval.value;
      document.form1.checkfalse.value="true";
    }
    document.form1.submit();
  }
</script>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <style type="text/css">
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
          response.sendRedirect("loanbatch.jsp");
        } else if (request.getParameter("checkfalse") != null
          && request.getParameter("checkfalse").equals("true")) {
          application.setAttribute("checkfalse", "true");
          application.removeAttribute("interval");
          response.sendRedirect("loanbatch.jsp");
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
    <form name="form1" method="post" >
      <input  type="hidden" name="checkfalse"/>
      <input  type="hidden" name="maxtime"/>
      <input type="hidden" name="refreshtime" />
      <table>
        <tr >
          <td> 定时刷新 </td>
          <td><input type="checkbox" name="FreshFlag" onclick=EnableInterval() >
          </td>
          <td> 刷新间隔 </td>
          <td><input type="text" name="Interval" onKeyUp="javascript:validateNum(document.all.Interval);"
                     size="5"	value="<%=intervall == null ? "" : intervall%>">
          </td>
          <td  align="left">秒 </td>
          <td><input type="button" name="Submit" value="刷新" onclick=refresh()>
          </td>
        </tr>
      </table>
      <hr/>
			任务说明： 查询耗资源的进程
      <hr/>
      <hr/>
			使用说明： 查询耗资源的进程
      <hr/>
      <table  border=1 cellspacing="0" cellpadding="0">
        <tr>
          <th> SCHEMA_NAME </th>
          <th> ACTION </th>
          <th> SESSION_STATUS </th>
          <th> OS_USER_NAME </th>
          <th> SID </th>
          <th> SPID </th>
          <th> SERIAL_NUM </th>
          <th> USER_NAME </th>
          <th> TERMINAL  </th>
          <th> PROGRAM </th>
          <th> CRITERIA_VALUE </th>

        </tr>
        <%
            try {
              String sql = null, sqlsdp = null, value = null, value1 = null;
              int cols = 0, rows = 0;
              // 2010.05.28 add by kangcunhua :start
              int iCurFlag = 0;
              String strBgColor = "style=' background-color: green'";
              // 2010.05.28 add by kangcunhua :end

              MyViewLoan dbloan = MyViewLoan.getInstance();
              //Manager dbsdp = Manager.getInstance();

              DBRowSet rsloan = null;

              sql = "select s.schemaname schema_name, decode(sign(48 - command), 1,"
                + " to_char(command), 'Action Code #' || to_char(command) ) action,"
                + " status session_status, s.osuser os_user_name, s.sid, p.spid , "
                + " s.serial# serial_num, nvl(s.username, '[Oracle process]') user_name,"
                + " s.terminal terminal, s.program program, st.value criteria_value "
                + " from v$sesstat st, v$session s , v$process p  "
                + "where st.sid = s.sid and   st.statistic# = to_number('38') "
                + "and ('ALL' = 'ALL' or s.status = 'ALL') and p.addr = s.paddr "
                + "order by st.value desc,  p.spid asc, s.username asc, s.osuser asc";
        %>

        <%

                      rsloan = dbloan.selectSql(sql);

                      cols = rsloan.getColumnCount();
                      rows = rsloan.getRowCount();

                      for (int i = 0; i < rows; i++) {

        %>

        <tr  align="right"  <%=strBgColor%>>
          <!-- strBgColor:  2010.05.28 add by kangcunhua -->
          <%
                      for (int j = 0; j < cols; j++) {
          %>
          <td><%
                            value = rsloan.getString(i, j);
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
    <%  } else {
    %>
    <script type="text/javascript">

      document.all.Submit.value="停止";

      document.all.FreshFlag.checked=true;
      document.all.Interval.disabled = false;
    </script>
    <%}
    %>
  </body>
</html>
