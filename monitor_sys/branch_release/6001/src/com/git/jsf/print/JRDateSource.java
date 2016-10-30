package com.git.jsf.print;

import net.sf.jasperreports.engine.JREmptyDataSource;
import net.sf.jasperreports.engine.JRField;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

/**
 * JasperReport报表的数据源
 */
public class JRDateSource extends JREmptyDataSource{
	  /**
	   *
	   */
	  private List data = null;
	  private Iterator iterator = null;
	  private Object currentBean = null;
	  private int filterStart = 0;
	  
	  /**
	   * 构造函数
	   *
	   * @param beanList
	   */
	  public JRDateSource(List beanList) {
	    this.data = beanList;
	    if (this.data != null) {
	      this.iterator = this.data.iterator();
	    }
	  }

	  /**
	   * 构造函数
	   *
	   * @param object
	   */
	  public JRDateSource(Object object) {
	    List list = null;
	    if (object != null) {
	      list = new ArrayList();
	      list.add(object);
	    }
	    this.data = list;
	    if (this.data != null) {
	      this.iterator = this.data.iterator();
	    }
	  }

	  /**
	   * 构造函数
	   */
	  public JRDateSource() {
	    super();
	  }

	  /**
	   * 构造函数
	   *
	   * @param count
	   */
	  public JRDateSource(int count) {
	    super(count);
	  }
	  /**
	   * 判断是否有下一条记录
	   */
	  public boolean next() {
	    if (this.data == null) return super.next();
	    boolean hasNext = false;
	    if (this.iterator != null) {
	      hasNext = this.iterator.hasNext();
	      if (hasNext) {
	        this.currentBean = this.iterator.next();
	      }
	    }
	    return hasNext;
	  }

	  /**
	   * 获得字段的值
	   *
	   * @param field
	   */
	  public Object getFieldValue(JRField field) {
	    if (this.data == null) return super.getFieldValue(field);
	    Object value = null;
	    if (currentBean != null) {
	      String propertyName = field.getName();
	      if (currentBean instanceof Map) {
	        Map map = (Map) currentBean;
	        value = map.get(propertyName);
	      }
	      else {
	    	  /*
	    	   BeanWrapper beanWrapper = new BeanWrapperImpl(currentBean);
	    	   value = beanWrapper.getPropertyValue(propertyName);
	    	   */
	    	  try {
	    		  value = this.getPropertyValue(currentBean,propertyName);
	    	  } catch (Exception e) {
	    		  e.printStackTrace();
	    	  }
	    	  
	      }
	    }
	    return value;
	  }
	  

	  /**
	   * 只支持getXX方法获得属性值
	   */
	  public Object getPropertyValue(Object bean,String propertyName)  throws Exception
	  {
//		  Class classBean = bean.getClass();
//		  Method[] m = classBean.getDeclaredMethods();
//		  Object value = null ;
//		  for (int i = 0; i < m.length; i++) {
//			  Method method = m[i];
//			  
//			  //参数个数
//			  int n = method.getGenericParameterTypes().length;
//			  
//			  String mehtodName = "get"+firstCharUpperCase(propertyName);
//			  
//			  if(method.getName().equals(mehtodName))
//			  {
//				  value = method.invoke(bean,null);
//				  
//				  return value;
//			  }
//		  }
		  //throw new Exception("无法获得属性"+propertyName+"的值!");
		  return "无法获得此数据";
	  }
	  
	  
	  /**
	   * 将字符串的首字母转为大写
	   */		
	  public String firstCharUpperCase(String str){
		  String preStr = str.substring(0,1).toUpperCase();
		  String subStr = str.substring(1,str.length());
		  return preStr+subStr;
	  }	  
	  


	  /**
	   * 移动到第一条
	   */
	  public void moveFirst() {
	    if (this.data != null) {
	      this.iterator = this.data.iterator();
	    }
	    else {
	      super.moveFirst();
	    }
	  }

	  /**
	   * 记录集过滤，只支持一个外键
	   *
	   * @param fieldName
	   * @param value
	   * @return IBatisListDataSource
	   */
	  public JRDateSource filter(String fieldName, Object value) {
	    if (value == null) return new JRDateSource();
	    List dateList = new ArrayList();
	    Object objectValue = null;
	    Object object;
//	    BeanWrapper beanWrapper;
	    boolean start = false;
	    if (this.data != null && this.data.size() > 0) {
	      for (int i = filterStart; i < data.size(); i++) {
	        object = data.get(i);
	        if (object != null) {
	          if (object instanceof Map) {
	            Map map = (Map) object;
	            objectValue = map.get(fieldName);
	          }
	          else {
	        	  
		    	  /*
		    	   BeanWrapper beanWrapper = new BeanWrapperImpl(currentBean);
		    	   value = beanWrapper.getPropertyValue(propertyName);
		    	   */
		    	  try {
		    		  value = this.getPropertyValue(currentBean,fieldName);
		    	  } catch (Exception e) {
		    		  e.printStackTrace();
		    	  }
	            }
	        }

	        if (objectValue != null) {
	          if (objectValue.equals(value)) {
	            dateList.add(object);
	            start = true;
	          }
	          else {
	            if (start) {
	              filterStart = i;
	              break;
	            }
	          }
	        }
	      }
	      return (dateList.size() > 0) ? new JRDateSource(dateList) : new JRDateSource();
	    }
	    else {
	      return new JRDateSource();
	    }
	  }


}
