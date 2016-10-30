package com.git.base.dbmanager;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2004</p>
 * <p>Company: </p>
 * @author not attributable
 * @version 1.0
 */
import java.sql.*;
import javax.sql.*;
import com.git.base.common.ServiceLocator;
import javax.transaction.UserTransaction;


public class  DataBaseDS implements DataBase{
  /***
   *ͨ��һ�����������������ݿ����ӵ�ͬ��
   */
 public static Object lock=new Object();
 /**
  *
  */
 public static DataBaseDS sybDB=null;
 /**   * ������ݿ����ӳ�Աֻ���������ݿ�ֱ�ӽ������ӵ����������Ч��   */

  private Connection conn = null;

 /**   * �����������Чʱ������������ֱ�������ݿ⽨�������Ӷ����Ǵ����ӳ���ȡ������   */

 private String url, user, password;
 /**   * �����������Чʱ�����������Ǵ����ӳ���ȡ�����ӡ�   */
 private String datasource;
 private DataBaseDS(){
 }
 /**
  *
  * @return single instance
  */
 public static DataBaseDS getInstance(){
   if(sybDB==null){
     synchronized (lock) {
        if(sybDB==null){
          sybDB=new DataBaseDS();
        }
     }
   }
   return sybDB;
 }
 /***
  * �ڲ���DataSource�Ͳ��������ļ��������Ϣ��ʱ����Ҫ��������Դ����
  */
 public void setDataBaseDriver(String drivers)throws Exception{
   Class.forName(drivers);
 }
 /**
  *
   �����ݿ��ַ���û����������ʼ�����ݿ���������Ա�������ڳ�����ֱ��
  * �����ݿ⽨�����ӵ������   * @param url
  * @param user   * @param password   */

 public void setSybDataBase(String url, String user, String password) {
   this.url = url;
   this.user = user;
   this.password = password;
 }

 /**   *
 ��JNDI����Դ����ʼ�����ݿ���������Ա�������ڴ����ӳ�ȡ���ݿ����ӵ������
 * @param datasource   */
 public void setSybDataBase(String datasource) {
   this.datasource = datasource;
 }

 public UserTransaction getTransaction() throws   Exception{
   UserTransaction trans;
   trans=ServiceLocator.getInstance().getTransaction();
   return trans;

 }


/**   * �õ����ݿ����ӣ������Ƿ�����ӳ���ȡ���������Զ����������û��������ĸ�������
 * ���ж��Ƿ�ֱ�������ݿ⽨�����ӻ��Ǵ����ӳ���ȡ���ӡ�
* �����û���˵���ÿ��ǳ����Ǵ�����ȡ�����ӣ���ֻ����ȷ�ĳ�ʼ�����ݿ����
 * @return   * @throws SQLException   */
public Connection getConnection() throws Exception {

  if (datasource == null) { //ֱ�������ݿ⽨������
    if (conn == null||conn.isClosed()) {
      conn = DriverManager.getConnection(url, user, password);
    }
    else if(!conn.isClosed()){
      conn = DriverManager.getConnection(url, user, password);
    }
    else{
      throw new Exception("please  preform function setSybDataBase(String url, String user, String password) or  preform function setSybDataBase(String datasource),before preform getInstance()");

    }
  }
  else { //��Ӧ�÷����������ӳ���ȡ������
    DataSource ds = ServiceLocator.getInstance().getDataSource(datasource);
    return ds.getConnection(); //ÿ����һ�ζ�����һ�����ӳ��е����ݿ�����
  }
  return conn;
}
  /**   * �ͷ����ӣ������ֱ�������ݿ����ӵ������ʲôҲ����
    * ����Ǵ����ӳ���ȡ�õ�������ô�ͷŴ���������   * @param conn
   */
  public void disConnect(Connection connection) throws Exception {
    if (datasource != null) { //ֻ��������ӳ�ȡ���ӵ����
      try {
        if (connection != null) {
           connection.close();
        }
      }catch (Exception ex) {
        throw ex;
      }
    }
  }

///**   * �õ����������Ӧ�ı����ע�����ﲻ���κ����ݿ����
//   * @param name   * @return   */

// public Table getTable(String name) {
//    return new SybTable(this, name);
// }

}
