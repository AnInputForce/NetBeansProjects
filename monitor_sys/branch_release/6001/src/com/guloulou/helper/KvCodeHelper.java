package com.guloulou.helper;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * User: sunlei
 * Date: 2007-7-4
 * Time: 5:01:37
 */
public class KvCodeHelper {

    private static DocumentBuilder builder;
    private static final String BASE_PATH;

    static {
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        try {
            builder = factory.newDocumentBuilder();
        } catch (ParserConfigurationException e) {
            builder = null;
        }
        BASE_PATH = KvCodeHelper.class.getResource("/com/guloulou/kvcode/").toString();
        //BASE_PATH = System.getProperty("user.dir") + "/resource/kvcode/";

    }

    private static Map parseToMap(Document document) {
        Map map = new HashMap();
        NodeList nodes = document.getElementsByTagName("item");
        for (int i = 0; i < nodes.getLength(); i++) {
            Element temp = (Element) nodes.item(i);
            map.put(temp.getAttribute("key"), temp.getAttribute("value"));
        }
        return map;
    }

    public static String getValue(String value, String resource) {
        Document document = null;
        try {
            document = builder.parse(BASE_PATH + resource + ".xml");
        } catch (SAXException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        Map map = parseToMap(document);
        return map.get(value) == null ? "" : map.get(value).toString();
    }

    public static String getHtmlOption(String resource) {
        StringBuffer sb = new StringBuffer();
        try {
            Document document = builder.parse(BASE_PATH + resource + ".xml");
            NodeList nodes = document.getElementsByTagName("item");
            for (int i = 0; i < nodes.getLength(); i++) {
                Element temp = (Element) nodes.item(i);
                sb.append("<option value=\"");
                sb.append(temp.getAttribute("key"));
                sb.append("'>");
                sb.append(temp.getAttribute("value"));
                sb.append("</option>");
            }
        } catch (IOException e) {
            e.printStackTrace();
        } catch (SAXException e) {
            e.printStackTrace();
        }
        return sb.toString();
    }

    public static String getHtmlOption(String resource, String selected) {
        StringBuffer sb = new StringBuffer();
        try {
            Document document = builder.parse(BASE_PATH + resource + ".xml");
            NodeList nodes = document.getElementsByTagName("item");
            for (int i = 0; i < nodes.getLength(); i++) {
                Element temp = (Element) nodes.item(i);
                String key = temp.getAttribute("key");

                sb.append("<option value=\"");
                sb.append(key);
                sb.append("\"");
                if (key.equals(selected)) sb.append("selected");
                sb.append(">");
                sb.append(temp.getAttribute("value"));
                sb.append("</option>");
            }
        } catch (IOException e) {
            e.printStackTrace();
        } catch (SAXException e) {
            e.printStackTrace();
        }
        return sb.toString();
    }

    public static String getHtmlRadio(String name, String resource) {
        StringBuffer sb = new StringBuffer();
        try {
            Document document = builder.parse(BASE_PATH + resource + ".xml");
            NodeList nodes = document.getElementsByTagName("item");
            for (int i = 0; i < nodes.getLength(); i++) {
                Element temp = (Element) nodes.item(i);
                sb.append("<input type='radio' name='");
                sb.append(name);
                sb.append("' value=\"");
                sb.append(temp.getAttribute("key"));
                sb.append("'>");
                sb.append(temp.getAttribute("value"));
            }
        } catch (IOException e) {
            e.printStackTrace();
        } catch (SAXException e) {
            e.printStackTrace();
        }
        return sb.toString();
    }

    public static String getHtmlRadio(String name, String resource, String selected) {
        StringBuffer sb = new StringBuffer();
        try {
            Document document = builder.parse(BASE_PATH + resource + ".xml");
            NodeList nodes = document.getElementsByTagName("item");
            for (int i = 0; i < nodes.getLength(); i++) {
                Element temp = (Element) nodes.item(i);
                String key = temp.getAttribute("key");

                sb.append("<input type='radio' name='");
                sb.append(name);
                sb.append("' value=\"");
                sb.append(key);
                sb.append("\"");
                if (key.equals(selected)) sb.append("checked");
                sb.append(">");
                sb.append(temp.getAttribute("value"));
            }
        } catch (IOException e) {
            e.printStackTrace();
        } catch (SAXException e) {
            e.printStackTrace();
        }
        return sb.toString();
    }

    public static String getHtmlCheckBox(String name, String resource) {
        StringBuffer sb = new StringBuffer();
        try {
            Document document = builder.parse(BASE_PATH + resource + ".xml");
            NodeList nodes = document.getElementsByTagName("item");
            for (int i = 0; i < nodes.getLength(); i++) {
                Element temp = (Element) nodes.item(i);
                sb.append("<input type='checkbox' name='");
                sb.append(name);
                sb.append("' value=\"");
                sb.append(temp.getAttribute("key"));
                sb.append("\">");
                sb.append(temp.getAttribute("value"));
            }
        } catch (IOException e) {
            e.printStackTrace();
        } catch (SAXException e) {
            e.printStackTrace();
        }
        return sb.toString();
    }

    public static String getHtmlCheckBox(String name, String resource, List selected) {
        StringBuffer sb = new StringBuffer();
        try {
            Document document = builder.parse(BASE_PATH + resource + ".xml");
            NodeList nodes = document.getElementsByTagName("item");
            for (int i = 0; i < nodes.getLength(); i++) {
                Element temp = (Element) nodes.item(i);
                String key = temp.getAttribute("key");

                sb.append("<input type='checkbox' name='");
                sb.append(name);
                sb.append("' value=\"");
                sb.append(key);
                sb.append("\"");
                if (selected.contains(key)) sb.append("checked");
                sb.append(">");
                sb.append(temp.getAttribute("value"));
            }
        } catch (IOException e) {
            e.printStackTrace();
        } catch (SAXException e) {
            e.printStackTrace();
        }
        return sb.toString();
    }

    public static String getHtmlCheckBox(String name, String resource, String[] selected) {
        List list = new ArrayList();
        for (int i = 0; i < selected.length; i++) {
            list.add(selected[i]);
        }
        return getHtmlCheckBox(name, resource, list);
    }

    public static void main(String[] args) {
        try {
            System.out.println(KvCodeHelper.getHtmlCheckBox("HealthSql","HealthSql"));
            System.out.println(KvCodeHelper.getHtmlOption("HealthSql","1"));
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
