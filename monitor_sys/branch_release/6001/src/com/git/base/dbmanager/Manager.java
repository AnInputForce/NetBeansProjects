package com.git.base.dbmanager;

import java.sql.*;
import javax.sql.*;
import java.util.ArrayList;
import java.util.Vector;
import org.apache.log4j.*;

import com.git.base.util.*;
import com.git.base.cfg.Service;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.InputStream;
import javax.transaction.UserTransaction;
//import org.apache.log4j.Logger;

public class Manager  extends DataBaseDriverAdapter {
  
  private static DataSource ds;
  private static final Logger log = Logger.getLogger(Manager.class);
  private int table_prefix = 1;  
  private String dataSourceName = "";  
  private Manager manager = null;
  private static final int OtherType=-1;
  private static final int IntegerType=0;
  private static final int DateTimeType=1;
  private static final int DoubleType=2;
  private static final int TextType=9;
  private static final int StringType=10;
  private boolean getConnByDriver1=false;         //ͨ���ⲿָ�������������
  private boolean useTran=false;
  private static String dbuser="";
  private static String dbpassword="";
  private static Connection m_conn=null;
  private UserTransaction trans=null;
  /***
   * ��������ʵ������ͨ������ģʽ��ʽʵ�ֵġ�
   */

  private Manager() {
  }

  public synchronized static Manager getInstance() {
    return new Manager();
  }

  /**
   * ������������ļ�����������Դ����Ҫ������������á�
   * @param DataSourceName
   */
  public void setDataSource(String DataSourceName) {
    this.dataSourceName = DataSourceName;
  }

  public void setConnectionProperty(String DBUser,String DBPassword) {
    this.dbuser=DBUser;
    this.dbpassword=DBPassword;
    getConnByDriver1=true;
  }

