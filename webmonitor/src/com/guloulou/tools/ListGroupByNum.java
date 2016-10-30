package com.guloulou.tools;

import java.util.ArrayList;
import java.util.List;

public class ListGroupByNum {
	public ListGroupByNum(){
		
	}
	public static ListGroupByNum getInstance(){
		return new ListGroupByNum();
	}
	 public List group(int k,List list)  //如果输入为List
	 {
	  ArrayList listofaftergroup=new ArrayList();
	  
	   for(int i=0;i<=list.size()-k;i++)
	   {
	    listofaftergroup.add(list.subList(i,i+k));
	    i=i+k-1;
	   }
	 
	  return listofaftergroup;
	 }


}
