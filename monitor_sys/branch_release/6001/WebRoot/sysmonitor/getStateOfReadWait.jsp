<%-- 
    Document   : getStateOfReadWait
    Created on : 2011-2-22, 18:44:17
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
			任务说明： 查询等待状态
      <hr/>
      <hr/>
			使用说明： 查询等待状态
      <hr/>
      <table  border=1 cellspacing="0" cellpadding="0">
        <tr>
          <th> CLASS </th>
          <th> COUNT </th>
          <th> SUM_VALUE </th>
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

              sql = "SELECT v$waitstat.class, v$waitstat.count count, SUM(v$sysstat.value) "
                + "sum_value FROM v$waitstat, v$sysstat "
                + "WHERE v$sysstat.name IN ('db block gets', 'consistent gets') "
                + "group by v$waitstat.class, v$waitstat.count";
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