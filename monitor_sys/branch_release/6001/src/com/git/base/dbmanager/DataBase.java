package com.git.base.dbmanager;

import java.sql.Connection;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2004</p>
 * <p>Company: </p>
 * @author not attributable
 * @version 1.0
 */

public interface DataBase {
  /**
   *
   */
  public Connection getConnection() throws Exception;
  /***
   *
   */
  public void disConnect(Connection connection) throws Exception;

}
