package com.git.base.common;

import java.util.ArrayList;
import java.util.HashMap;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2004</p>
 * <p>Company: </p>
 * @author not attributable
 * @version 1.0
 */

public class InputLog {
  private InputLog() {

  }

  public static synchronized InputLog getInstance(){
    return new InputLog();
  }
  /**
   *
   * @param msg
   */
  public ArrayList getLoggerList() throws Exception{
    this.setLoggerList();
    return loggerArray;
  }
  /**
   *
   */
  private void setLoggerList() throws Exception {
  try {
    //ȡ��Ԫ����Ϣ
    String s = null;
//    Element model = (Element) modelList.get("Logger");
//    Element log = model.getChild(model.getAttributeValue("active"));
//
//    s = log.getAttributeValue("level");
    this.loggerArray.add("DEBUG");
//    s = log.getAttributeValue("class");
//    s=classname;
    this.loggerArray.add("com.git.base.common.ConsoleLoger");
  } catch (Exception e) {
    throw new Exception("className=" + this.getClass().getName() +
                           "��setLoggerHash():" + "���ִ���--" + e.getMessage());
  }
}
//����XML�ļ�����
  private HashMap modelList = new HashMap();
  private ArrayList loggerArray = new ArrayList();

}