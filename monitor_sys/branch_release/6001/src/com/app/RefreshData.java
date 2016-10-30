package com.app;


public class RefreshData {

	public final static int refreshData(String s){ 
		
			try { 
				Process p=Runtime.getRuntime().exec(s);
				p.waitFor();
				int exitValue=p.exitValue();
				
				return exitValue ;
			} 
			catch (Exception e){ 
				return 0; 
			} 
		}
	
	}
