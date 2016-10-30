package com.git.base.dbmanager;

import com.git.base.cfg.Service;
import com.git.base.util.*;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2004</p>
 * <p>Company: </p>
 * @author not attributable
 * @version 1.0
 */

public abstract class DataBaseDriverAdapter {
  protected String DATADriverType=null;
   protected int columnIndex;
   public DataBaseDriverAdapter() {
        DATADriverType=Service.getOracleDriver();
   }



   public void setDriverType(String DriverType){
        DATADriverType=DriverType;

   }

   /**
    return the string of finding primaryKey in a table
    @param tableName   需要获得主键的数据库的表名
   */

   public String getPrimaryKeySQL(String tableName) {
     String primaryKeySQL = "";
     //String DATADriverType=null;
     //DATADriverType=LoanService.getDriver();
     if (DATADriverType.equalsIgnoreCase("informix7.x")) {

       primaryKeySQL = " select syscolumns.colname from sysindexes,sysconstraints,systables,syscolumns "
           + " where sysconstraints.tabid=systables.tabid and syscolumns.tabid=systables.tabid "
           + " and systables.tabname='" + tableName + "' and constrtype='P' "
           + " and sysconstraints.idxname=sysindexes.idxname "
           + " and (    sysindexes.part1=syscolumns.colno "
           + "      or  sysindexes.part2=syscolumns.colno "
           + "      or  sysindexes.part3=syscolumns.colno "
           + "      or  sysindexes.part4=syscolumns.colno "
           + "      or  sysindexes.part5=syscolumns.colno "
           + "        )";
       columnIndex=1;

     }
     if (DATADriverType.equalsIgnoreCase("SQLSERVER2000")) {
       primaryKeySQL = "exec sp_pkeys @table_name='" + tableName + "'";
       columnIndex=4;
     }
     if (DATADriverType.equalsIgnoreCase("sybase")) {
      primaryKeySQL = "exec sp_pkeys '" + tableName + "'";
      columnIndex=4;
    }

     return primaryKeySQL;
   }

   public String getDate(){
     String dateFunction="";

     if (DATADriverType.equalsIgnoreCase("informix7.x")) {
        dateFunction = " current() ";

     }

     if (DATADriverType.equalsIgnoreCase("SQLSERVER2000")) {
        dateFunction  = " getdate() ";
     }

     if (DATADriverType.equalsIgnoreCase("sybase")) {
        dateFunction = " getdate() ";
     }
     if (DATADriverType.equalsIgnoreCase("oracle")) {
        dateFunction = " SYSDATE() ";
     }
     return dateFunction ;

   }

   public String  replaceFunction(String queryString) {
     String newString="";
     queryString=StringHelper.replace(queryString,"Select ","select ");
     //System.out.println("......");
     if (DATADriverType.equalsIgnoreCase("informix")) {

        newString=this.replaceIsNull(queryString);
        newString=this.replaceGetDate(newString);
        newString=this.replaceFromTable(newString);
        newString=this.replaceJoiner(newString);
        newString=this.replaceConvert(newString);
        //System.out.println(newString);
        newString=this.replaceSubstring(newString);
        newString=this.replaceDatediff(newString);

        newString=this.replaceTop(newString);
        return newString;

     }else if(DATADriverType.equalsIgnoreCase("sybase")){
         newString=this.replaceMod(queryString);
         return newString;

     }else if(DATADriverType.equalsIgnoreCase("oracle")){
        newString=this.replaceIsNull(queryString);
        newString=this.replaceGetDate_Oracle(newString);
        newString=this.replaceFromTable_Oracle(newString);
        newString=this.replaceJoiner(newString);
        newString=this.replaceConvert(newString);
        newString=this.replaceSubstring_Oracle(newString);
        newString=this.replaceDatediff_Oracle(newString);
        newString=this.replaceDate_Oracle(newString);
        newString=this.replaceDateTime_Oracle(newString);
        newString=this.replaceTop_Oracle(newString);
        return newString;

      }else{
        return queryString;
     }

   }

   public String replaceDateTime(String columnValue){
	   if(columnValue == null)
		   return columnValue;
     //String newValue="";
     if (DATADriverType.equalsIgnoreCase("informix")) {
        if(columnValue.trim().length()>19){
          return columnValue.substring(0,19);
        }
        else{
          return columnValue;
        }
     }else if(DATADriverType.equalsIgnoreCase("oracle")){
    	 
    	 if(columnValue.lastIndexOf(".0") != -1)
    		 columnValue = columnValue.substring(0, columnValue.lastIndexOf(".0"));//2007-7-20时间处理
        return "to_date('"+columnValue+"','yyyy-mm-dd hh24:mi:ss')";
     }else{
        return columnValue;
     }

   }

