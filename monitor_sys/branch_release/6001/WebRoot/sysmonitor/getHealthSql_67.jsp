<%--
    Document   : getHealthSql
    Created on : 2010-4-11, 9:33:23
    Author     : kang.cunhua
--%>

<%@page import="com.guloulou.helper.KvCodeHelper"%>
<%@page import="com.git.base.dbmanager.MyViewLoan67"%>
<%@ page language="java" import="java.util.*,java.sql.*,com.git.base.cfg.Service"  contentType="text/html;charset=GBK"%>
<jsp:directive.page import="com.git.base.dbmanager.DBRowSet"/>
<jsp:directive.page import="com.git.base.dbmanager.MyManager"/>
<jsp:directive.page import="com.git.base.dbmanager.Manager"/>
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
        margin:2px;
        font-size:12px;
      }
      .inputNoBorder {
        border-style:none;
        border-width:0px;
      }

    </style>   
  </head>
  <body>
  	<h3>_�������ݿ�67ʵ�����ṩ�ճ����ݿ⽡����鹦��</h3>
  	<hr>
    <p>������˵��������顱������˵��������һ��ʵ�����������</p>
    <p>��֪ͨ����ң��ٽ��м��:</p>
    <p>���鶥���˵�����������顱->��������_67���͡�������顱->��������_68��:</p>
    <p>��ע��۲죺"ѡ������Ŀ" -> "���ݿ�ʵ��״̬"</p>
    <p>�����������顱->��������_67���͡�������顱->��������_67���д򲻿�ҳ�������������ж϶�Ӧʵ���������ˣ�</p>
    <hr>
    <form name="refreshform" method="post">
    </form>
    <form name="form1" method="post" >
      <input  type="hidden" name="checkfalse"/>
      <input  type="hidden" name="maxtime"/>
      <input type="hidden" name="refreshtime" />

      <table width="60%">
        <%
            try {
              String sql = null, sqlsdp = null, value = null, value1 = null;
              int cols = 0, rows = 0;
              // 2010.05.28 add by kangcunhua :start
              int iCurFlag = 0;
              String strBgColor = "style=' background-color: green'";
              // 2010.05.28 add by kangcunhua :end
							
              MyViewLoan67 dbloan = MyViewLoan67.getInstance();

              DBRowSet rsloan = null;
              sql = request.getParameter("healsql");
              if (sql == null){
              	sql = "select instance_name,version,status,database_status from v$instance "; // ��Ĭ��ֵ
              }
              System.out.println("healsql:" + sql);
              out.write("healsql:" + sql);


        %>
        <tr >
          <td> ѡ������Ŀ</td>
          <td><select name="healsql">
              <%
                            out.println(KvCodeHelper.getHtmlOption("HealthSql", sql));
              %>
            </select>
          </td>
          <td> <input type="Submit" name="Submit_item" value="�ύ"> </td>
          <td>
          </td>
        </tr>
      </table>

      <table  border=1 cellspacing="0" cellpadding="0">

        <%
                      rsloan = dbloan.selectSql(sql);
                      cols = rsloan.getColumnCount();
                      rows = rsloan.getRowCount();
                      String[] colsname = null;
                      colsname = rsloan.getColumnNames();
        %>
        <tr>
          <%          for (int i = 0; i < cols; i++) {

          %>
          <th><%=colsname[i]%> </th>
          <%}%>
        </tr>
        <%          for (int i = 0; i < rows; i++) {

        %>

        <tr  align="left"  <%=strBgColor%>>
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
  </body>
</html>

