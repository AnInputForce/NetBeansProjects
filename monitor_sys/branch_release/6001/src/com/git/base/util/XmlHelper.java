package com.git.base.util;

import java.lang.reflect.*;
/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2004</p>
 * <p>Company: </p>
 * @author not attributable
 * @version 1.0
 */

public final class XmlHelper {

  /**
   * 获得javaBean的xml字符对象
   * @param bean
   * @return
   * @throws java.lang.Exception
   */
  public static String getBeanXMLString (Object bean) throws Exception {
    String xmlName="";

    String beanName=bean.getClass().getName();
    int index=beanName.lastIndexOf(".");
    if(index<0){
      xmlName=beanName;
    }else{
      xmlName=beanName.substring(index+1);
    }
    return getBeanXMLString(bean,xmlName,null);
  }

  public static String getBeanXMLString (Object bean,String[] properties) throws Exception {
    return getBeanXMLString(bean,properties,false);
  }

  public static String getBeanXMLString (Object bean,String[] properties,boolean filterType) throws Exception {
    String xmlName="";

    String beanName=bean.getClass().getName();
    int index=beanName.lastIndexOf(".");
    if(index<0){
      xmlName=beanName;
    }else{
      xmlName=beanName.substring(index+1);
    }
    return getBeanXMLString(bean,xmlName,properties,filterType);
  }

  public static String getBeanXMLString (Object bean,String xmlName,String[] properties) throws Exception {
    return getBeanXMLString(bean,xmlName,properties,false);
  }
  /**
   * 获得javaBean的xml字符对象
   * @param bean
   * @param xmlName
   * @param String[] properties  过滤属性
   * @param boolean  filterType  true: 过滤properties中设置的属性，不输出该属性
   *                             flase:输出properties中设置的属性，默认flase
   * @return
   * @throws java.lang.Exception
   */
  public static String getBeanXMLString (Object bean,String xmlName,String[] properties,boolean filterType) throws Exception {
  StringBuffer buffer=new StringBuffer();
  boolean showAllProperty=false;
  if(properties==null)showAllProperty=true;
  try{

    Class sourClass = bean.getClass();
    Method[] methods = sourClass.getMethods();

    buffer.append(xmlName);
    for (int i = 0; i < methods.length; i++) {
      Method dm = methods[i];
      String methodName = dm.getName();
      String propertyName="";
      String methodValue = null;
      String methodType=methodName.substring(0, 3);

      if (methodType.equalsIgnoreCase("set")) {
        methodName = methodName.substring(3);
        propertyName=methodName.substring(0,1).toLowerCase()+methodName.substring(1);

        if(showAllProperty==false){
          boolean flag=false;
          for(int j=0;j<properties.length;j++){
            if(propertyName.equals(properties[j])){
              flag=true;
              break;
            }
          }
          if(!filterType){//输出propertie属性
            if (!flag) { //找不到属性，继续
              continue;
             }
          }else{//不输出propertie属性
            if(flag){
              continue;
            }
          }
        }
        try {
          //get sourObject value
          Method sm = sourClass.getMethod("get" + methodName, null);
          methodValue = (String) sm.invoke(bean, null);
          //set destObject value
          if(methodValue!=null){
             buffer.append(" ");
             buffer.append(propertyName);
             buffer.append("=\"");
             buffer.append(escapeForXML(methodValue));
             buffer.append("\"");
          }else{
            /*
            buffer.append(" ");
            buffer.append(methodName);
            buffer.append("=\"");
            buffer.append("\"");
            */
          }
        }
        catch (Exception ex) {
          //check sourObject no this method,do nothing.
        }
      }
    }

   }
   catch (Exception ex) {
    throw ex;
   }

   return buffer.toString();
  }


  public static String getBeanPropertyXMLString (Object bean,String property) throws Exception {

    StringBuffer buffer=new StringBuffer();
    try{

      Class sourClass = bean.getClass();
      Method[] methods = sourClass.getMethods();
      for (int i = 0; i < methods.length; i++) {
        Method dm = methods[i];
        String methodName = dm.getName();
        String propertyName="";
        String methodValue = null;
        String methodType=methodName.substring(0, 3);

        if (methodType.equalsIgnoreCase("set")) {
          methodName = methodName.substring(3);
          propertyName = methodName.substring(0, 1).toLowerCase() +
              methodName.substring(1);

          if (!propertyName.equals(property)) {
            continue;
          }
          try {
            //get sourObject value
            Method sm = sourClass.getMethod("get" + methodName, null);
            methodValue = (String) sm.invoke(bean, null);
            //set destObject value
            if (methodValue != null) {
              buffer.append("<");
              buffer.append(propertyName);
              buffer.append(">");
              buffer.append(escapeForXML(methodValue));
              buffer.append("</");
              buffer.append(propertyName);
              buffer.append(">");
            }
            else {
              /*
                             buffer.append(" ");
                             buffer.append(methodName);
                             buffer.append("=\"");
                             buffer.append("\"");
               */
            }
          }
          catch (Exception ex) {
            //check sourObject no this method,do nothing.
          }
        }


      }



     }
     catch (Exception ex) {
      throw ex;
     }

     return buffer.toString();
    }


  /**
  * 替换xml中的特殊字符
  * @param text
  * @return
  */
  private static String escapeForXML(String text) {
    StringBuffer result = new StringBuffer();
    for ( int i = 0; i < text.length();i++) {
         char character = text.charAt(i);
         if (character == '<') {
            result.append("&lt;");
          }
          else if (character == '>') {
            result.append("&gt;");
          }
          else if (character == '\"') {
            result.append("&quot;");
          }/*
          else if (character == '\'') {
            result.append("&#039;");
          }*/
          else if (character == '\\') {
             result.append("&#092;");
          }
          else if (character == '&') {
             result.append("&amp;");
          }
          else {
            result.append(character);
          }
    }
    return result.toString();
  }

}