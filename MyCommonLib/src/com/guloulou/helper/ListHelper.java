package com.guloulou.helper;

import java.util.ArrayList;
import java.util.List;

public class ListHelper {
	public ListHelper(){

	}
	public static ListHelper getInstance(){
		return new ListHelper();
	}
	/*
     * 将list以k为一组分割
     */
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
