package com.git.base.common;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2004</p>
 * <p>Company: </p>
 * @author not attributable
 * @version 1.0
 */
import javax.servlet.jsp.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.Vector;

import com.git.base.common.*;
import com.git.base.dbmanager.*;
import com.git.base.util.*;

/**
 * 定义输出listbox的类
 * @version 1.0
 */
public class ListBox {
  public ListBox() {
  }
  public final static String TypeOfDictionary="1";
  public final static String TypeOfQueryString="2";
  private static String width="80";       //宽度
  private static String disabledFlag="0";     //是否disabled
  private static String allowNullFlag="1";    //是否允许选择空值
  private static String onchangeFunction="";  //onchange函数描述
  private static String textAutospace=" textAutospace ";  //textAutospace描述
  /**
   * 获得 listbox的内容
   * @param formType
   * @param fromDesc
   * @return
   */
  private static Vector getListValue(String formType,String fromDesc) {

    Vector dic = null;
    try {
      if (formType.equals(TypeOfDictionary)) { //从大字典得到
        //get the subDic
        dic = DictionaryRepository.getInstance().getSubDic(fromDesc);

        if (dic == null) {
          throw new JspException("dic.not.found");
        }
      }
      else {

//          Manager oM = new Manager();
        dic = Manager.getInstance().execSQL(fromDesc);
        //System.out.print("dic found");
        //throw se;
      }
    }
    catch (Exception se) {
      se.printStackTrace();
    }



    return dic;
  }

  /**
   * 输出listbox
   * @param out
   * @param formType
   * @param fromDesc
   * @param listName
   * @param defaultValue
   * @param width
   * @param disabledFlag
   * @param allowNullFlag
   * @param onchangeFunction
   */
  public static void listBox(JspWriter out, String formType,
                                            String fromDesc,
                                            String listName,
                                            String defaultValue,
                                            String width,
                                            String disabledFlag,
                                            String allowNullFlag,
                                            String onchangeFunction){

         Vector dic=getListValue(formType,fromDesc);
         listBox(out,dic,listName,defaultValue,width,
                     disabledFlag,allowNullFlag,onchangeFunction);


  }
  public static void listBox(JspWriter out, String formType,
                                          String fromDesc,
                                          String listName,
                                          String defaultValue,
                                          String width,
                                          String disabledFlag,
                                          String allowNullFlag,
                                          String onchangeFunction,
                                          String attachPropStr ){

       Vector dic=getListValue(formType,fromDesc);
       listBox(out,dic,listName,defaultValue,width,
                   disabledFlag,allowNullFlag,onchangeFunction,attachPropStr);


}
public static StringBuffer getlistBoxStr(String formType,
                                                 String fromDesc,
                                                 String listName,
                                                 String defaultValue,
                                                 String width,
                                                 String disabledFlag,
                                                 String allowNullFlag,
                                                 String onchangeFunction,
                                                 String attachPropStr ) throws Exception{

              Vector dic=getListValue(formType,fromDesc);
              return getlistBoxStr(dic,listName,defaultValue,width,
                          disabledFlag,allowNullFlag,onchangeFunction,attachPropStr);


       }



  /**
   *
   * @param out
   * @param formType
   * @param fromDesc
   * @param listName
   * @param defaultValue
   * @param width
   * @param disabledFlag
   */
  public static void listBox(JspWriter out, String formType,
                                            String fromDesc,
                                            String listName,
                                            String defaultValue,
                                            String width,
                                            String disabledFlag){

       Vector dic=getListValue(formType,fromDesc);
       listBox(out,dic,listName,defaultValue,width,
                   disabledFlag,allowNullFlag,onchangeFunction);



  }

  /**
   *
   * @param out
   * @param formType
   * @param fromDesc
   * @param listName
   * @param defaultValue
   * @param width
   * @param disabledFlag
   * @param allowNullFlag
   */
  public static void listBox(JspWriter out, String formType,
                                            String fromDesc,
                                            String listName,
                                            String defaultValue,
                                            String width,
                                            String disabledFlag,
                                            String allowNullFlag
                                            ){

       Vector dic=getListValue(formType,fromDesc);
       listBox(out,dic,listName,defaultValue,width,
                   disabledFlag,allowNullFlag,onchangeFunction);



  }


