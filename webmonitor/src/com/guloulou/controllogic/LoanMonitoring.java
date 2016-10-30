package com.guloulou.controllogic;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.guloulou.businesslogic.*;

import com.guloulou.bean.GroupServer;
import com.guloulou.bean.LoanServer;

import com.guloulou.tools.DBConnect;
import com.guloulou.tools.ListGroupByNum;
import com.guloulou.tools.ObjectAndXMLUtil;
import com.guloulou.tools.MyDateFormat;

public class LoanMonitoring {

	private LoanServer loanserver = LoanServer.getInstance();

	private List list = new ArrayList();

	GroupServer groupserver = GroupServer.getInstance();

	public LoanMonitoring() {
	}

	public static LoanMonitoring getInstance() throws FileNotFoundException,
			IOException, Exception {
		LoanMonitoring loanmonitoring = new LoanMonitoring();

		loanmonitoring.setList(ObjectAndXMLUtil
				.objectXmlDecoder("/resource/loanconfig.xml"));
		
		// 设置每组LoanServer数量。现状是1台weblogic加一台oracle
		// 如有需要，可设置oracle为n台；
		loanmonitoring.getGroupserver().setGroupnum(2);
		// loanmonitoring.groupserver.setList(ListGroupByNum.getInstance().group(loanmonitoring.groupserver.getGroupnum(),
		// loanmonitoring.getList()));
		List listgroup = new ArrayList();
		for (int i = 0; i < loanmonitoring.getList().size(); i++) {

			LoanServer loanserver = LoanServer.getInstance();
			loanserver = (LoanServer) loanmonitoring.getList().get(i);
			loanserver = loanmonitoring.returnSingleState((LoanState) (Class
					.forName(loanserver.getLoanstate()).newInstance()),
					loanserver);

			listgroup.add(loanserver);
		}

		loanmonitoring.groupserver.setList(ListGroupByNum.getInstance().group(
				loanmonitoring.groupserver.getGroupnum(), listgroup));

		return loanmonitoring;
	}

	public LoanServer returnSingleState(LoanState loanstate,
			LoanServer loanserver) {

		loanserver = loanstate.getState(loanserver);

		return loanserver;
	}

	public List returnLoanServerList() {
		List list = new ArrayList();

		for (int i = 0; i < this.groupserver.getList().size(); i++) {
			LoanServer loanserver = LoanServer.getInstance();
			loanserver = returnState((List) this.groupserver.getList().get(i));

			list.add(loanserver);
		}

		return list;

	}

	public LoanServer returnState(List list) {

		// LoanState oraclestate = OracleState.getInstance();
		// LoanState weblogicstate = WeblogicState.getInstance();
		// // LoanServer webpool = LoanServer.getInstance();
		//
		// // 初始化oracle67
		// LoanServer oracleserver1 = LoanServer.getInstance();
		// oracleserver1.setIpaddr("10.5.5.94");
		// oracleserver1.setPort(7001);
		// oracleserver1.setTestpage("check.jsp");
		// oracleserver1.setTestflag("CurrentNum67 = A");
		// // 初始化oracle68
		// LoanServer oracleserver2 = LoanServer.getInstance();
		// oracleserver2.setIpaddr("10.5.5.94");
		// oracleserver2.setPort(7001);
		// oracleserver2.setTestpage("check.jsp");
		// oracleserver2.setTestflag("CurrentNum68 = A");
		// // 初始化weblogic1
		// LoanServer weblogicserver = LoanServer.getInstance();
		// weblogicserver.setIpaddr("10.5.5.94");
		// weblogicserver.setPort(7001);
		// weblogicserver.setTestpage("check.jsp");
		//
		// // oracleserver1 = oraclestate.getState(oracleserver1);
		// // oracleserver2 = oraclestate.getState(oracleserver2);
		// // weblogicserver = weblogicstate.getState(weblogicserver);
		//
		// oracleserver1 = this.returnSingleState(oraclestate, oracleserver1);
		// oracleserver2 = this.returnSingleState(oraclestate, oracleserver2);
		// weblogicserver = this.returnSingleState(weblogicstate,
		// weblogicserver);
		//
		// // System.out.println("1:" + oracleserver1.getDemo());
		// // System.out.println("2:" + oracleserver2.getDemo());
		// // System.out.println("3:" + weblogicserver.getDemo());
		//
		// // 初始化loanserver
		// this.setLoanserver(weblogicserver);

		int statustmp = 1;
		StringBuffer demotmp = new StringBuffer();
		LoanServer loanserver = LoanServer.getInstance();

		for (int i = 0; i < list.size(); i++) {
			statustmp = statustmp * ((LoanServer) (list.get(i))).getStatus();
			// demotmp = demotmp.append(((LoanServer) (list.get(i))).getDemo());
		}
		
		if (statustmp == 1) {
			loanserver.setStatus(1);
			demotmp = demotmp.append("运行正常") ;
		}
		if (statustmp == 3) {
			loanserver.setStatus(3);
			demotmp = demotmp.append("weblogic不能访问oracle数据库");
		} 
		if (statustmp > 3){
			loanserver.setStatus(3);
			demotmp = demotmp.append("weblogic不能正常登陆");
		}
		
		loanserver.setIpaddr(((LoanServer) (list.get(0))).getIpaddr());
		loanserver.setLoanstate(((LoanServer) (list.get(0))).getLoanstate());
		loanserver.setPort(((LoanServer) (list.get(0))).getPort());
		loanserver.setTestflag(((LoanServer) (list.get(0))).getTestflag());
		loanserver.setTestpage(((LoanServer) (list.get(0))).getTestpage());
		loanserver.setDemo(demotmp.toString());
		
		return loanserver;

	}

