package com.git.base.util;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2004</p>
 * <p>Company: </p>
 * @author not attributable
 * @version 1.0
 */
import java.lang.reflect.*;
import java.lang.Cloneable;
import java.util.Hashtable;
import java.util.Enumeration;
import java.util.Properties;
import java.util.*;

import com.git.base.dbmanager.*;
import com.git.base.cfg.*;
//import com.git.base.DAOObject.*;
import com.git.base.common.LogTools;

public class CopyObject {
  private static Object lock = new Object();
  private static CopyObject splitObject;
  private CopyObject() {
  }

  /***
   *
   */
  public static CopyObject getInstance() {
    if (splitObject == null) {
      synchronized (lock) {
        if (splitObject == null) {
          splitObject = new CopyObject();
        }
      }

    }
    return splitObject;
  }

  /**
   *
   * @param sourObj  源对象
   * @param destObj  目的对象
   * @return
   * @throws java.lang.Exception
   */
  public static boolean splitObjects(Object sourObj, Object destObj) throws Exception {
    boolean result=true;
    try{

      Class sourClass = sourObj.getClass();
      Class destClass = destObj.getClass();

      Method[] methods = destClass.getMethods();
      Method[] src_methods = sourClass.getMethods();
      for (int i = 0; i < methods.length; i++) {
        Method dm = methods[i];
        String methodName = dm.getName();
        String methodValue = null;
        String methodType=methodName.substring(0, 3);

        if (methodType.equalsIgnoreCase("set")) {

          methodName = methodName.substring(3);
          try {
            //get sourObject value
            Method sm = sourClass.getMethod("get" + methodName, null);
            methodValue = (String) sm.invoke(sourObj, null);
            //set destObject value
            if(methodValue!=null){
              //System.out.println(methodName+"--"+methodValue);
              Object[] args = {new String(methodValue)};
              dm.invoke(destObj, args);
            }else{//如果找不到对应的方法，遍历找--200702,llh修改
                String s_methodValue = null;
                for (int j = 0; j < src_methods.length; j++) {
                      Method s_method = methods[j];
                      String s_methodName = dm.getName();

                      if(methodName.equalsIgnoreCase(s_methodName)){
                              s_methodValue=(String) s_method.invoke(sourObj, null);
                              break;
                      }
                }
                if(s_methodValue!=null){
                  //System.out.println(methodName+"--"+methodValue);
                  Object[] args = {new String(s_methodValue)};
                  dm.invoke(destObj, args);
                }

            }
          }
          catch (Exception ex) {
            //check sourObject no this method,do nothing.
          }
        }
      }
    }catch (Exception ex) {
      result=false;
      throw ex;
    }

    return result;
  }

  public static void turnNullToSpace(Object obj)throws Exception {
  try{
    Class destClass=obj.getClass();
    Method[] methods = destClass.getMethods();
    for (int i = 0; i < methods.length; i++) {
      Method dm = methods[i];
      String methodName = dm.getName();
      String methodValue = null;
      String methodType=methodName.substring(0, 3);

      if (methodType.equalsIgnoreCase("set")) {

        methodName = methodName.substring(3);
        try {
          //get sourObject value
          Method sm = destClass.getMethod("get" + methodName, null);
          methodValue = (String) sm.invoke(obj, null);
          //set destObject value
          if(methodValue==null){
            //System.out.println(methodName+"--"+methodValue);
            Object[] args = {new String("")};
            dm.invoke(obj, args);
          }
        }
        catch (Exception ex) {
          //check sourObject no this method,do nothing.
        }
      }
    }
  }catch (Exception ex) {

    throw ex;
  }

  }


  /**
   * 运行对象的方法，输入输出参数都只能为字符串(一个)
   * @param obj
   * @param methodName
   * @param inputParm
   * @return
   * @throws java.lang.Exception
   */
  public static String runObjectMethod(Object obj,String methodName,String inputParm,int flag) throws Exception{
    boolean result=true;
    String outputParm=null;
    Object[] in=new Object[1];
    if (flag == 1) {
      in = null;
    }
    else {
      in[0] = inputParm;
    }



    Class destClass = obj.getClass();

    Method dm = null;
    if (flag==1) {
      dm=destClass.getMethod(methodName,null);
    }
    else {
      Class param[] = new Class[1];
      param[0]=new String("").getClass();
      dm=destClass.getMethod(methodName, param);
    }
    Object rtObj=null;

    if (flag==1) {
      rtObj= dm.invoke(obj, null);
    }else if(flag==2){
      dm.invoke(obj, in);
    }else if(flag==3){
      rtObj= dm.invoke(obj, in);
    }
    if (rtObj!=null) {
      outputParm = (String) rtObj;
    }
    return outputParm;
  }
  /**
   * 根据类名创建一个对象实例
   * @param classname
   * @return
   * @throws java.lang.Exception
   */
  public static Object createObjectInstance(String classname) throws Exception {
    Class newinstance=Class.forName(classname);
    return newinstance.newInstance();
  }


  public static void main(String[] args) {
    //com.git.base.test.testinstance tst1=new com.git.base.test.testinstance();



    try {

      Object tst1=CopyObject.createObjectInstance("com.git.base.test.testinstance");

      CopyObject.runObjectMethod(tst1, "setStr", "qvwen",2);



      System.out.println(CopyObject.runObjectMethod(tst1, "getStr", null,1));
      System.out.println(CopyObject.runObjectMethod(tst1, "getStr", "you is:",3)+CopyObject.runObjectMethod(tst1, "getStr", null,1));
    }catch(Exception ex){
      ex.printStackTrace();
    }

  }




}
