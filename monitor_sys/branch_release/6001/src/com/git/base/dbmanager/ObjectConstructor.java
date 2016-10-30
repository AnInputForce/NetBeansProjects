package com.git.base.dbmanager;

import java.lang.reflect.*;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2004</p>
 * <p>Company: </p>
 * @author not attributable
 * @version 1.0
 */

public class ObjectConstructor {
  private String tablename;
  private Field[] fields;
  public ObjectConstructor() {
  }
//  public static synchronized ObjectConstructor getInstance(){
//    return new ObjectConstructor();
//  }
  public void setTableName(String tablen){
    this.tablename=tablen;
    //System.out.println("tableName2:" + tablename);
  }
  public String getTableName(){
    return this.tablename;
  }
  public void setFields(Field[] fields){
    this.fields=fields;
  }
  public Field[] getFields(){
    return this.fields;
  }
}