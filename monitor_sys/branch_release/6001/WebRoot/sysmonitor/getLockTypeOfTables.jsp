<%-- 
    Document   : getLockTypeOfTables
    Created on : 2011-2-18, 17:04:22
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
			����˵���� �ṩ������Ϣ����
      <hr/>
      <hr/>
			ʹ��˵���� �緢��ĳ�����������ʱ����3Сʱ������ȷ�ϸ���������ǣ�浽ʲô��Ȼ��ʹ�ñ����ߣ����������������״̬��
      <hr/>
      <table  border=1 cellspacing="0" cellpadding="0">
        <tr>
          <th> ϵͳ�û��� OS_USER_NAME </th>
          <th> ������ machine </th>
          <th> ���ݿ��û���USER_NAME  </th>
          <th> ������ lock_type</th>
          <th> �� object</th>
          <th> ��ģʽ lock_type</th>
          <th> ���û� owner</th>
          <th> SID </th>
          <th> �������к� serial_num</th>
          <th> ����ʶ��1 v$lock.id1</th>
          <th> ����ʶ��2 v$lock.id2</th>
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

              sql = "select /*+ RULE */ ls.osuser os_user_name, ls.machine,  ls.username user_name, "
                + "decode(ls.type, 'RW', 'Row wait enqueue lock', 'TM', 'DML enqueue lock', 'TX', "
                + "'Transaction enqueue lock', 'UL', 'User supplied lock') lock_type,   "
                + "o.object_name object,   decode(ls.lmode, 1, null, 2, 'Row Share', 3,  "
                + "'Row Exclusive', 4, 'Share', 5, 'Share Row Exclusive', 6, 'Exclusive', null)  "
                + "lock_mode,    o.owner,   ls.sid,   ls.serial# serial_num,   ls.id1,   ls.id2  "
                + "from sys.dba_objects o, (   select s.osuser,s.machine,    s.username,    l.type,     "
                + "l.lmode,    s.sid,    s.serial#,    l.id1,    l.id2   from v$session s,    "
                + "v$lock l   where s.sid = l.sid ) ls  where o.object_id = ls.id1 and    o.owner  "
                + "<> 'SYS'   order by o.owner, o.object_name";
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

              if (j == 4) {
            %>
            <a href="getProcessOfObject.jsp?strObj=<%=value%>"><%=value%></a>
            <%
                  } else {
            %>
            <%=value%>
            <%}%>
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
    <%} else {
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