  /**
   *
   * @param out
   * @param formType
   * @param fromDesc
   * @param listName
   * @param defaultValue
   * @param width
   */
  public static void listBox(JspWriter out, String formType,
                                            String fromDesc,
                                            String listName,
                                            String defaultValue,
                                            String width
                                            ){
       Vector dic=getListValue(formType,fromDesc);
       listBox(out,dic,listName,defaultValue,width,
                   disabledFlag,allowNullFlag,onchangeFunction);


  }
  /**
   *
   * @param out
   * @param formType
   * @param fromDesc
   * @param listName
   * @param defaultValue
   */
  public static void listBox(JspWriter out, String formType,
                                          String fromDesc,
                                          String listName,
                                          String defaultValue

                                          ){
     Vector dic=getListValue(formType,fromDesc);
     listBox(out,dic,listName,defaultValue,width,
                 disabledFlag,allowNullFlag,onchangeFunction);


}

       /**
        *
        * @param out
        * @param listValue
        * @param listName
        * @param defaultValue
        * @param width
        * @param disabledFlag
        * @param allowNullFlag
        * @param onchangeFunction
        */
  public static void listBox(JspWriter out,Vector listValue,
                                            String listName,
                                            String defaultValue,
                                            String width,
                                            String disabledFlag,
                                            String allowNullFlag,
                                            String onchangeFunction){


    String[] result=null;
    String SINGLE_QUOTATION_MARK=StringHelper.SINGLE_QUOTATION_MARK;
    String DOUBLE_QUOTATION_MARK=StringHelper.DOUBLE_QUOTATION_MARK;
    try{
        String changeStr="";
        if (!width.equals("0")){
            changeStr = " style=" + SINGLE_QUOTATION_MARK + "width:" + width + SINGLE_QUOTATION_MARK;
        }else{
        	changeStr = " style=" + SINGLE_QUOTATION_MARK +  textAutospace + SINGLE_QUOTATION_MARK;
        }

        if (!(onchangeFunction==null||onchangeFunction.equals(""))){
            changeStr = changeStr + " onchange=" + SINGLE_QUOTATION_MARK + onchangeFunction.trim() + SINGLE_QUOTATION_MARK;
        }
        if(disabledFlag.equals("1")){
            changeStr = changeStr + " disabled";
        }

        out.println("<select name=" + SINGLE_QUOTATION_MARK + listName + SINGLE_QUOTATION_MARK + " size=1" + changeStr + ">");

        if(allowNullFlag.equals("1")){
          out.println("<option value=\"\">" + "</option>");
        }

        for(int i=0;i<listValue.size();i++){
          result=(String[])listValue.elementAt(i);

          if(result[0].trim().equalsIgnoreCase(defaultValue)){
            out.println("<option value=" + SINGLE_QUOTATION_MARK+ result[0].trim() + SINGLE_QUOTATION_MARK +" selected>" + result[1].trim() + "</option>");
          }else{

            out.println("<option value=" + SINGLE_QUOTATION_MARK+ result[0].trim() + SINGLE_QUOTATION_MARK +">" + result[1].trim() + "</option>");
          }
        }
        out.println("</select>");
      }catch(Exception e){
        try {
          out.println(e.getMessage());
        }catch(Exception ioe){}
        e.printStackTrace();
      }

  }
  public static void listBox(JspWriter out,Vector listValue,
                                            String listName,
                                            String defaultValue,
                                            String width,
                                            String disabledFlag,
                                            String allowNullFlag,
                                            String onchangeFunction,
                                            String attachPropStr){


    String[] result=null;
    String SINGLE_QUOTATION_MARK=StringHelper.SINGLE_QUOTATION_MARK;
    String DOUBLE_QUOTATION_MARK=StringHelper.DOUBLE_QUOTATION_MARK;
    String m_listattach=attachPropStr;
    if (m_listattach==null) m_listattach="";
    try{
        String changeStr="";
        if (!width.equals("0")){
            changeStr = " style=" + SINGLE_QUOTATION_MARK + "width:" + width + SINGLE_QUOTATION_MARK;
        }else{
        	changeStr = " style=" + SINGLE_QUOTATION_MARK +  textAutospace + SINGLE_QUOTATION_MARK;
        }

        if (!(onchangeFunction==null||onchangeFunction.equals(""))){
            changeStr = changeStr + " onchange=" + SINGLE_QUOTATION_MARK + onchangeFunction.trim() + SINGLE_QUOTATION_MARK;
        }
        if(disabledFlag.equals("1")){
            changeStr = changeStr + " disabled";
        }

        out.println("<select name=" + SINGLE_QUOTATION_MARK + listName + SINGLE_QUOTATION_MARK + " size=1" + changeStr + " "+ m_listattach +" >");

        if(allowNullFlag.equals("1")){
          out.println("<option value=\"\">" + "</option>");
        }

        for(int i=0;i<listValue.size();i++){
          result=(String[])listValue.elementAt(i);

          if(result[0].trim().equalsIgnoreCase(defaultValue)){
            out.println("<option value=" + SINGLE_QUOTATION_MARK+ result[0].trim() + SINGLE_QUOTATION_MARK +" selected>" + result[1].trim() + "</option>");
          }else{

            out.println("<option value=" + SINGLE_QUOTATION_MARK+ result[0].trim() + SINGLE_QUOTATION_MARK +">" + result[1].trim() + "</option>");
          }
        }
        out.println("</select>");
      }catch(Exception e){
        try {
          out.println(e.getMessage());
        }catch(Exception ioe){}
        e.printStackTrace();
      }

  }
  public static StringBuffer getlistBoxStr(Vector listValue,
                                              String listName,
                                              String defaultValue,
                                              String width,
                                              String disabledFlag,
                                              String allowNullFlag,
                                              String onchangeFunction,
                                              String attachPropStr) throws Exception{

      StringBuffer out=new StringBuffer();
      String[] result=null;
      String SINGLE_QUOTATION_MARK=StringHelper.SINGLE_QUOTATION_MARK;
      String DOUBLE_QUOTATION_MARK=StringHelper.DOUBLE_QUOTATION_MARK;
      String m_listattach=attachPropStr;
      if (m_listattach==null) m_listattach="";
      try{
          String changeStr="";
          if (!width.equals("0")){
              changeStr = " style=" + SINGLE_QUOTATION_MARK + "width:" + width + SINGLE_QUOTATION_MARK;
          }else{
          	changeStr = " style=" + SINGLE_QUOTATION_MARK +  textAutospace + SINGLE_QUOTATION_MARK;
          }

          if (!(onchangeFunction==null||onchangeFunction.equals(""))){
              changeStr = changeStr + " onchange=" + SINGLE_QUOTATION_MARK + onchangeFunction.trim() + SINGLE_QUOTATION_MARK;
          }
          if(disabledFlag.equals("1")){
              changeStr = changeStr + " disabled";
          }

          out.append("<select name=" + SINGLE_QUOTATION_MARK + listName + SINGLE_QUOTATION_MARK + " size=1" + changeStr + " "+ m_listattach +" >\n");

          if(allowNullFlag.equals("1")){
            out.append("<option value=\"\">" + "</option>\n");
          }

          for(int i=0;i<listValue.size();i++){
            result=(String[])listValue.elementAt(i);

            if(result[0].trim().equalsIgnoreCase(defaultValue)){
              out.append("<option value=" + SINGLE_QUOTATION_MARK+ result[0].trim() + SINGLE_QUOTATION_MARK +" selected>" + result[1].trim() + "</option>\n");
            }else{

              out.append("<option value=" + SINGLE_QUOTATION_MARK+ result[0].trim() + SINGLE_QUOTATION_MARK +">" + result[1].trim() + "</option>\n");
            }
          }
          out.append("</select>\n");
        }catch(Exception e){
          try {
            throw new Exception(e.getMessage());
          }catch(Exception ioe){}
          e.printStackTrace();
        }
        return out;
    }
    public static String  getDicShowMsg(String zddh,String xmdh) throws Exception{
      Vector dic = DictionaryRepository.getInstance().getSubDic(zddh);
      String showmsg=null;
      if (dic!=null){
        for(int i=0;i<dic.size();i++){
          String[] result=(String [])(dic.get(i));
          if (result[0].equals(xmdh)){
            showmsg=result[1];
            break;
          }
        }
      }
      return showmsg;
    }

}
