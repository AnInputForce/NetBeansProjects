package com.forms.login;

public class UserRole implements java.io.Serializable {
  /**
	 * 
	 */
  private static final long serialVersionUID = 1L;
  private  String m_username =null;
  private  String m_userid =null;
  private  String m_userrole =null;
  private  String m_usertelephone =null;
  private  String m_usercerttype =null;
  private  String m_usercertcode =null;
  
  public UserRole (){
  }
  public String getUserName(){
     return m_username;
  }
  public void setUserName(String p0){
	  m_username=p0;
  }
  public String getUserRole(){
     return m_userrole;
  }
  public void setUserRole(String p0){
	  m_userrole=p0;
  }
  public String getUserID(){
     return m_userid;
  }
  public void setUserID(String p0){
	  m_userid=p0;
  }
  public String getUserTelephone(){
     return m_usertelephone;
  }
  public void setUserTelephone(String p0){
	  m_usertelephone=p0;
  }
  public String getUserCertType(){
     return m_usercerttype;
  }
  public void setUserCertType(String p0){
	  m_usercerttype=p0;
  }
  public String getUserCertCode(){
	  return m_usercertcode;
  }
  public void setUserCertCode(String p0){
	  m_usercertcode=p0;
  }  
}
