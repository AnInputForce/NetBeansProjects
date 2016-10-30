package com.guloulou.businesslogic;

import com.guloulou.bean.LoanServer;
import com.guloulou.tools.HtmlDealwith;

public class OracleState implements LoanState {

	public OracleState() {
	}

	public static OracleState getInstance() {
		return new OracleState();
	}

	public LoanServer getState(LoanServer loanserver) {
		//loanserver.setStatus(1);
		String htmltmp = "";
		htmltmp = HtmlDealwith.getInstance(
				"http://" + loanserver.getIpaddr() + ":" + loanserver.getPort()
						+ "/" + loanserver.getTestpage()).getHtml();
		
		// System.out.println("htmltmp:" + htmltmp);
		
		/*
		 * 给出数据库标志		 
		 
		if (!(htmltmp==null) && (htmltmp.indexOf(loanserver.getTestflag()) > 0)) {
			loanserver.setStatus(1);
			loanserver.setDemo("访问标识为\"" + loanserver.getTestflag() + "\"的Oracle服务器"
					+ "运行正常；");
		} else {
			loanserver.setStatus(3);
			loanserver.setDemo("访问标识为\"" + loanserver.getTestflag() + "\"的Oracle服务器"
					+ "运行异常；");
		}
		*/
		// 不给出数据库标志
		
		if (!(htmltmp==null) && (htmltmp.indexOf(loanserver.getTestflag()) > 0)) {
			loanserver.setStatus(1);
			loanserver.setDemo("运行正常"); // 数据库正常，weblogic正常，仅返回数据库的"运行正常"即可； 
		} else {
			loanserver.setStatus(3);
			loanserver.setDemo("weblogic不能访问oracle数据库");
		}
		

		return loanserver;

	}

	public static void main(String[] args) {

		LoanServer oracleserver1 = LoanServer.getInstance();
		oracleserver1.setIpaddr("10.5.5.94");
		oracleserver1.setPort(7001);
		oracleserver1.setTestpage("check.jsp");
		oracleserver1.setTestflag("CurrentNum68 = A");

		System.out.println(OracleState.getInstance().getState(oracleserver1)
				.getDemo());
	}
}