	public LoanServer getLoanserver() {
		return loanserver;
	}

	public void setLoanserver(LoanServer loanserver) {
		this.loanserver = loanserver;
	}
	
	public void checkLoanServerState() throws FileNotFoundException, IOException, Exception{
		LoanMonitoring loanmonitoring = LoanMonitoring.getInstance();

		List list = loanmonitoring.returnLoanServerList();

		// for (int i = 0; i < list.size(); i++) {
		// System.out.println(((LoanServer)list.get(i)).getDemo());
		// }

		// 插入数据库

		String drvierName = "com.mysql.jdbc.Driver";
		String databaseURL = "jdbc:mysql://10.229.43.5/monitor";
		String user = "monitor";
		String pwd = "monitor";

		// StringBuffer sql2 = new StringBuffer();
		DBConnect dbconn = new DBConnect(drvierName, databaseURL, user, pwd);
		dbconn.getConnection();

		for (int i = 0; i < list.size(); i++) {
			StringBuffer sql = new StringBuffer();
			sql = sql.append("");

			sql = sql.append("replace into WebPool (ipaddr,status,port,demo,systime) values('");
			sql = sql.append(((LoanServer)list.get(i)).getIpaddr());
			sql = sql.append("'," + ((LoanServer)list.get(i)).getStatus());
			sql = sql.append("," + ((LoanServer)list.get(i)).getPort());
			sql = sql.append(",'" + ((LoanServer)list.get(i)).getDemo());
			sql = sql.append("','" + MyDateFormat.getInstance().getNowSimpledate() + "')");
			// sql2 = sql2.append("delete from WebPool where
			// ipaddr='10.5.5.94'");
			System.out.println(sql.toString());
			dbconn.getPreparedStatement(sql.toString());
			dbconn.executeInsert();
			// dbconn.executeDelete();
		}

		dbconn.closeResultSet();
		dbconn.closePreStatement();
		dbconn.closeConnection();

	}
	
	public static void main(String[] args) throws FileNotFoundException,
			IOException, Exception {
		System.out.println("new LoanMonitoring().checkLoanServerState() is running,please wite");
		new LoanMonitoring().checkLoanServerState();

		// LoanMonitoring loanmonitoring = LoanMonitoring.getInstance();
		// loanmonitoring.returnState();
		// System.out.println("9：demo = "
		// + loanmonitoring.getLoanserver().getDemo());
		// System.out.println("10：status = "
		// + loanmonitoring.getLoanserver().getStatus());
		// System.out.println("11：others = "
		// + loanmonitoring.getLoanserver().getIpaddr() + "|||"
		// + loanmonitoring.getLoanserver().getPort());
		//
		// String drvierName = "com.mysql.jdbc.Driver";
		// String databaseURL = "jdbc:mysql://10.5.5.217/monitor";
		// String user = "monitor";
		// String pwd = "ycbsyh";
		//
		// StringBuffer sql = new StringBuffer();
		// //StringBuffer sql2 = new StringBuffer();
		// DBConnect dbconn = new DBConnect(drvierName, databaseURL, user, pwd);
		// dbconn.getConnection();
		//
		// sql = sql.append("replace into WebPool (ipaddr,status,port,demo)
		// values('");
		// sql = sql.append(loanmonitoring.getLoanserver().getIpaddr());
		// sql = sql.append("'," + loanmonitoring.getLoanserver().getStatus());
		// sql = sql.append("," + loanmonitoring.getLoanserver().getPort());
		// sql = sql
		// .append(",'" + loanmonitoring.getLoanserver().getDemo() + "')");
		// // sql2 = sql2.append("delete from WebPool where
		// ipaddr='10.5.5.94'");
		// System.out.println(sql.toString());
		// dbconn.getPreparedStatement(sql.toString());
		// dbconn.executeInsert();
		// // dbconn.executeDelete();
		//
		// dbconn.closeResultSet();
		// dbconn.closePreStatement();
		// dbconn.closeConnection();

	}

	public List getList() {
		return list;
	}

	public void setList(List list) {
		this.list = list;
	}

	public GroupServer getGroupserver() {
		return groupserver;
	}

	public void setGroupserver(GroupServer groupserver) {
		this.groupserver = groupserver;
	}

}
