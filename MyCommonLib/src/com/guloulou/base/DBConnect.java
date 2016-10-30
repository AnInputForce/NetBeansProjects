/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.guloulou.base;

/**
 *
 * @author kang.cunhua
 */
import java.sql.*;

public class DBConnect {

    /**
     * 定义默认的数据库连接参数 连接Sql Server2000
     */
    private String driverName = "";
    private String databaseURL = "";
    private String user = "";
    private String pwd = "";
    // 定义数据库连接、预编译指令、结果集。
    public Connection connection = null;
    public PreparedStatement preStatement = null;
    public ResultSet resultSet = null;

    public DBConnect() {
    }

    /**
     * Constrator 配置数据库连接参数 1
     *
     * @param databaseURL
     *            数据库地址
     * @param user
     *            用户名
     * @param pwd
     *            密码
     */
    public DBConnect(String databaseURL, String user, String pwd) {
        this.databaseURL = databaseURL;
        this.user = user;
        this.pwd = pwd;
    }

    /**
     * Constrator 配置数据库连接参数 2 ，连接SQL Server，My SQL,Oracle等
     *
     * @param drvierName
     *            数据库驱动
     * @param databaseURL
     *            数据库地址
     * @param user
     *            用户名
     * @param pwd
     *            密码
     */
    public DBConnect(String drvierName, String databaseURL, String user,
            String pwd) {
        this.driverName = drvierName;
        this.databaseURL = databaseURL;
        this.user = user;
        this.pwd = pwd;
    }

    /**
     * Constrator 配置数据库连接参数 3 ,连接Access
     *
     * @param drvierName
     *            数据库驱动
     * @param databaseURL
     *            数据库地址
     */
    public DBConnect(String drvierName, String databaseURL) {
        this.driverName = drvierName;
        this.databaseURL = databaseURL;
    }

    /**
     * 加载数据库驱动，创建数据库连接
     */
    public void getConnection() {
        try {
            Class.forName(driverName);
            connection = DriverManager.getConnection(databaseURL, user, pwd);
        }// 捕获加载驱动程序异常
        catch (ClassNotFoundException cnfe) {
            System.err.println("装载 JDBC/ODBC 驱动程序失败。");
            cnfe.printStackTrace();
            System.exit(1); // terminate program
        }// 捕获连接数据库异常
        catch (SQLException sqle) {
            System.err.println("无法连接数据库!");
            sqle.printStackTrace();
            System.exit(1); // terminate program
        }
    }

    /**
     * 预编译SQL语句
     *
     * @param sqlStr
     */
    public void getPreparedStatement(String sqlStr) {
        try {
            preStatement = connection.prepareStatement(sqlStr);
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }
    }

    /**
     * 执行SQL语句: 检索数据
     *
     */
    public void executeQuery() {
        try {
            if (preStatement != null) {
                resultSet = preStatement.executeQuery();
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }
    }

    /**
     * 执行SQL语句: 添加数据
     *
     */
    public void executeInsert() {

        try {
            if (preStatement != null) {
                this.preStatement.execute();
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }
    }

    /**
     * 执行SQL语句: 更新数据
     *
     */
    public void executeUpdate() {
        try {
            if (preStatement != null) {
                this.preStatement.executeUpdate();
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }
    }

    /**
     * 执行SQL语句: 删除数据
     *
     */
    public void executeDelete() {
        try {
            if (preStatement != null) {
                this.preStatement.execute();
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }
    }

    /**
     * 关闭结果集
     *
     */
    public void closeResultSet() {
        try {
            if (!connection.isClosed()) {
                if (resultSet != null) {
                    resultSet.close();
                    resultSet = null;
                }
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }
    }

    /**
     * 关闭预编译指令
     *
     */
    public void closePreStatement() {

        try {
            if (preStatement != null) {
                preStatement.close();
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }
    }

    /**
     * 关闭数据库连接
     *
     */
    public void closeConnection() {
        try {
            if (!connection.isClosed()) {
                connection.close();
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }
    }

    public static void main(String[] args) throws SQLException {
        /**
         * 连接mysql数据库
         */
        String drvierName = "com.mysql.jdbc.Driver";
        String databaseURL = "jdbc:mysql://10.5.5.217/monitor";
        String user = "monitor";
        String pwd = "ycbsyh";

        String sql = "";
        DBConnect dbconn = new DBConnect(drvierName, databaseURL, user, pwd);
        dbconn.getConnection();

        sql = "select * from WebPool";
        dbconn.getPreparedStatement(sql);
        dbconn.executeQuery();
        while (dbconn.resultSet.next()) {

            System.out.println(dbconn.resultSet.getString("ipaddr") + "\t"
                    + dbconn.resultSet.getString("port") + "\t" + dbconn.resultSet.getString("status")
                    + "\t" + dbconn.resultSet.getString("demo"));

        }
        dbconn.closeResultSet();
        dbconn.closePreStatement();
        dbconn.closeConnection();


    }
}
