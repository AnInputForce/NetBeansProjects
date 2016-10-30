package com.git.base.exceptions;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2004</p>
 * <p>Company: </p>
 * @author not attributable
 * @version 1.0
 */
/**
 * 总的异常类,封装系统中所发生的所有异常,并提供属性方法,获取异常属性
 */
public class ApplicationException
    extends RuntimeException
    implements java.io.Serializable {

  /**
   * 定义发生异常时所提示的具体信息.
   **/
  public String msg = null;

  /**
   * 定义发生异常的方法名称.
   **/
  public String javaMethod = null;

  /**
   * 定义发生的异常对象.
   **/
  public Exception error = null;

  /**
   * 定义系统抛出捕获的异常信息
   */
  public String errorMsg = null;

  /**
   * 定义异常代码.
   **/
  private int errorCode = 0;

  //public final static int DUP_KEY = 1;

  /**
   * 无参数值的构造函数.
   **/
  public ApplicationException() {
    //super();
  }

  /**
   * 定义异常具体提示信息的构造函数
   **/
  public ApplicationException(String msg) {
    super(msg);
    this.msg = msg;
    System.out.println("程序底层异常信息:" + msg);

  }

  public ApplicationException(String ex_msg, String msg) {
    super(msg+" "+ex_msg);
    this.msg = msg+" "+ex_msg;
    this.errorMsg = ex_msg;
    System.out.println("the msg is:" + msg);
    System.out.println("the ex_msg is:" + ex_msg);

  }

  /**
   * 定义异常具体提示信息及异常代码信息的构造函数
   **/
  public ApplicationException(String msg, int errorCode) {
    this.msg = msg;
    this.errorCode = errorCode;
  }

  /**
   * 定义异常具体提示信息及特定异常对象的构造函数
   **/
  public ApplicationException(String msg, Exception ex) {
    this.msg = msg;
    this.error = ex;
  }

  /**
   * 定义异常具体提示信息及特定异常对象与发生异常所在的方法名称的构造函数.
   **/

  public ApplicationException(String msg, String javaMethod, Exception ex) {
    this.msg = msg;
    this.error = ex;
    this.javaMethod = javaMethod;
  }

  /**
   * 对异常具体提示信息属性的获取方法.
   **/
  public String getMsg() {
    return this.msg;
  }

  /**
   * 对异常发生所在方法属性的获取
   **/
  public String getJavaMethod() {
    return this.javaMethod;
  }

  /**
   * 对发生的具体异常对象的获取.
   **/
  public Exception getError() {
    return this.error;
  }

  /**
   * 对异常代码属性的获取.
   **/
  public int getErrorCode() {
    return this.errorCode;
  }

  public void setMsg(String msg) {
    this.msg = msg;
  }

  public void setJavaMethod(String javaMethod) {
    this.javaMethod = javaMethod;
  }

  /**
   * 对系统捕获异常信息的获取
   **/
  public String getErrorMsg() {
    return this.errorMsg;
  }

}
