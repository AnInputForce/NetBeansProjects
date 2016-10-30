/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.guloulou.demo.jmx.standardmbean;

/**
 *
 * @author kang.cunhua
 */
public interface StandBeanMBean {

    public String getState();

    public void setState(String s);

    public void startService();
}
