package com.git.base.dbmanager;


import java.sql.*;
import java.util.ArrayList;
import org.apache.log4j.Logger;
import org.apache.log4j.LogManager;
import com.git.base.dbmanager.DBRowSet;
import javax.sql.*;
import com.git.base.cfg.Service;
import javax.transaction.UserTransaction;
//import org.apache.log4j.Logger;

public class MyManager {
			
    private static DataSource ds;
    private String dataSourceName = "";
    private static final int OtherType=-1;
    private static final int IntegerType=0;
    private static final int DateTimeType=1;
    private static final int DoubleType=2;
    private static final int TextType=9;
    private static final int StringType=10;
    private boolean useTran=false;
    private static String dbuser="";
    private boolean getConnByDriver=false;   
    private static String dbpassword="";
    private static Connection m_conn=null;
    private UserTransaction trans=null;
 
  
	Connection connect = null;
	
	private  final Logger log = LogManager.getLogger(this.getClass());
	
	ResultSet rs = null;
	
	boolean  bTomcat = true;

	
	/*private String driverName = "org.gjt.mm.mysql.Driver";// ������������

	
	private String url = "jdbc:mysql://10.5.1.54/monitor";// �������ݿ����Ӵ�

	private String user = "monitor";// ���ݿ��¼�û���

	private String password = "ycbsyh";// ���ݿ��¼����
	
	static int maxCursor=0;

*/
	// ���ù��췽�����������ݿ������
	// //����DataSource�ӿ�dataSource�ɻ�����ݿ��Connection����

	private static MyManager db = null;

	public static MyManager getInstance() {
		
		if (db == null) {
			db = new MyManager();
		}		
		return db;
	}
	
	private MyManager() {
		/*log.error("new getInstance");
		try {
			Class.forName(driverName);
			connect = DriverManager.getConnection(url, user, password);			
	
		} catch (Exception e) {
			log.info(e.toString());
			System.out.println("DB");
			e.printStackTrace();
		}*/
	}

	// �������ݿ�
	public int ModifySql(String sql) throws SQLException, Exception {
		int result = 0;	
		Connection conn =null;
		Statement stmt =null;
		try {
			conn = this.getConnect();
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);// ����Ҫcommit,�����ֱ���ύ�����ݿ���
		
		} catch (SQLException ex) {

			System.out.println("ExecSql");
			System.err.println(ex.getMessage());

		}finally {		     
		      closeStatement(stmt);
		      closeConnection(conn);
		      return result;
		}
		
	}
	public Connection getConnect() throws SQLException, Exception {
	    try {
	      Connection conn =null;
	      String ds = Service.getMySqlDataSource(); //�������ļ���ȡ����Դ����
	 
	      if (dataSourceName.equals("")) { //
	         DataBaseDS.getInstance().setSybDataBase(ds);
	      }
	      else {
	         DataBaseDS.getInstance().setSybDataBase(dataSourceName); //��ͨ��setDataSource()���������趨��
	      }
	      conn = DataBaseDS.getInstance().getConnection();

	      return conn;
	    }
	    catch (SQLException se) {
	      //LogTools.getInstance().error("the getConnect Exceptions:" + se.getMessage(),se);
	      log.error("Unable to get connection ");
	      log.error("Please make sure that the connection is exist.");
	      throw se;
	    }

	  }
	
	/**
	 * 
	 * @param sql
	 * @return
	 * @throws Exception 
	 */
	public String selFirstCol(String sql) throws Exception {
			
		Statement stmt = null;
		ResultSet rs = null;
		Connection conn =null;
		try {
		
			conn = this.getConnect();
			stmt = conn.createStatement();
//			System.out.println(sql);
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
	
	public DBRowSet selectSql(String sql) throws Exception {
		
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
 	public static void closeResultSet(ResultSet rs) {
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public static void closePreparedStatement(PreparedStatement ps) {
        if (ps != null) {
            try {
                ps.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public static void closeConnection(Connection con) {
        if (con != null) {
            try {
                con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
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
    
    
}




