package com.app;


public class ProvProc  implements java.io.Serializable {
	  /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private  String m_provname =null;
	  private  String m_provid =null;
	  private  String m_provstatus =null;
	  private  String m_provcurtimes =null;
	  private  String m_provmaxtimes =null;
	  private  int m_xpos = 0;
	  private  int m_ypos = 0;
    
	  public ProvProc (){
	  }
	  public String getProvName(){
	     return m_provname;
	  }
	  public void setProvName(String p0){
		  m_provname=p0;
	  }
	  public String getProvID(){
	     return m_provid;
	  }
	  public void setProvID(String p0){
		  m_provid=p0;
	  }
	  public String getProvStatus(){
	     return m_provstatus;
	  }
	  public void setProvStatus(String p0){
		  m_provstatus=p0;
	  } 
	  public String getProvCurTimes(){
		     return m_provcurtimes;
	  }
	  public void setProvCurTimes(String p0){
		  m_provcurtimes=p0;
	  } 
	  public String getProvMaxTimes(){
		     return m_provmaxtimes;
	  }
	  public void setProvMaxTimes(String p0){
		  m_provmaxtimes=p0;
	  }
	  public int getXPos(){
		     return m_xpos;
	  }
	  public void setXPos(int p0){
		  m_xpos=p0;
	  }
	  public int getYPos(){
		     return m_ypos;
	  }
	  public void setYPos(int p0){
		  m_ypos=p0;
	  }
}
	

