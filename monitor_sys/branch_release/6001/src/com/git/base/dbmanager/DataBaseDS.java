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
   *通过一个对象锁来控制数据库连接的同步
   */
 public static Object lock=new Object();
 /**
  *
  */
 public static DataBaseDS sybDB=null;
 /**   * 这个数据库连接成员只有在与数据库直接建立连接的情况下是有效的   */

  private Connection conn = null;

 /**   * 当这个参数有效时，表明程序是直接与数据库建立的连接而不是从连接池里取得连接   */

 private String url, user, password;
 /**   * 当这个参数有效时，表明程序是从连接池里取得连接。   */
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
  * 在不用DataSource和不从配置文件里读书信息的时候先要配置数据源驱动
  */
 public void setDataBaseDriver(String drivers)throws Exception{
   Class.forName(drivers);
 }
 /**
  *
   用数据库地址，用户名，密码初始化数据库对象，这个成员函数用于程序是直接
  * 与数据库建立连接的情况。   * @param url
  * @param user   * @param password   */

 public void setSybDataBase(String url, String user, String password) {
   this.url = url;
   this.user = user;
   this.password = password;
 }

 /**   *
 用JNDI数据源名初始化数据库对象，这个成员函数用于从连接池取数据库连接的情况。
 * @param datasource   */
 public void setSybDataBase(String datasource) {
   this.datasource = datasource;
 }

 public UserTransaction getTransaction() throws   Exception{
   UserTransaction trans;
   trans=ServiceLocator.getInstance().getTransaction();
   return trans;

 }


/**   * 得到数据库连接，对于是否从连接池里取连接做了自动处理即根据用户调用了哪个构造器
 * 来判断是否直接与数据库建立连接还是从连接池里取连接。
* 对于用户来说不用考虑程序是从那里取得连接，他只管正确的初始化数据库对象。
 * @return   * @throws SQLException   */
public Connection getConnection() throws Exception {

  if (datasource == null) { //直接与数据库建立连接
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
  else { //从应用服务器的连接池里取得连接
    DataSource ds = ServiceLocator.getInstance().getDataSource(datasource);
    return ds.getConnection(); //每调用一次都返回一个连接池中的数据库连接
  }
  return conn;
}
  /**   * 释放连接，如果是直接与数据库连接的情况则什么也不做
    * 如果是从连接池中取得的连接那么释放传来的连接   * @param conn
   */
  public void disConnect(Connection connection) throws Exception {
    if (datasource != null) { //只处理从连接池取连接的情况
      try {
        if (connection != null) {
           connection.close();
        }
      }catch (Exception ex) {
        throw ex;
      }
    }
  }

///**   * 得到与参数名对应的表对象，注意这里不作任何数据库操作
//   * @param name   * @return   */

// public Table getTable(String name) {
//    return new SybTable(this, name);
// }

}
