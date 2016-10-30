package com.git.jsf.print;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.jasperreports.engine.JRException;

/**
 * 类似TdController,不过是一种通用的控制器
 * 通过解析报文生成不同格式的报表预览
 * @author Admin
 */
public class ReportPrintController extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = -4309050903325789938L;
	/**
	 * 套打报表实现控制器
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
         this.doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//System.out.println(request.getSession().getAttribute("list"));
		
		try {
			List list = (List)request.getSession().getAttribute("list");
			
			
			String jrxmlName = new String((String)request.getSession().getAttribute("jrxmlName"));
			//构造报表对象
			
			IReportPrintImpl print=new IReportPrintImpl(this.getServletContext(),response);
			
			System.out.println(jrxmlName);
			print.setReport(jrxmlName);//jrxml

			//------------------------------
			print.setJRDataSource(list);
			//输出报表,报表预览
			
			print.viewAppletReport();
			
			//clear
			request.getSession().removeAttribute("list");
			request.getSession().removeAttribute("jrxmlName");
		} catch (Exception e) {
			e.printStackTrace();
		}
	 }
	
//	public void setParams(IReportPrintImpl print,Map params)
//	{
//		Iterator it = params.keySet().iterator();
//		String key,value;
//		while(it.hasNext())
//		{
//			key = (String)it.next();
//			value = (String)params.get(key);
//			print.set
//		}
//	}
	
}
