package com.forms.login;



public class Menu implements java.io.Serializable {
  /**
	 * 
	 */
  private static final long serialVersionUID = 1L;
  private  String m_username =null;
  private  String m_userid =null;
  private  String m_menuname =null;
  private  String m_menupage =null;
  private  String m_menuupper =null;
  private  String m_menuid =null;
  private  String m_menulevel =null;
  private  String m_menunewwin =null;
  private  String m_menudemo =null;
  
  
  public Menu (){
  }
  public String getUserName(){
     return m_username;
  }
  public void setUserName(String p0){
	  m_username=p0;
  }
  public String getUserID(){
     return m_userid;
  }
  public void setUserID(String p0){
	  m_userid=p0;
  }
  public String getMenuName(){
     return m_menuname;
  }
  public void setMenuName(String p0){
	  m_menuname=p0;
  }
  
  public String getMenuPage(){
     return m_menupage;
  }
  public void setMenuPage(String p0){
	  m_menupage=p0;
  }
  public String getMenuUpper(){
     return m_menuupper;
  }
  public void setMenuUpper(String p0){
	  m_menuupper=p0;
  }
  public String getMenuID(){
	  return m_menuid;
  }
  public void setMenuID(String p0){
	  m_menuid=p0;
  } 
  public String getMenuLevel(){
	  return m_menulevel;
  }
  public void setMenuLevel(String p0){
	  m_menulevel=p0;
  } 
  public String getMenuDemo(){
	  return m_menudemo;
  }
  public void setMenuDemo(String p0){
	  m_menudemo=p0;
  }
  public String getMenuNewwin(){
	  return m_menunewwin;
  }
  public void setMenuNewwin(String p0){
	  m_menunewwin=p0;
  } 
}