   /**
    * 替换isnull()为informix的nvl()
    * @param queryString
    * @return
    */
   private String replaceIsNull(String queryString){
     String newString=StringHelper.replace(queryString,"isnull","nvl");
     return newString;
   }

   /**
    * 针对informix的select必须有from Table修改
    * @param queryString
    * @return
    */
   private String replaceFromTable(String queryString){
    String newString = "";
    if(queryString.indexOf("union")>0){//SQL语句中有union
      String tempString = queryString.replaceAll("union", "#");
      String[] ts = StringHelper.split("#", tempString);

      for (int i = 0; i < ts.length; i++) {
        if (ts[i].indexOf("from") < 0) {

          if(i==ts.length-1){//SQL 有union ,则order by 必须在最后，
            int index=ts[i].indexOf("order by");
            if(index>=0){//have order by
               newString += ts[i].substring(0,index)+" from M34 where M34lb=0 "+ts[i].substring(index,ts[i].length());
            }else{
               newString += ts[i] + " from M34 where M34lb=0 ";
            }
          }else{
            newString += ts[i] + " from M34 where M34lb=0 ";
          }
          //newString += ts[i] + " from M34 where M34lb=0 ";
        }
        else {

          if(IsLossFrom(ts[i])){//select 列表有嵌套子查询,子查询必须有from table
            newString += ts[i] + " from M34 where M34lb=0 ";
          }else{
            newString += ts[i];
          }
        }
        if (i != ts.length - 1) {
          newString += " union ";
        }
      }


    }else{//SQL语句中没有union
      if (queryString.indexOf("from") < 0 ) {
         if(queryString.indexOf("select")>=0){
           newString += queryString + " from M34 where M34lb=0 ";
         }else{
           newString = queryString;
         }
      }else{
        if(IsLossFrom(queryString)){//select 列表有嵌套子查询,子查询必须有from table
          newString += queryString + " from M34 where M34lb=0 ";
        }else{
          newString = queryString;
        }


      }

    }
    return newString;
 }

   /**
    * 针对oracle的select必须有from Table修改
    * @param queryString
    * @return
    */
   private String replaceFromTable_Oracle(String queryString){
    String newString = "";
    if(queryString.indexOf("union")>0){//SQL语句中有union
      String tempString = queryString.replaceAll("union", "#");
      String[] ts = StringHelper.split("#", tempString);

      for (int i = 0; i < ts.length; i++) {
        if (ts[i].indexOf("from") < 0) {

          if(i==ts.length-1){//SQL 有union ,则order by 必须在最后，
            int index=ts[i].indexOf("order by");
            if(index>=0){//have order by
               newString += ts[i].substring(0,index)+" from dual "+ts[i].substring(index,ts[i].length());
            }else{
               newString += ts[i] + " from dual ";
            }
          }else{
            newString += ts[i] + " from dual ";
          }
          //newString += ts[i] + " from dual ";
        }
        else {

          if(IsLossFrom(ts[i])){//select 列表有嵌套子查询,子查询必须有from table
            newString += ts[i] + " from dual ";
          }else{
            newString += ts[i];
          }
        }
        if (i != ts.length - 1) {
          newString += " union ";
        }
      }


    }else{//SQL语句中没有union
      if (queryString.indexOf("from") < 0 ) {
         if(queryString.indexOf("select")>=0){
           newString += queryString + " from dual ";
         }else{
           newString = queryString;
         }
      }else{
        if(IsLossFrom(queryString)){//select 列表有嵌套子查询,子查询必须有from table
          newString += queryString + " from dual ";
        }else{
          newString = queryString;
        }


      }

    }
    return newString;
 }

 /**
  * 替换sybase中的+':'+连接符为informix的||':'||
  * @param queryString
  * @return
  */
 private  String replaceJoiner(String queryString){
   String newString="";
   //newString=queryString.replaceAll("+","||");
   newString=StringHelper.replace(queryString,"+':'+","||':'||");
   newString=StringHelper.replace(newString,"+'|'+","||'|'||");
   newString=StringHelper.replace(newString,"+'::'+","||'::'||");
   newString=StringHelper.replace(newString,"+':::'+","||':::'||");
   newString=StringHelper.replace(newString,"+'::::'+","||'::::'||");
   newString=StringHelper.replace(newString,"+':::::'+","||':::::'||");
   return newString;
 }

