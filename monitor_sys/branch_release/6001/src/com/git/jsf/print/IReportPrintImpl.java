package com.git.jsf.print;

import com.lowagie.text.pdf.PdfWriter;
import net.sf.jasperreports.engine.*;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.engine.export.JRPdfExporterParameter;
import net.sf.jasperreports.engine.export.JRXlsExporter;
import net.sf.jasperreports.engine.export.JRXlsExporterParameter;
import net.sf.jasperreports.engine.util.JRLoader;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * �����ӡ��ʵ��
 * User: JiangMian
 * Date: 2005-9-26
 * Time: 17:27:27
 * To change this template use File | Settings | File Templates.
 */
public class IReportPrintImpl implements IReportPrint {
  public static String reportPath ="/ireport";//=  "/WEB-INF/report"; //���������ļ�Ŀ¼
  public static boolean complie =true;//= false; //���������
  private ServletContext application;  //������
  private HttpServletResponse response;  //��Ӧ
  private String reportName;  //��������
  private Map parameter = new HashMap();//�������
  private JRDataSource jRDataSource = new JRDateSource();//��������Դ
  private String description;

  /**
   * ���������ļ����ļ���
   *
   * @param description
   */
  public void setDescription(String description) {
    this.description = description;
  }

  /**
   * ���������������Դ
   *
   * @param list
   */
  public void setJRDataSource(List list) {
    this.jRDataSource = new JRDateSource(list);
  }

  /**
   * ���������������Դ
   *
   * @param object
   */
  public void setJRDataSource(Object object) {
    this.jRDataSource = new JRDateSource(object);
  }

  /**
   * �����ӱ��������Դ
   *
   * @param parameterName
   * @param list
   */
  public void setSubJRDataSource(String parameterName, List list) {
    this.parameter.put(parameterName, new JRDateSource(list));
  }

  /**
   * �����ӱ��������Դ
   *
   * @param parameterName
   * @param object
   */
  public void setSubJRDataSource(String parameterName, Object object) {
    this.parameter.put(parameterName, new JRDateSource(object));
  }

  /**
   * ������������
   *
   * @param reportName
   * @throws FileNotFoundException
   */
  public void setReport(String reportName) throws FileNotFoundException {
    if (complie) {
      if (!existFile(reportName, "jrxml"))
        throw new FileNotFoundException("File " + reportName + ".jrxml not found.");
    }
    else {
      if (!existFile(reportName, "jasper"))
        throw new FileNotFoundException("File " + reportName + ".jasper not found. The report design must be compiled first.");
    }
    this.reportName = reportName;
  }

  /**
   * �����ӱ���
   *
   * @param param
   * @param reportName
   * @throws JRException
   */
  public void setSubReport(String param, String reportName) throws JRException, FileNotFoundException {
    if (complie) {
      if (!existFile(reportName, "jrxml"))
        throw new FileNotFoundException("File " + reportName + ".jrxml not found.");
    }
    else {
      if (!existFile(reportName, "jasper"))
        throw new FileNotFoundException("File " + reportName + ".jasper not found. The report design must be compiled first.");
    }
    this.parameter.put(param, getJasperReport(reportName));
  }

  /**
   * ���ñ�����Ҫ�Ĳ���
   *
   * @param parameter
   */
  public void setParameter(Map parameter) {
    this.parameter.putAll(parameter);
  }

  /**
   * ���ñ�����Ҫ�Ĳ���
   *
   * @param key
   * @param value
   */
  public void setParameter(String key, Object value) {
    this.parameter.put(key, value);
  }

  /**
   * ���캯��
   *
   * @param application
   * @param response
   */
  public IReportPrintImpl(ServletContext application, HttpServletResponse response) {
    this.application = application;
    this.response = response;
//    if (complie) {
//      JRProperties.setProperty(JRProperties.COMPILER_CLASSPATH,
//          getRealPath("/WEB-INF/lib/jasperreports-1.0.2.jar") +
//              System.getProperty("path.separator") +
//              getRealPath("/WEB-INF/lib/iReport.jar") +
//              System.getProperty("path.separator") +
//              getRealPath("/WEB-INF/classes/")
//      );
//      JRProperties.setProperty(
//          JRProperties.COMPILER_TEMP_DIR,
//          getRealPath(reportPath)
//      );
//    }
  }

