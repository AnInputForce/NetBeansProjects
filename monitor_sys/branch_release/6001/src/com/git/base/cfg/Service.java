package com.git.base.cfg;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2004</p>
 * <p>Company: </p>
 * @author not attributable
 * @version 1.0
 */
import java.util.Properties;


/**
 * 定义获得系统环境变量的服务
*/

public class  Service{


        private static Properties properties = Environment.getProperties();

        private Service(){

        }
        public static void reload(){
          Environment.reload();
          properties = Environment.getProperties();
        }

        public  static String getAppServer() {
                //return  getProperty(Environment.HOST_URL);
                return properties.getProperty(Environment.APP_SERVER);
        }

        public  static String getHostUrl() {
                //return  getProperty(Environment.HOST_URL);
                return properties.getProperty(Environment.HOST_URL);
        }

        public static String getOracleDriver() {
                return properties.getProperty(Environment.ORADRIVER);
        }
        public static String getMySqlDriver() {
            return properties.getProperty(Environment.SQLDRIVER);
        }
        public static String getOracleDriverClass() {
                return properties.getProperty(Environment.ORADRIVERCLASS);
        }
        public static String getMySqlDriverClass() {
            return properties.getProperty(Environment.SQLDRIVERCLASS);
        }
        public static String getOracleDriverUrl() {
                return properties.getProperty(Environment.ORADRIVERURL);
        }
        public static String getOracleDriverUrlREP() {
            return properties.getProperty(Environment.ORADRIVERURLREP);
    }
        public static String getMySqlDriverUrl() {
            return properties.getProperty(Environment.SQLDRIVERURL);
        }

        public static String getOracleDataSource() {
                return properties.getProperty(Environment.ORADATASOURCE);
        }
        public static String getMySqlDataSource() {
            return properties.getProperty(Environment.SQLDATASOURCE);
        }
        public static String getRefreshTime() {
                return properties.getProperty(Environment.REFRESHTIME);
        }
        public static String getHostPort() {
            return properties.getProperty(Environment.HOSTPORT);
        }
        public static String getSoundFile() {
            return properties.getProperty(Environment.SOUNDFILE);
        }
        public static String getSoundTimes() {
            return properties.getProperty(Environment.SOUNDTIMES);
        }
        public static String getInEncodeFlag() {
                return properties.getProperty(Environment.IN_ENCODE_FLAG);
        }
        public static String getOutEncodeFlag() {
                return properties.getProperty(Environment.OUT_ENCODE_FLAG);
        }
        public static String getInEncodeType() {
                return properties.getProperty(Environment.IN_ENCODE_TYPE);
        }
        public static String getOutEncodeType() {
                return properties.getProperty(Environment.OUT_ENCODE_TYPE);
        }
        public static String getTracertLogFile(){
            return properties.getProperty(Environment.TRACERT_LOG_FILE);
        }
        public static int getTracertRowNum(){
           return Integer.valueOf(properties.getProperty(Environment.TRACERT_LOG_ROWNUM)).intValue();
        }

        public static String getPropertyList() {
                return getProperties().toString();
        }

        public static String getProperty(String property) {
                return properties.getProperty(property);
        }

        public void setProperty(String property, String value) {
                properties.setProperty(property, value);
        }

        protected static Properties getProperties() {
                return properties;
        }

       

}