  //�������ݿ�
  public int ModifySql(String sql) throws Exception  {
	int result = 0;
	Connection conn =null;
	Statement stmt = null;
	try {
		conn = this.getConnect();
		stmt = conn.createStatement();
		// ���ܷ���0����Ӱ��0��,�������ⲿʹ�ô˷���ʱ����0
		// һ�����ִ�п��ܳ��˴���Ϊ0����false
		result = stmt.executeUpdate(sql);// ����Ҫcommit,�����ֱ���ύ�����ݿ���
	} catch (SQLException ex) {

		System.out.println("ExecSql");
		System.err.println(ex.getMessage());

	} catch (Exception e) {

		e.printStackTrace();
	}finally {	      
	      closeStatement(stmt);
	      closeConnection(conn);	   
	}
	return result;
  }
	public String selFirstCol(String sql) throws Exception 
	{
			
		Statement stmt = null;
		ResultSet rs = null;
		Connection conn =null;
		try {		
			conn = this.getConnect();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				return rs.getString(1);
			}
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		finally {
			closeResultSet(rs);
			closeStatement(stmt);
			closeConnection(conn);					 
		}
		return "";
		
	}
	public DBRowSet selectSql(String sql) throws Exception 
	{
	    ResultSet rs = null;
	    Connection conn = null;
	    Statement stmt =  null;
	    try {
	    	conn = this.getConnect();
	    	stmt =  conn.createStatement();   
			rs = stmt.executeQuery(sql);
			
	        ResultSetMetaData metadata = rs.getMetaData();
	
	        int columnCount = metadata.getColumnCount();
	        int[] columnTypes = new int[columnCount];
	        String[] columnNames = new String[columnCount];
	
	        for (int i = 0; i < columnCount; i++) {
	            columnTypes[i] = metadata.getColumnType(i + 1);
	            columnNames[i] = metadata.getColumnName(i + 1);
	        }
	
	        // Get all rows.
	        ArrayList rows = new ArrayList();
	        ArrayList row = null;
	        while (rs.next()) {
	            row = new ArrayList();
	            for (int i = 1; i <= columnCount; i++) {
	                Object o = rs.getObject(i);
	                row.add(o);
	            }
	            rows.add(row);
	        }
	        DBRowSet ret = new DBRowSet(rows, columnCount, columnNames, columnTypes);
	        return ret;
	    } finally {
	        closeResultSet(rs);
	        closeStatement(stmt);
			closeConnection(conn);	
	    }
	}
  public Vector execSQL(String queryString) throws Exception 
  {
    Connection conn = this.getConnect();
    Statement stmt = conn.createStatement();
    ResultSet rs = null;
    String[] result;
    Vector results = new Vector();
    try {
      //log.info("execSql befFET:"+queryString);
      if (Service.getInEncodeFlag().equalsIgnoreCase("1")) {
        queryString = StringHelper.parsetrun(queryString,
            Service.getInEncodeType(),
            Service.getOutEncodeType());
      }
      queryString=this.replaceFunction(queryString);
      log.info("queryString is:"+fitEncodeToLocal(queryString));
      rs = stmt.executeQuery(queryString);

      if (rs != null && rs.next()) {
        boolean many = rs.getMetaData().getColumnCount() > 1;
        do {
          //System.out.println(rs.getMetaData().getColumnCount());

          result = new String[rs.getMetaData().getColumnCount()];
          for (int i = 0; i < rs.getMetaData().getColumnCount(); i++) {
            if (rs.getString(i + 1) != null) {
              //System.out.println("......coltype:"+rs.getMetaData().getColumnTypeName(i+1));
              if(rs.getMetaData().getColumnTypeName(i+1).equalsIgnoreCase("text")){
                result[i]=getStringByStream(rs.getAsciiStream(i+1));
                continue;
              }else{
                if (Service.getOutEncodeFlag().equalsIgnoreCase("1")) {
                  result[i] = StringHelper.parsetrun(rs.getString(i + 1),
                      Service.getOutEncodeType(),
                      Service.getInEncodeType()
                      );
                }
                else {
                  result[i] = rs.getString(i + 1);
                }
              }
            }
            else {
              result[i] = "";
              //result.add(i,(Object)"");
            }
            //System.out.print(result[i]);
          }
          try {
            results.addElement(result);
          }
          catch (Exception se) {
            //LogTools.getInstance().error("the execSQL Exceptions:" +
            //                             se.getMessage(), se);
            log.error(se);
            se.printStackTrace();
            throw new Exception("the execSQL Exceptions:" +
                                   se.getMessage(), se);
          }
        }
        while (rs.next());
      }
      else {
        //LogTools.getInstance().info("query result is null!");
        log.info("query result is null!");
        results=null;
      }
    }
    catch (SQLException se) {
      log.error(se);
      se.printStackTrace();
      throw new Exception("the execSQL Exceptions:" +  se.getMessage(), se);

    }
    finally {
      closeResultSet(rs);
      closeStatement(stmt);
      closeConnection(conn);   
    }
    return results;
  }

  public void beginTran()throws SQLException, Exception {
    if(getConnByDriver1==false){
      trans = DataBaseDS.getInstance().getTransaction();
      trans.begin();
    }else{
      useTran=true;
    }
  }

  public void commitTran()throws SQLException, Exception {
    if(getConnByDriver1==false){
      trans = DataBaseDS.getInstance().getTransaction();
      trans.commit();
    }else{
      m_conn.commit();
    }
  }

  public void rollbackTran()throws SQLException, Exception {
    if(getConnByDriver1==false){
      trans = DataBaseDS.getInstance().getTransaction();
      trans.rollback();
    }else{
      m_conn.rollback();
    }

  }

