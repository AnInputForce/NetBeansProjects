package com.git.base.common;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2004</p>
 * <p>Company: </p>
 * @author not attributable
 * @version 1.0
 */

public class ConsoleLoger extends LogTools {

  public ConsoleLoger() {
  }

  public void debug(String msg) {
    if (this.logLevel >= this.LOG_LEVEL_DEBUG) {
      System.out.println(this.TYPE_DEBUG + msg);
    }

  }

//  public void debug(String msg, InnerData td) {
//    if (this.logLevel >= this.LOG_LEVEL_DEBUG) {
//      System.out.println(this.TYPE_DEBUG + msg + td.toString());
//    }
//
//  }

  public void info(String msg) {
    if (this.logLevel >= this.LOG_LEVEL_INFO) {
      System.out.println(this.TYPE_INFO + msg);
    }

  }

//  public void info(String msg, InnerData td) {
//    if (this.logLevel >= this.LOG_LEVEL_INFO) {
//      System.out.println(this.TYPE_INFO + msg + td.toString());
//    }
//
//  }

  public void error(String msg) {
    if (this.logLevel >= this.LOG_LEVEL_ERROR) {
      System.out.println(this.TYPE_ERROR + msg);
    }

  }

  public void error(String msg, Exception ex) {
    if (this.logLevel >= this.LOG_LEVEL_ERROR) {

      System.out.println(this.TYPE_ERROR + msg + "\nException:" + ex.getMessage());
    }

  }

//  public void error(String msg, Exception ex, InnerData td) {
//    if (this.logLevel >= this.LOG_LEVEL_ERROR) {
//      System.out.println(this.TYPE_ERROR + msg + " Exception:" + ex.getMessage() +
//                         td.toString());
//    }
//
//  }

}
