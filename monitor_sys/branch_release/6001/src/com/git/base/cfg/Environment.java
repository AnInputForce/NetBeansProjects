package com.git.base.cfg;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2004</p>
 * <p>Company: </p>
 * @author not attributable
 * @version 1.0
 */
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import org.apache.log4j.Logger;

/**
 * 定义系统环境变量
*/

public final class Environment {
  public static final String APP_SERVER = "com.git.monitor.app_server";
  public static final String HOST_URL = "com.git.monitor.host_url";
  public static final String ORADRIVER = "com.git.monitor.oracle.driver";
  public static final String ORADRIVERCLASS = "com.git.monitor.oracle.driver_class";
  public static final String ORADRIVERURL = "com.git.monitor.oracle.driver_url";
  public static final String ORADATASOURCE = "com.git.monitor.oracle.datasource";
  public static final String ORADRIVERURLREP = "com.git.monitor.oracle.driver_url_rep";
  
  public static final String SQLDRIVER = "com.git.monitor.mysql.driver";
  public static final String SQLDRIVERCLASS = "com.git.monitor.mysql.driver_class";
  public static final String SQLDRIVERURL = "com.git.monitor.mysql.driver_url";
  public static final String SQLDATASOURCE = "com.git.monitor.mysql.datasource";
  
  public static final String HOSTPORT = "com.git.monitor.host_port";
  public static final String SOUNDFILE = "com.git.monitor.sound.file";  
  public static final String SOUNDTIMES = "com.git.monitor.sound.times";
 
  public static final String REFRESHTIME = "com.git.monitor.refresh";	
  
  public static final String IN_ENCODE_FLAG="com.git.loan.inencodeflag";
  public static final String OUT_ENCODE_FLAG="com.git.loan.outencodeflag";
  public static final String IN_ENCODE_TYPE="com.git.loan.inencodetype";
  public static final String OUT_ENCODE_TYPE="com.git.loan.outencodetype";

  public static final String TRACERT_LOG_FILE="tracertlogfile";
  public static final String TRACERT_LOG_ROWNUM="tracertlogrownum";

  
  private static final Properties GLOBAL_PROPERTIES;
  private static final Logger log = Logger.getLogger(Environment.class);

  static {
    GLOBAL_PROPERTIES = new Properties();
    init();
  }

  private Environment() {
  }

  public static void  reload(){
     init();
  }

  /**
   * Return <tt>System</tt> properties, extended by any properties specified
   * in <tt>loan.properties</tt>.
   * @return Properties
   */

  public static Properties getProperties() {
    Properties copy = new Properties();
    copy.putAll(GLOBAL_PROPERTIES);
    return copy;
  }

  /**
   * init GLOBAL_PROPERTIES
   */
  private static void init(){
    InputStream stream = Environment.class.getResourceAsStream(
        "/com/git/base/cfg/monitor.properties");
    if (stream == null) {
      log.info("loan.properties not found");
      //System.out.println("xxxxxxxxxx");
    }
    else {

      try {
        GLOBAL_PROPERTIES.load(stream);
        //System.out.println("yyyyyyy");
        log.info("loaded properties from resource loan.properties: " +
                 GLOBAL_PROPERTIES);
      }
      catch (Exception e) {
        log.error("problem loading properties from loan.properties");
      }
      finally {
        try {
          stream.close();
        }
        catch (IOException ioe) {
          log.error("could not close stream on loan.properties", ioe);
        }
      }
    }

    GLOBAL_PROPERTIES.putAll(System.getProperties());

    //System.out.println(GLOBAL_PROPERTIES.getProperty("com.git.loan.host_url"));


  }
}
