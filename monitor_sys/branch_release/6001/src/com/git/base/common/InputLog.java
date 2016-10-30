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
    //取子元素信息
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
                           "的setLoggerHash():" + "出现错误--" + e.getMessage());
  }
}
//用于XML文件操作
  private HashMap modelList = new HashMap();
  private ArrayList loggerArray = new ArrayList();

}