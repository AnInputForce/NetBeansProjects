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
 * �ܵ��쳣��,��װϵͳ���������������쳣,���ṩ���Է���,��ȡ�쳣����
 */
public class ApplicationException
    extends RuntimeException
    implements java.io.Serializable {

  /**
   * ���巢���쳣ʱ����ʾ�ľ�����Ϣ.
   **/
  public String msg = null;

  /**
   * ���巢���쳣�ķ�������.
   **/
  public String javaMethod = null;

  /**
   * ���巢�����쳣����.
   **/
  public Exception error = null;

  /**
   * ����ϵͳ�׳�������쳣��Ϣ
   */
  public String errorMsg = null;

  /**
   * �����쳣����.
   **/
  private int errorCode = 0;

  //public final static int DUP_KEY = 1;

  /**
   * �޲���ֵ�Ĺ��캯��.
   **/
  public ApplicationException() {
    //super();
  }

  /**
   * �����쳣������ʾ��Ϣ�Ĺ��캯��
   **/
  public ApplicationException(String msg) {
    super(msg);
    this.msg = msg;
    System.out.println("����ײ��쳣��Ϣ:" + msg);

  }

  public ApplicationException(String ex_msg, String msg) {
    super(msg+" "+ex_msg);
    this.msg = msg+" "+ex_msg;
    this.errorMsg = ex_msg;
    System.out.println("the msg is:" + msg);
    System.out.println("the ex_msg is:" + ex_msg);

  }

  /**
   * �����쳣������ʾ��Ϣ���쳣������Ϣ�Ĺ��캯��
   **/
  public ApplicationException(String msg, int errorCode) {
    this.msg = msg;
    this.errorCode = errorCode;
  }

  /**
   * �����쳣������ʾ��Ϣ���ض��쳣����Ĺ��캯��
   **/
  public ApplicationException(String msg, Exception ex) {
    this.msg = msg;
    this.error = ex;
  }

  /**
   * �����쳣������ʾ��Ϣ���ض��쳣�����뷢���쳣���ڵķ������ƵĹ��캯��.
   **/

  public ApplicationException(String msg, String javaMethod, Exception ex) {
    this.msg = msg;
    this.error = ex;
    this.javaMethod = javaMethod;
  }

  /**
   * ���쳣������ʾ��Ϣ���ԵĻ�ȡ����.
   **/
  public String getMsg() {
    return this.msg;
  }

  /**
   * ���쳣�������ڷ������ԵĻ�ȡ
   **/
  public String getJavaMethod() {
    return this.javaMethod;
  }

  /**
   * �Է����ľ����쳣����Ļ�ȡ.
   **/
  public Exception getError() {
    return this.error;
  }

  /**
   * ���쳣�������ԵĻ�ȡ.
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
   * ��ϵͳ�����쳣��Ϣ�Ļ�ȡ
   **/
  public String getErrorMsg() {
    return this.errorMsg;
  }

}
