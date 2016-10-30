package com.git.base.dbmanager;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2004</p>
 * <p>Company: </p>
 * @author not attributable
 * @version 1.0
 */
/**
   * 序列化查询字符串，以保证中文被正确解析
   */
  public class SerializableSql implements java.io.Serializable {
      private String sqlString = "";

      public SerializableSql(String sqlString){
              this.sqlString = sqlString;
      }

      public String getSerializableSql(){
              return sqlString;
      }
  }
