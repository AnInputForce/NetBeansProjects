<%-- 
    Document   : loanbatch
    Created on : 2010-10-31, 12:52:23
    Author     : kang.cunhua
--%>

<%@ page language="java" import="java.util.*,java.sql.*,com.git.base.cfg.Service"  contentType="text/html;charset=GBK"%>
<jsp:directive.page import="com.git.base.dbmanager.MyLoan"/>
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
            任务状态： 0-初始状态  1-正在运行  2-运行完毕 3-运行失败
            <hr/>
            <!--  2010.05.28 add by kangcunhua :start -->
            <tr>
            <input  type="label"  size="4"  disabled="disabled" <%out.print("style=' background-color: #FFFF00'");%> >
            正在运行
            <input  type="label"  size="4"  disabled="disabled" <%out.print("style=' background-color: green'");%> >
            运行成功
            <input  type="label"  size="4"  disabled="disabled" <% out.print("style=' background-color: red'");%> >
            运行失败
            <input  type="label"  size="4"  disabled="disabled" <% out.print("style=' background-color: #FFA500'");%> >
            运行告警 </tr>
            <!--  2010.05.28 add by kangcunhua :end -->
            <hr/>
            <table  border=1 cellspacing="0" cellpadding="5">
                <tr>
                    <th> 省号 </th>
                    <th> 省名 </th>
                    <th> 批量编号 </th>
                    <th> 批量描述 </th>
                    <th> 批量状态 </th>
                    <th> 批量日期 </th>
                    <th> 开始时间 </th>
                    <th> 结束时间 </th>
                </tr>
                <%
                        try {
                            String sql = null, sqlsdp = null, value = null, value1 = null;
                            int cols = 0, rows = 0;
                            // 2010.05.28 add by kangcunhua :start
                            int iCurFlag = 0;
                            String strBgColor = "style=' background-color: green'";
                            // 2010.05.28 add by kangcunhua :end

                            MyLoan dbloan = MyLoan.getInstance();
                            //Manager dbsdp = Manager.getInstance();

                            DBRowSet rsloan = null;

                            sql = "select a.branchid,b.BRANCHNAME,a.batchno,a.discription," + 
                            			"a.batchstate,to_char(a.batchdate,'yyyyMMdd'),to_char(c.starttime,'yyyy-MM-dd hh24:mi:ss'),to_char(c.endtime,'yyyy-MM-dd hh24:mi:ss') " +
																	"from batchstepdic a ,batchtaskinfo b  ,batchruntime c " +
																	"where a.branchid=b.branchid " +
																	"and a.branchid = c.branchid " +
																	"and a.batchno = c.batchno " +
																	"and a.batchdate= c.batchdate " +
																	"order by branchid,runorder";
                            
                            rsloan = dbloan.selectSql(sql);

                            cols = rsloan.getColumnCount();
                            rows = rsloan.getRowCount();

                            for (int i = 0; i < rows; i++) {
                                // 2010.05.28 add by kangcunhua :start
                                iCurFlag = Integer.parseInt(rsloan.getString(i, "batchstate"));

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
        <%        } else {
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

