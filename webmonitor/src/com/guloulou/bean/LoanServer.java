package com.guloulou.bean;

import java.io.Serializable;


public class LoanServer  implements Serializable {

/**
 * 注：status字段正常为1，异常情况为3
 *     当status为1时，demo为：运行正常
 *     当status为3时，demo为：weblogic不能正常登陆或weblogic不能访问oracle数据库
 */
    private String ipaddr = "127.0.0.1";    
    private int port = 7001;
    private int status = 1 ;
    private String testpage = "check.jsp";
    private String testflag = "CurrentNum67 = A";
    private String demo = "运行正常";
    private String loanstate = "WeblogicState";
    //private static final long serialVersionUID = 423423421L;
    

    public LoanServer () {
    }
    public static LoanServer getInstance(){
        return new LoanServer();
    }
	public String getDemo() {
		return demo;
	}
	public void setDemo(String demo) {
		this.demo = demo;
	}
	public String getIpaddr() {
		return ipaddr;
	}
	public void setIpaddr(String ipaddr) {
		this.ipaddr = ipaddr;
	}
	public int getPort() {
		return port;
	}
	public void setPort(int port) {
		this.port = port;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getTestpage() {
		return testpage;
	}
	public void setTestpage(String testpage) {
		this.testpage = testpage;
	}
	public String getTestflag() {
		return testflag;
	}
	public void setTestflag(String testflag) {
		this.testflag = testflag;
	}
	public String getLoanstate() {
		return loanstate;
	}
	public void setLoanstate(String loanstate) {
		this.loanstate = loanstate;
	}
	

    
}

