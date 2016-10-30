/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.guloulou.demo.jmx.standardmbean;

/**
 *
 * @author kang.cunhua
 */
public class StandBean implements StandBeanMBean {

    private String state = "init value";

    public String getState() {
        return state;
    }

    public void setState(String s) {
        state = s;
    }

    public void startService() {
        System.out.println("My service start.....");
        System.out.println("state=" + state + ";");
    }
}

