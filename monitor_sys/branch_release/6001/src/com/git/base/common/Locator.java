package com.git.base.common;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2004</p>
 * <p>Company: </p>
 * @author not attributable
 * @version 1.0
 */
import java.util.HashMap;
import java.util.Map;
import java.util.Collections;
import java.net.URL;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import com.git.base.exceptions.ServiceLocatorException;
import javax.naming.Context;
import java.util.Properties;
import javax.ejb.*;
import javax.sql.DataSource;
import javax.transaction.UserTransaction;

public interface Locator {
  /***
   * @return  local ejbhome object
   */
  public EJBLocalHome getLocalHome(String jndiHomeName) throws
      Exception;
  /**
   *
   * @return  remote ejbhome object
   * @throws java.lang.Exception
   */
  public EJBHome getRemoteHome(String jndiHomeName, Class className) throws
      Exception;
  /***
   * @ruturn a context,this context should
   */
  public Context getInitialContext() throws Exception;
  /***
   *
   */
  public Context getWeblogicContext() throws Exception;
  /**
   * return a sql ref jndi name DateSource
   */
  public DataSource getDataSource(String datastr) throws
      Exception;

  public UserTransaction getTransaction() throws
      Exception;
}