package com.git.base.common;

import java.io.*;
import java.util.*;
import com.git.base.cfg.Service;
//import java.io.FileDescriptor;
public class LogReader {
  private int rowop=0;
  public LogReader(){
  }
  public int getRowOP(){
    return rowop;
  }
  public Vector readLog(String fileName,int TracertRowNum) throws Exception{
    try{
      int m_TracertRowNum;
      if (TracertRowNum>0) {
        m_TracertRowNum=TracertRowNum;
      }
      else {
        m_TracertRowNum=Service.getTracertRowNum();
      }
      Vector fileVector = new Vector();
      for(int i=1;i<=m_TracertRowNum;i++){
        fileVector.add("");
      }
      //System.out.println(fileName);
      File f=new File(fileName);

      FileReader fr=new FileReader(f);
      BufferedReader file = new BufferedReader(fr);
      String fileLine="";
      while((fileLine = file.readLine())!=null){
        //fileVector.add(fileLine);
//        System.out.println(rowop);

        fileVector.set(rowop,new String(fileLine));
        rowop++;
        if (rowop==m_TracertRowNum) rowop=0;
      }
      return fileVector;
    }
    catch(Exception ex){
      throw ex;
    }
  }
  public Vector readLog() throws Exception{
    return(readLog(Service.getTracertLogFile(),0));
  }
  public Vector readLog(int TracertRowNum) throws Exception{
    return(readLog(Service.getTracertLogFile(),TracertRowNum));
  }
  public String getLogFileName() {
    return Service.getTracertLogFile();
  }

  public static void main(String[] args) {
    try{
      LogReader logReader1 = new LogReader();
      //logReader1.readLog("H:/bea/wlserver6.1/config/mydomain/logs/weblogic.log");
      Vector v1=logReader1.readLog("H:/bea/wlserver6.1/myserver.log",0);
      for(int i=logReader1.getRowOP();i<Service.getTracertRowNum();i++){
        System.out.println(v1.get(i).toString());
      }
      for(int i=0;i<logReader1.getRowOP();i++){
        System.out.println(v1.get(i).toString());
      }

      //logReader1.readLog("H:/bea/wlserver6.1/project_test/callexefile_1226/log/abcd.log");

       //H:/bea/wlserver6.1/myserver.log;
     }
    catch(Exception ex){
      ex.printStackTrace();
    }
  }
}
