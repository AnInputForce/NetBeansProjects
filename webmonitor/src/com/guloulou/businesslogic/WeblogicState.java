package com.guloulou.businesslogic;

import com.guloulou.bean.LoanServer; 
import com.guloulou.tools.UrlAvailability;

public class WeblogicState implements LoanState {

    public WeblogicState () {
    }
    public static WeblogicState getInstance(){
        return new WeblogicState();
    }
    public LoanServer getState (LoanServer loanserver) {
        
    	
    	if (UrlAvailability.getInstance().isConnect("http://" + loanserver.getIpaddr() + ":" + loanserver.getPort()
						+ "/" + loanserver.getTestpage())) {
			loanserver.setStatus(1);
			loanserver.setDemo("运行正常"); // 数据库正常，weblogic正常，仅返回数据库的"运行正常"即可；
		} else {
			loanserver.setStatus(3);
			loanserver.setDemo("weblogic不能正常登陆");
		}
    	
        return loanserver;
    }
    public static void main(String [] args){
        
    	LoanServer weblogicserver1 = LoanServer.getInstance();
    	weblogicserver1.setIpaddr("10.5.5.94");
    	weblogicserver1.setPort(7001);
    	weblogicserver1.setTestpage("check.jsp");
    	weblogicserver1.setTestflag("CurrentNum68 = A");

		System.out.println(WeblogicState.getInstance().getState(weblogicserver1).getDemo());
    	
    }

}