  /**
   * ��Xls��ʽ��ʾ����
   *
   * @throws JRException
   * @throws IOException
   */
  public void viewXlsReport() throws JRException, IOException {
    String downloadName = (this.description != null) ? this.description : this.reportName;
    downloadName = URLEncoder.encode(downloadName, "utf-8");
    JasperPrint jasperPrint = JasperFillManager.fillReport(getJasperReport(), this.parameter, this.jRDataSource);
    response.reset();
    response.setContentType("application/vnd.ms-excel;charset=GBK");
//    response.setContentType("application/octet-stream");
    response.setHeader("Content-Disposition", "attachment;filename=\"" + downloadName + ".xls\"");
    JRExporter exporter = new JRXlsExporter();
    exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
    exporter.setParameter(JRExporterParameter.OUTPUT_STREAM, response.getOutputStream());
    exporter.setParameter(JRXlsExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS, Boolean.TRUE);
    exporter.setParameter(JRXlsExporterParameter.IS_ONE_PAGE_PER_SHEET, Boolean.FALSE);
    exporter.setParameter(JRXlsExporterParameter.IS_WHITE_PAGE_BACKGROUND, Boolean.FALSE);
    exporter.exportReport();
  }

  /**
   * ��Pdf��ʽ��ʾ����
   *
   * @throws JRException
   * @throws IOException
   */
  public void viewPdfReport() throws JRException, IOException {
    JasperPrint jasperPrint = JasperFillManager.fillReport(getJasperReport(), this.parameter, this.jRDataSource);
    String downloadName = (this.description != null) ? this.description : this.reportName;
    downloadName = URLEncoder.encode(downloadName, "utf-8");
    response.reset();
    response.setContentType("application/pdf;charset=GBK");
//    response.setContentType("application/octet-stream");
    response.setHeader("Content-Disposition", "attachment;filename=\"" + downloadName + ".pdf\"");
    JRExporter exporter = new JRPdfExporter();
    exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
    exporter.setParameter(JRExporterParameter.OUTPUT_STREAM, response.getOutputStream());
    exporter.setParameter(JRPdfExporterParameter.IS_ENCRYPTED, Boolean.TRUE);
    exporter.setParameter(JRPdfExporterParameter.IS_128_BIT_KEY, Boolean.TRUE);
//				exporter.setParameter(JRPdfExporterParameter.USER_PASSWORD, "jasper");
//				exporter.setParameter(JRPdfExporterParameter.OWNER_PASSWORD, "reports");
    exporter.setParameter(JRPdfExporterParameter.PERMISSIONS, new Integer(PdfWriter.AllowCopy | PdfWriter.AllowPrinting));
    exporter.exportReport();
  }

  /**
   * ��Applet��ʽ��ʾ����
   *
   * @throws JRException
   * @throws IOException
   */
  public void viewAppletReport() throws JRException, IOException {
    ObjectOutputStream objectOutputStream = null;
    OutputStream ouputStream = null;
    try {
      JasperPrint jasperPrint = getJasperPrint();
      
      
      response.reset();
      response.setContentType("application/octet-stream");
      ouputStream = response.getOutputStream();
      objectOutputStream = new ObjectOutputStream(ouputStream);
      objectOutputStream.writeObject(jasperPrint);
      objectOutputStream.flush();
    }catch (Exception e){
    	
    	e.printStackTrace();
    	
    }
    finally {
      if (objectOutputStream != null) objectOutputStream.close();
      if (ouputStream != null) ouputStream.close();
    }
  }

  /**
   * ���JasperPrint����
   *
   * @return JasperPrint
   * @throws JRException
   */
  private JasperPrint getJasperPrint() throws JRException {
	  
    return JasperFillManager.fillReport(getJasperReport(), this.parameter, this.jRDataSource);
  }

  /**
   * ��� JasperReport����
   *
   * @param reportName
   * @return JasperReport
   * @throws JRException
   */
  private JasperReport getJasperReport(String reportName) throws JRException {
    String fileRealPath;
    if (complie) {
      
      fileRealPath = getRealPath(reportPath + "/" + reportName + ".jrxml");
      System.out.println(JasperCompileManager.compileReportToFile(fileRealPath));
    }
    
    fileRealPath = getRealPath(reportPath + "/" + reportName + ".jasper");
    File file = new File(fileRealPath);
    
    return (JasperReport) JRLoader.loadObject(file.getPath());
  }

  /**
   * ��� JasperReport����
   *
   * @return JasperReport
   * @throws JRException
   */
  private JasperReport getJasperReport() throws JRException {
    return getJasperReport(this.reportName);
  }

  /**
   * ����ļ���ʵ��·��
   *
   * @param fileName
   * @return String
   */
  private String getRealPath(String fileName) {
    return this.application.getRealPath(fileName);
  }

  /**
   * �ж�ָ�����ļ��Ƿ����
   *
   * @param reportName  ������
   * @param filePostfix �����׺��
   * @return boolean
   */
  private boolean existFile(String reportName, String filePostfix) {
    String fileRealPath = getRealPath(reportPath + "/" + reportName + "." + filePostfix);
    File file = new File(fileRealPath);
    return file.exists();
  }
}
