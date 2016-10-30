
/*
 * function:HTML相关的工具类；目前有：
 * 1.自动检测指定URL编码；
 * 2.得到指定URL的网页源码
 *
 */
package com.guloulou.helper;

import info.monitorenter.cpdetector.io.ASCIIDetector;
import info.monitorenter.cpdetector.io.CodepageDetectorProxy;
import info.monitorenter.cpdetector.io.JChardetFacade;
import info.monitorenter.cpdetector.io.ParsingDetector;
import info.monitorenter.cpdetector.io.UnicodeDetector;
import java.io.*;
import java.net.*;
import java.nio.charset.Charset;

public class HtmlHelper {

    public HtmlHelper() {
    }

    public static HtmlHelper getInstance() {
        return new HtmlHelper();
    }
    /*
     * 自动探测页面编码，避免中文乱码的出现
     */

    public static String autoDetectCharset(URL url) {
        CodepageDetectorProxy detector = CodepageDetectorProxy.getInstance();
        /**
         * ParsingDetector可用于检查HTML、XML等文件或字符流的编码 构造方法中的参数用于指示是否显示探测过程的详细信息
         * 为false则不显示
         */
        detector.add(new ParsingDetector(false));
        detector.add(JChardetFacade.getInstance());
        detector.add(ASCIIDetector.getInstance());
        detector.add(UnicodeDetector.getInstance());

        Charset charset = null;
        try {
            charset = detector.detectCodepage(url);
        } catch (MalformedURLException mue) {
            mue.printStackTrace();
        } catch (IOException ie) {
            ie.printStackTrace();
        }
        if (charset == null) {
            charset = Charset.defaultCharset();
        }
        return charset.name();
    }

    public static String getHtml(String urlString) throws IOException {
        HttpURLConnection httpurlconnection = null;
        InputStreamReader isrTmp = null;
        BufferedReader brTmp = null;
        String content = null;

        //System.out.println(urlString);
        try {
            StringBuffer html = new StringBuffer();
            URL url = new URL(urlString);
            String pageEncode = autoDetectCharset(url);
            System.out.println(pageEncode);
            httpurlconnection = (HttpURLConnection) url.openConnection();
            // 以autoDetectCharset(url)检测到的编码pageEncode读取文件
            isrTmp = new InputStreamReader(httpurlconnection.getInputStream(), pageEncode);
            brTmp = new BufferedReader(isrTmp);
            String temp;
            while ((temp = brTmp.readLine()) != null) {
                html.append(temp).append("\n");
            }
            content = html.toString();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (httpurlconnection != null) {
                httpurlconnection.disconnect();
            }
            if (brTmp != null) {
                brTmp.close();
            }
            if (isrTmp != null) {
                isrTmp.close();
            }
        }
        return content;
    }

    public static void main(String argv[]) throws Exception {

        //System.out.println(autoDetectCharset(new URL("http://www.guloulou.com")));
        //System.out.println(autoDetectCharset(new URL("http://www.sina.com.cn")));
        //System.out.println(getHtml("http://www.guloulou.com"));
        System.out.println(getHtml("http://www.sina.com.cn"));
    }
}
