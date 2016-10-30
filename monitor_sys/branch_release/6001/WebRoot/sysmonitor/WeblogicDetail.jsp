<%@ page language="java" import="com.git.base.dbmanager.*,com.app.RefreshData"
         contentType="text/html;charset=GBK"%>
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
	    body,input,table,tr,td,th,p{
 
		font-size:12px;
 
	    }
            .inputNoBorder{
                border-style:none;
                border-width:0px;
            }
       	</style>     	
    </head>
    <body>
        <form name="form" method="post" action="./WeblogicDetail.jsp?rData=yes">
            <input type="hidden" name="rData" value="">

            <%
                        String sql, value;
                        MyManager db = MyManager.getInstance();
                        int rows, cols;
                        int iCurFlag = 0;
                        String strBgColor = "style=' background-color: green'";
                        DBRowSet rs = null;
                        String rData = request.getParameter("rData");
                        if (rData != null && rData.trim().equals("yes")) {

                            RefreshData.refreshData("/home/weblogic103/webmonitor/loanserver.sh");

                        }

            %>
            <table>
                <tr >
                    <td>
                        <input type="button" name="Submit" value="刷新" onclick=refresh()>
                    </td>
                </tr>
            </table>
            <hr/>
            <tr>
            <input  type="label"  size="4"  disabled="disabled" <%out.print("style=' background-color: green'");%> >运行正常
            <input  type="label"  size="4"  disabled="disabled" <% out.print("style=' background-color: red'");%> >运行失败
            <input  type="label"  size="4"  disabled="disabled" <% out.print("style=' background-color: #FFA500'");%> >运行告警
            </tr>
            <hr/>
            <table  border=1 cellspacing="0" cellpadding="5">
                <tr bgcolor="#99CCCC">
                    <th width='12%' >
						机器地址
                    </th>
                    <th width='8%'>
						端 口
                    </th>
                    <th width='20%'>
						系统时间
                    </th>
                    <th width='8%'>
						报警标志
                    </th>
                    <th width='18%'>
						备注信息
                    </th>
                </tr>
                <%
                            sql = "select ipaddr,port,systime, status,demo from WebPool  ";

                            //sql="select w.ipadd,w.port,w.status,w.demo , r.name  from WebPort_reg r  left join "
                            //	+ " WebPool  w  on ( r.ipaddr=w.ipaddr and r.port= w.port )  ";// and r.hostID= d.hostID";

                            rs = db.selectSql(sql);
                            cols = rs.getColumnCount();
                            rows = rs.getRowCount();
                            for (int r = 0; r < rows; r++) {

                                iCurFlag = rs.getInt(r, "status");

                                if (iCurFlag == 3) {

                                    strBgColor = "style=' background-color: red'";

                                } else if (iCurFlag == 2) {
                                    strBgColor = "style=' background-color: #ffa500'";
                                } else if (iCurFlag == 0) {
                                    strBgColor = "style=' background-color: red'";
                                } else {
                                    strBgColor = "style=' background-color: green'";
                                }

                %>
                <tr align="right"  <%=strBgColor%>>
                    <%
                                                        for (int c = 0; c < cols; c++) {
                    %>
                    <td style="color:#FFFFFF" align="left">
                        <%
                                                                    value = rs.getString(r, c);
                                                                    if (c == 3 && iCurFlag == 0) {
                                                                        value = "";
                                                                    }
                                                                    if (value == null) {
                                                                        value = "";
                                                                    }
                        %><%=value%>
                    </td>
                    <%}%>
                </tr>
                <%}%>
            </table>
        </form>
    </body>
</html>