 /**
  * 替换sybase的convert为informix的cast,只替换一次
  * @param queryString
  * @return
  */
 private  String replaceConvertOnce(String queryString){
   String newString="";
   //newString=queryString.replaceAll("+","||");
   int index=queryString.indexOf("convert(");
   //int end=queryString.indexOf(")",index);
   int end=StringHelper.getFunctionClose(queryString,index+8);

   String tempString=queryString.substring(index+8,end);
   /*
   String[] ts=StringHelper.split(",",tempString);
   String part1,part2;
   part1=ts[0];
   part2="";
   for(int i=1;i<ts.length;i++){
     if(i==ts.length-1){
       part2 += ts[i];
     }else{
       part2 += ts[i] + ",";
     }
   }
   */
   String[] ts=StringHelper.getFunctionPrat(tempString,2);
   String part1,part2;
   part1=ts[0];
   part2=ts[1];
   newString=queryString.substring(0,index)+"cast("+part2+" as " +part1+")"+queryString.substring(end+1);
   return newString;

 }

 /**
  * 替换sybase的convert为informix的cast
  * @param queryString
  * @return
  */
 private  String replaceConvert(String queryString){
   String newString="";
   int index=queryString.indexOf("convert(");
   newString=queryString;
   while(index>=0){
     int end = queryString.indexOf(")", index);
     newString=replaceConvertOnce(newString);
     index=queryString.indexOf("convert(",end);
   }

   return newString;
 }
 /**
  * 替换sybase的substring()为informix的[],只替换一次
  * @param queryString
  * @return
  */
 private  String replaceSubstringOnce(String queryString){
   String newString="";
   //newString=queryString.replaceAll("+","||");
   int index=queryString.indexOf("substring(");
   //int end=queryString.indexOf(")",index);
   int end=StringHelper.getFunctionClose(queryString,index+10);

   String tempString=queryString.substring(index+10,end);
   /*
   String part1,part2,part3;
   part1="";
   String[] ts=StringHelper.split(",",tempString);
   part3=ts[ts.length-1];
   part2=ts[ts.length-2];
   for(int i=0;i<ts.length-2;i++){
     if(i==ts.length-3){
       part1 += ts[i];
     }else{
       part1 += ts[i] + ",";
     }
   }
   */
  String[] ts=StringHelper.getFunctionPrat(tempString,3);
  String part1,part2,part3;
  part1=ts[0];
  part2=ts[1];
  part3=ts[2];
   int count=Integer.parseInt(part2)+ Integer.parseInt(part3)-1;

   newString=queryString.substring(0,index)+part1+"["+part2+","+String.valueOf(count)+"]"+queryString.substring(end+1);

   return newString;

 }

 /**
  * 替换sybase的substring()为informix的[]
  * @param queryString
  * @return
  */
 private  String replaceSubstring(String queryString){
   String newString="";
   int index=queryString.indexOf("substring(");
   newString=queryString;
   while(index>=0){

     int end = queryString.indexOf(")", index);
     newString=replaceSubstringOnce(newString);
     index=queryString.indexOf("substring(",end);

   }

   return newString;
 }

 private  String replaceSubstring_Oracle(String queryString){
     String newString=StringHelper.replace(queryString,"substring(","substr(");
     return newString;
 }

 private  String replaceDatediff(String queryString){
   String newString="";
   int index=queryString.indexOf("datediff(");
   newString=queryString;
   while(index>=0){

     int end = queryString.indexOf(")", index);
     newString=replaceDateDiffOnce(newString);
     index=queryString.indexOf("datediff(",end);

   }

   return newString;
 }


 private  String replaceDatediff_Oracle(String queryString){
   String newString="";
   int index=queryString.indexOf("datediff(");
   newString=queryString;
   while(index>=0){

     int end = queryString.indexOf(")", index);
     newString=replaceDateDiffOnce_Oracle(newString);
     index=queryString.indexOf("datediff(",end);

   }

   return newString;
 }
  private boolean  IsLossFrom(String queryString){
    boolean flag=false;
    int count1=StringHelper.getWordNumber(queryString,"select ");
    //System.out.println(count1);
    int count2=StringHelper.getWordNumber(queryString,"from ");
    //System.out.println(count2);
    if(count1>count2)flag=true;
    return flag;
  }

