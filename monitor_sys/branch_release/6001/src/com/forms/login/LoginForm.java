package com.forms.login;

import javax.servlet.http.*; 
import org.apache.struts.action.*; 


public class LoginForm  extends ActionForm{ 
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String username; 
	private String password; 
	public LoginForm() { 
		username = null; 
		password = null; 
	} 
	
	public void setUsername(String username){ 
		this.username = username; 
	} 
	public String getUsername() { 
		return this.username; 
	} 
	public void setPassword(String password){ 
		this.password = password; 
	} 
	public String getPassword(){ 
		return this.password; 
	} 
	public void reset(ActionMapping mapping, HttpServletRequest request) 
	{ 
		username = null; 
		password = null; 
	} 
	
    	
} 
