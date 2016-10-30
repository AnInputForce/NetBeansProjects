package com.BigBall;

import java.io.IOException;

import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.git.base.cfg.*;
import com.app.ProvProc;
import com.git.base.dbmanager.Manager;

public class AppBallServlet extends HttpServlet {
	boolean bSound=false;
    String sqlstr=null,sProvName=null,sSysid=null;
    String sCurStatus,sCurRetry,sMaxRetry;
    Manager m = null;
    ProvProc[] provs = null;
    int iCount = 0;
    int iCurIdx = 0;
    
    public int getCount(){	
        m = Manager.getInstance();
	    sqlstr= "select sysid,sysname,xpos,ypos from bat_provname order by sysid";	
	
	    iCount = 0;
	    iCurIdx = 0;
	    try {
	    	Vector v_Prov= m.execSQL(sqlstr);
	    	if(v_Prov!=null){

			    provs = new ProvProc[v_Prov.size()];
			
	            for(int i=0;i<v_Prov.size();i++)
	            {
		           	provs[i] = new ProvProc();
		      	  	String[] arr = (String [])v_Prov.elementAt(i);
		      	  	try {
		      	  
		   	      	  	provs[i].setProvID(arr[0]);
			      	  	provs[i].setProvName(arr[1]);
			      	  	provs[i].setXPos(Integer.parseInt(arr[2]));
			      	  	provs[i].setYPos(Integer.parseInt(arr[3]));
			      	 
		          	}catch(NullPointerException ex){
		          		ex.printStackTrace();
		          	}	          	
	           }
	        }
	        
	        iCount = v_Prov.size();
	    }
	    catch(Exception e){
	    	e.printStackTrace();
	    }
	    
	    return iCount;
    }
    
    public int getCurXPos(){    	
        return provs[iCurIdx].getXPos();
    }
    
    public int getCurYPos(){
        return provs[iCurIdx].getYPos();
    }
    
    public String getCurName(){
        return provs[iCurIdx].getProvName();
    }
    
    public String getCurId(){
        return provs[iCurIdx].getProvID();
    }
    
    public String getCurColor(){
        boolean bOrange=false;
		boolean bRed=false;
		boolean bExist=false;
		String sColorBall="g.gif";
		bSound=false;
		
		String sProvID = provs[iCurIdx].getProvID();
	 				     		
		sqlstr= "select t.sysid,p.sysname,t.status,t.curretrytimes,t.maxretrytimes " +
				"from bat_taskproc t, bat_provname p " +
				"where t.sysid = p.sysid and t.sysid = '" + sProvID + "'";
	
		try {
			Vector v_ProvProc= m.execSQL(sqlstr);
			
		 	ProvProc[]  provprocs=null;
		
			if(v_ProvProc!=null)
			{	
				provprocs = new ProvProc[v_ProvProc.size()];
				bExist=true;
				for(int  n=0;n<v_ProvProc.size();n++)
				{
					provprocs[n] = new ProvProc();
					String[] arr = (String [])v_ProvProc.elementAt(n);
					try {
						provprocs[n].setProvID(arr[0]);
						provprocs[n].setProvName(arr[1]);
						provprocs[n].setProvStatus(arr[2]);
						provprocs[n].setProvCurTimes(arr[3]);
						provprocs[n].setProvMaxTimes(arr[4]);
						sCurStatus=provprocs[n].getProvStatus();
						sCurRetry=provprocs[n].getProvCurTimes();
						sMaxRetry=provprocs[n].getProvMaxTimes();
	     
						if(sCurRetry.trim().equals(sMaxRetry.trim())&&!sCurRetry.trim().equals("0")&&!sCurStatus.trim().equals("-1") && !sCurStatus.trim().equals("0"))
						{
							bRed=true;
						}else if(!sCurRetry.trim().equals("0")&&!sCurStatus.trim().equals("-1") && !sCurStatus.trim().equals("0"))
						{
							bOrange=true;
						}			      
					}catch(NullPointerException ex)
					{
						ex.printStackTrace();	
					}
				}
			}
		    if(bExist){
		    		 	    
			    if(bRed){
			    	sColorBall="r.gif";
			    	bSound=true;
			    }else if(bOrange){
			    	bSound=true;
			    	sColorBall="o.gif";
			    }else 
			    	sColorBall="g.gif";
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally
		{		
		}
			
		return sColorBall;
    }
    
    public boolean getSoundFlag(){
        return bSound;
    }
    
    public int next(){
    	
    	if ( iCurIdx+1 == iCount ){
    		return -1;
    	}else
    		return iCurIdx++;
    }
    
	/**
	 * Constructor of the object.
	 */
	public AppBallServlet() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	/**
	 * The doGet method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String strHTML="";

		response.setContentType("text/html;charset=gb2312");
		
		int cnt = getCount();
		
		for (int i=0; i<cnt; i++)
		{
	    	strHTML += "<div style='position:absolute;width=1;height=1;left:"
	    		+getCurXPos()+";top:"+getCurYPos()+";visibility:visible;cursor:hand;' "
	    		+"onclick=\"javscript:parent.location.href='TaskDetail.jsp?sysid="
	    		+getCurId()+"';\"><table width='16' cellspacing='0' cellpadding='0'>"
	    		+"<tr><td style='font:12' ><img src="+getCurColor()+" width='22' height='22'></td></tr></table></div>";
	    	
	    	//System.out.print("i=["+i+"]ʡ��=["+getCurId()+"]��ɫ=["+getCurColor()+"]");
	    	//System.out.println("next=["+next()+"]");
	    	next();
	    }   
		
		if(getSoundFlag())
		{
			strHTML +=
			"<bgsound src="+Service.getSoundFile()+" loop="+Service.getSoundTimes()+">";
		}
		
		response.getWriter().write(strHTML);
	}

	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doPost(request, response);
	}

	/**
	 * Initialization of the servlet. <br>
	 *
	 * @throws ServletException if an error occure
	 */
	public void init() throws ServletException {
		// Put your code here
	}

}
