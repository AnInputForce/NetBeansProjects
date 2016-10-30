package com.actions.login;

import java.util.Vector;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.Action; 
import org.apache.struts.action.ActionForward; 
import org.apache.struts.action.ActionMapping; 
import org.apache.struts.action.ActionForm; 
import javax.servlet.http.*; 
import org.apache.struts.action.*; 
import com.forms.login.LoginForm;
import com.forms.login.UserRole;
import com.git.base.dbmanager.Manager;
import com.tools.*;


public class LoginAction extends Action{ 
	
	public ActionForward execute(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response)throws Exception
	{ 
		LoginForm form = (LoginForm)actionForm; 
		ActionErrors errors = new ActionErrors(); 
		String username = form.getUsername(); 
		String password = form.getPassword(); 		

		Manager m = Manager.getInstance();
		
		String sql= "select user_id,user_name,user_role,user_telephone, user_certtype, user_certcode from mon_user where user_id ='"+username+"' and user_passwd='"+MD5Util.MD5(password)+"'";
	
		Vector v_Login= m.execSQL(sql);

		UserRole[]  userRoles=null;
		
		if(v_Login!=null){
			
			userRoles=new UserRole[v_Login.size()];
			
            for(int i=0;i<v_Login.size();i++){
            	userRoles[i] = new UserRole();
	      	  	String[] arr = (String [])v_Login.elementAt(i);
	      	  	try {
                    //out.println(newBR.getRoleName()+"<br>");
		      	  	userRoles[i].setUserID(arr[0]);
		      	  	userRoles[i].setUserName(arr[1]);
		      	  	userRoles[i].setUserRole(arr[2]);
		      	  	userRoles[i].setUserTelephone(arr[3]);
		      	  	userRoles[i].setUserCertType(arr[4]);
		      	  	userRoles[i].setUserCertCode(arr[5]);
		      	  	break; 	  	
	          	}catch(NullPointerException ex){}
	          	
            }
         
            request.getSession().setAttribute("username", userRoles[0].getUserName());
            request.getSession().setAttribute("userid", userRoles[0].getUserID());
            request.getSession().setAttribute("role", userRoles[0].getUserRole());
    		
    		return actionMapping.findForward("success"); 
    		         
		}else
		{ 			
			errors.add("login",new ActionError("Login.failed")); 
			saveErrors(request,errors); 
			return actionMapping.findForward("failure"); 
		} /*
		if(username.equals("zwl") && password.equals("zwl"))
		{ 
			return actionMapping.findForward("success"); 
		}else
		{ 			
			errors.add("login",new ActionError("Login.failed")); 
			saveErrors(request,errors); 
			return actionMapping.findForward("failure"); 
		} */
	} 
} 
