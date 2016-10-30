<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.git.base.common.*"%>
<%@ page import="com.git.base.util.*"%>
<%@ page import="com.git.base.dbmanager.*"%>
<%@ page import="java.util.*"%>

<%
  
   try{
   String sql = "select 'A'  from dual";
   
   Manager mm = Manager.getInstance();   
   String CurrentNum = mm.execSQLReturnValue(sql); 
   out.println("CurrentNum = " + CurrentNum);
   }catch(Exception ex){
   	out.println(ex.getMessage());
		ex.printStackTrace();

   }
   
   /* 不需要每台oracle都指定去访问；
   mm.setDataSource("ds67");
   String CurrentNum67 = mm.execSQLReturnValue(sql); 
   out.println("CurrentNum67 = " + CurrentNum67);
   
   mm.setDataSource("ds68");
   String CurrentNum68 = mm.execSQLReturnValue(sql); 
   out.println("CurrentNum68 = " + CurrentNum68);
   */
   
  
%>
