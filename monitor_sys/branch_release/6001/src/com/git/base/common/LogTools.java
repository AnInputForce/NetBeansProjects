package com.git.base.common;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2004</p>
 * <p>Company: </p>
 * @author not attributable
 * @version 1.0
 */
import java.util.ArrayList;

/**
 * LogTools
 * a abstract class for log,it defines a log interface, and offers a static
 * method to get a frondose loger sub-class instance.
 *
 */
public abstract class LogTools {
  private static LogTools logger;
  /**
   * define log level
   */
  protected int logLevel;

  /**
   * log level const.
   * eg.if logLevel >= LOG_LEVEL_DEBUG then will write debug level log message.
   */
  protected final static int LOG_LEVEL_DEBUG = 3;
  /**
   * log level const.
   * eg.if logLevel >= LOG_LEVEL_INFO then will write info level log message.
   */
  protected final static int LOG_LEVEL_INFO = 2;
  /**
   * log level const.
   * eg.if logLevel >= LOG_LEVEL_ERROR then will write error level log message.
   */
  protected final static int LOG_LEVEL_ERROR = 1;
  /**
   * log level const.
   * eg.if logLevel = LOG_LEVEL_NONO then will not write all log message.
   */
  protected final static int LOG_LEVEL_NONO = 0;

  /**
   * DEBUG log type the header
   */
  protected final String TYPE_DEBUG = "DEBUG -->";

  /**
   * INFO log type the header
   */
  protected final String TYPE_INFO = "INFO -->";

  /**
   * ERROR log type the header
   */
  protected final String TYPE_ERROR = "ERROR -->";

  private static Object lock = new Object();

  public void setLevel(int level){
    this.logLevel = level;
  }

  public int getLevel(){
    return this.logLevel;
  }
  /**
   *get a singtone frondose LogTools instance
   * @return LogTools instance
   */
  public static LogTools getInstance() {
    if (logger == null) {
      synchronized (lock) {
        if (logger == null){
          ArrayList slog = null;
          try {
            slog = InputLog.getInstance().getLoggerList();
          }
          catch (Exception ex1) {
            ex1.printStackTrace();
          }
          String level = (String)slog.get(0);
          String className = (String)slog.get(1);
          LogTools log = null;
          try {
            log = (LogTools) Class.forName(className).newInstance();
          } catch (Exception ex) {          }
          if(level.equalsIgnoreCase("DEBUG"))
            log.setLevel(LOG_LEVEL_DEBUG);
          else if(level.equalsIgnoreCase("INFO"))
            log.setLevel(LOG_LEVEL_INFO);
          else if(level.equalsIgnoreCase("ERROR"))
            log.setLevel(LOG_LEVEL_ERROR);
          else
            log.setLevel(LOG_LEVEL_NONO);
          logger = log;
        }

      }
    }
    return logger;
  }

  /**
   * abstract method.define write info level interface
   * @param msg the message will be wrote
   */
  public abstract void info(String msg);

  /**
   * abstract method.define write info level interface
   * @param msg the message will be wrote
   * @param td the InnerData info will be wrote
   */
//  public abstract void info(String msg, InnerData td);

  /**
   * abstract method.define write debug level interface
   * @param msg the message will be wrote
   *
   */
  public abstract void debug(String msg);

  /**
   * abstract method.define write debug level interface
   * @param msg the message will be wrote
   * @param td the InnerData info will be wrote
   */
//  public abstract void debug(String msg, InnerData td);

  /**
   * abstract method.define write error level interface
   * @param msg the message will be wrote
   *
   */
  public abstract void error(String msg);

  /**
   * abstract method.define write error level interface
   * @param msg the message will be wrote
   * @param ex the Exception will be wrote
   */
  public abstract void error(String msg, Exception ex);

  /**
   * abstract method.define write error level interface
   * @param msg the message will be wrote
   * @param ex the Exception will be wrote
   * @param td the InnerData info will be wrote
   */
//  public abstract void error(String msg, Exception ex, InnerData td);

}
