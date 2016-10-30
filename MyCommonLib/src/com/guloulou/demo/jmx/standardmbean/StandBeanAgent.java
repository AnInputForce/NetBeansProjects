/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.guloulou.demo.jmx.standardmbean;

import com.sun.jdmk.comm.HtmlAdaptorServer;
import javax.management.Attribute;
import javax.management.MBeanServer;
import javax.management.MBeanServerFactory;
import javax.management.MalformedObjectNameException;
import javax.management.ObjectName;

/**
 *
 * @author kang.cunhua
 */
public class StandBeanAgent {

    private MBeanServer mBserver = null;
    ObjectName mbeanObjectName = null;
    String domain = null;
    String mbeanName = "StandBean";

    public static void main(String[] args) {

        StandBeanAgent sbean = new StandBeanAgent();

        sbean.doRegistBean();
        sbean.doManageBean();
        sbean.regHtmlAdaptor();
    }

    /**
     * 创建MBeanServer并注册一个Mbean
     */
    private void doRegistBean() {
        //创建MBeanServer
        mBserver = MBeanServerFactory.createMBeanServer();
        domain = mBserver.getDefaultDomain();
        System.out.println("domain=" + domain + "!");

        try {
            mbeanObjectName = new ObjectName(domain + ":type=" + mbeanName);

            /*
            //这里可以直接创建并且同时注册一个mbean到MBeanServer.
            server.createMBean(mbeanName,mbeanObjectName);
             */

            StandBean bean = new StandBean();
            mBserver.registerMBean(bean, mbeanObjectName);

            System.out.println("register StandMbean sucess..");
        } catch (MalformedObjectNameException e) {
            e.printStackTrace();
            System.exit(1);
        } catch (Exception e) {
            e.printStackTrace();
            System.exit(1);
        }

    }


    /*
     * 演示管理mbean，通过mbserver修改mbean的属性和执行mbean的方法
     */
    private void doManageBean() {
        try {
            ObjectName mbeanObjectName = new ObjectName(domain + ":type=" + mbeanName);

            System.out.println("Attribute:state -" + mBserver.getAttribute(mbeanObjectName, "State"));

            //修改属性State
            Attribute stateAttribute = new Attribute("State", "new state");
            mBserver.setAttribute(mbeanObjectName, stateAttribute);

            //取得属性值
            System.out.println("Attribute:state 2 -" + mBserver.getAttribute(mbeanObjectName, "State"));

            //调用方法startService
            mBserver.invoke(mbeanObjectName, "startService", null, null);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /*
     * 注册HtmlAdaptor，注册后可以通过http://localhost:8082执行mbean管理操作
     */
    private void regHtmlAdaptor() {
        HtmlAdaptorServer html = new HtmlAdaptorServer();
        ObjectName html_name = null;
        try {
            html_name = new ObjectName("Adaptor:name=html,port=8082");
            mBserver.registerMBean(html, html_name);
        } catch (Exception e) {
            System.out.println("\t!!! Could not create the HTML adaptor !!!");
            e.printStackTrace();
            return;
        }
        html.start();
    }
}
