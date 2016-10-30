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
  	<h3>_这是数据库67实例：提供日常数据库健康检查功能</h3>
  	<hr>
    <p>如果左侧菜单“常规检查”报警，说明至少有一个实例是有问题的</p>
    <p>先通知监控室；再进行检查:</p>
    <p>请检查顶部菜单：“健康检查”->“常规检查_67”和“健康检查”->“常规检查_68”:</p>
    <p>请注意观察："选择检查项目" -> "数据库实例状态"</p>
    <p>如果“健康检查”->“常规检查_67”和“健康检查”->“常规检查_67”有打不开页面的情况，可以判断对应实例出问题了！</p>
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
              	sql = "select instance_name,version,status,database_status from v$instance "; // 赋默认值
              }
              System.out.println("healsql:" + sql);
              out.write("healsql:" + sql);


        %>
        <tr >
          <td> 选择检查项目</td>
          <td><select name="healsql">
              <%
                            out.println(KvCodeHelper.getHtmlOption("HealthSql", sql));
              %>
            </select>
          </td>
          <td> <input type="Submit" name="Submit_item" value="提交"> </td>
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