  /**
   *
   * ����ϵͳ�����Ӷ���
   *�������Manager���������û���Ƚ�����������Դ������ʱ���Ǵ������ļ���ȡ����Դ����
   */
  public Connection getConnect() throws SQLException, Exception {
    try {
      Connection conn =null;
      
      if(getConnByDriver1==false){//��JNDI�������ԴDataSource,�ٻ�����Ӷ���
        String ds = Service.getOracleDataSource(); //�������ļ���ȡ����Դ����
 
        if (dataSourceName.equals("")) { //
          DataBaseDS.getInstance().setSybDataBase(ds);
        }
        else {
   
          DataBaseDS.getInstance().setSybDataBase(dataSourceName); //��ͨ��setDataSource()���������趨��
        }
        conn = DataBaseDS.getInstance().getConnection();

      }else{//ֱ�ӻ�����Ӷ���
        //System.out.println(Service.getDriverClass());
        //System.out.println(Service.getDriverUrl());
        if(m_conn==null){

          Class.forName(Service.getOracleDriverClass().trim());
          String url = Service.getOracleDriverUrl();
          //System.out.println(Service.getDriverUrl());
          //System.out.println(url+":"+dbuser+":"+dbpassword);
          m_conn = DriverManager.getConnection(url, dbuser, dbpassword);
          if(useTran==true){
            m_conn.setAutoCommit(false);
          }
        }
        conn=m_conn;
      }

      /*

      Class.forName("com.sybase.jdbc2.jdbc.SybDriver");
      String url="jdbc:sybase:Tds:192.168.10.17:5000/loan_gz_dev";
      Connection conn =DriverManager.getConnection(url, "sa", "");

      */
     /*
     Class.forName("com.microsoft.jdbc.sqlserver.SQLServerDriver");
     String url="jdbc:microsoft:sqlserver://llh-mpc:1433;DatabaseName=loan_gz";
     Connection conn =DriverManager.getConnection(url, "sa", "54321");
     */
     return conn;
    }
    catch (SQLException se) {
      //LogTools.getInstance().error("the getConnect Exceptions:" + se.getMessage(),se);
      log.error("Unable to get connection ");
      log.error("Please make sure that the connection is exist.");
      throw se;
    }

  }

  /*
   * �ر����Ӷ���
   */
  private void closeConnection(Connection conn) throws Exception{
    try {
      //if(getConnByDriver==false){
        DataBaseDS.getInstance().disConnect(conn);
      //}
    }
    catch (Exception se) {
      log.error("SQL Exception while closing Connect : \n" + se.getMessage());

      throw new Exception(
          "SQL Exception while closing Connect : \n" + se.getMessage());
    }
  }
  /*
   * �رս����
   */

  private void closeResultSet(ResultSet result) throws Exception  {
    try {
      if (result != null) {
        result.close();
      }
    }
    catch (SQLException se) {
      log.error("SQL Exception while closing ResultSet : \n" + se.getMessage());
      throw new Exception(
          "SQL Exception while closing ResultSet : \n" + se.getMessage());
    }
  }

  /*
   * �ر�ִ��
   */
  private void closeStatement(Statement stmt) throws Exception{
    try {
      if (stmt != null) {
        stmt.close();
      }
    }
    catch (SQLException se) {
      log.error("SQL Exception while closing Statement : \n" + se.getMessage());
      throw new Exception(
          "SQL Exception while closing Statement : \n" + se.getMessage());
    }
  } 
	
  
  /**
   * ����������ֶν��н���
   * @param innerVariant
   * @return
   */
  private String[] columnParse(String innerVariant){
    String[] param=new String[3];
    String[] temp_param=null;
    temp_param=StringHelper.split("_", innerVariant);
    int length=temp_param.length;
    param[2]=temp_param[length-1];
    param[1]=temp_param[length-2];
    param[0]="";
    for(int i=0;i<length-2;i++){
      param[0]+=temp_param[i]+"_";
    }
    param[0]=param[0].substring(0,param[0].length()-1);
    return param;

  }
  private String fitEncodeToLocal(String instr){
    String systemEncoding=System.getProperty("file.encoding");
    if (Service.getInEncodeFlag().equalsIgnoreCase("1")) {
        if (systemEncoding.equals(Service.getInEncodeType())) {
          return instr;
        } else{
          //log.info("fitEncodeToLoc:"+instr);
          return StringHelper.parsetrun(instr,systemEncoding,Service.getInEncodeType());
        }
    }
    else
      return instr;
  }

  /**
   * ���������������String
   * @param is
   * @return
   * @throws java.lang.Exception
   */
  private String getStringByStream(InputStream is)throws Exception{
    String str="";
    if(is!=null){
      InputStreamReader isr = new InputStreamReader(is,Service.getInEncodeType());
      //System.out.println("....encode:"+isr.getEncoding());
      BufferedReader read = new BufferedReader(isr);
      str=  new String(read.readLine().getBytes(Service.getInEncodeType()));

    }

    return str;

  }

 
}