  private String replaceMod(String queryString){
    String newString="";
    int index=queryString.indexOf("mod(");

    newString=queryString;
    while(index>=0){
      int end = queryString.indexOf(")", index);
      newString=replaceModOnce(newString);
      index=queryString.indexOf("mod(",end);
    }

    return newString;

  }
  /**
   * 替换mod函数
   * @param queryString
   * @return
   */
  private  String replaceModOnce(String queryString){
    String newString="";
    //newString=queryString.replaceAll("+","||");
    int index=queryString.indexOf("mod(");
    //int end=queryString.indexOf(")",index);
    int end=StringHelper.getFunctionClose(queryString,index+4);

    String tempString=queryString.substring(index+4,end);
    /*
    String[] ts=StringHelper.split(",",tempString);
    String part1,part2;
    part1=ts[0];
    part2="";
    for(int i=1;i<ts.length;i++){
      if(i==ts.length-1){
        part2 += ts[i];
      }else{
        part2 += ts[i] + ",";
      }
    }
    */
   String[] ts=StringHelper.getFunctionPrat(tempString,2);
   String part1,part2;
   part1=ts[0];
   part2=ts[1];

    newString=queryString.substring(0,index)+" "+part1+"%" +part2+"  "+queryString.substring(end+1);
    return newString;

  }


  private String replaceGetDate(String queryString){
    String newString = "";
    newString=StringHelper.replace(queryString,"getdate()","today");
    //newString=queryString.replaceAll("getdate()","today");
    return newString;
  }

  private String replaceGetDate_Oracle(String queryString){
    String newString = "";
    newString=StringHelper.replace(queryString,"getdate()","sysdate");
    //newString=queryString.replaceAll("getdate()","today");
    return newString;
  }

  private String replaceTop(String queryString){
    String newString = "";
    newString=queryString.replaceAll(" top "," first ");
    return newString;
  }

  private String replaceTop_Oracle(String queryString){
    String newString = "";
    newString=StringHelper.regexReplace(queryString,"\\stop\\s\\d{1,9}","");
    return newString;

  }

  private String replaceDateDiffOnce(String queryString){
   String newString = "";
   int index=queryString.indexOf("datediff(");
   int end=StringHelper.getFunctionClose(queryString,index+9);
   String tempString=queryString.substring(index+9,end);

   String[] ts = StringHelper.getFunctionPrat(tempString, 3);
   String part1, part2, part3;
   part1 = ts[0];
   part2 = ts[1];
   part3 = ts[2];
   if(part1.equalsIgnoreCase("'d'")||part1.equalsIgnoreCase("'dd'")){//day
     newString=part3+"-"+part2;
   }else if(part1.equalsIgnoreCase("'m'")||part1.equalsIgnoreCase("'mm'")){
     newString="(year("+part3+")-year("+part2+"))*12+"+
               "(month("+part3+")-month("+part2+"))";

   }else if(part1.equalsIgnoreCase("'y'")||part1.equalsIgnoreCase("'yy'")){
     newString="year("+part3+")-year("+part2+")";
   }else{
     newString=part3+"-"+part2;
   }

   newString=queryString.substring(0,index)+" "+newString +"  "+queryString.substring(end+1);
   return newString;


 }

  private String replaceDateDiffOnce_Oracle(String queryString){
   String newString = "";
   int index=queryString.indexOf("datediff(");
   int end=StringHelper.getFunctionClose(queryString,index+9);
   String tempString=queryString.substring(index+9,end);

   String[] ts = StringHelper.getFunctionPrat(tempString, 3);
   String part1, part2, part3;
   part1 = ts[0];
   part2 = ts[1];
   part3 = ts[2];
   if(part1.equalsIgnoreCase("'d'")||part1.equalsIgnoreCase("'dd'")){//day
     newString="to_char("+part3+")-to_char("+part2+")";
   }else if(part1.equalsIgnoreCase("'m'")||part1.equalsIgnoreCase("'mm'")){
     newString="(to_char('"+part3+"','yyyy')-to_char('"+part2+"','yyyy'))*12+"+
               "(to_char('"+part3+"','mm')-to_char('"+part2+"','mm'))";

   }else if(part1.equalsIgnoreCase("'y'")||part1.equalsIgnoreCase("'yy'")){
     newString="to_char('"+part3+"','yyyy')-to_char('"+part2+"','yyyy')";
   }else{
     newString=part3+"-"+part2;
   }

   newString=queryString.substring(0,index)+" "+newString +"  "+queryString.substring(end+1);
   return newString;


 }

 /**
  * 返回Oracle日期解析后的sql
  * @param sql
  * @return
  * @throws java.lang.Exception
  */
 public String  replaceDate_Oracle(String queryString) {
    String newString = "";
    newString=StringHelper.regexReplace(queryString,"\\'\\d{4}-\\d{2}-\\d{2}\\'","to_date(#regex#,'yyyy-mm-dd')");
    return newString;

 }

 public String  replaceDateTime_Oracle(String queryString) {
    String newString = "";
    newString=StringHelper.regexReplace(queryString,"\\'\\d{4}-\\d{2}-\\d{2}\\s\\d{2}:\\d{2}:\\d{2}\\'","to_date(#regex#,'yyyy-mm-dd hh24:mi:ss')");
    return newString;

 }

}
