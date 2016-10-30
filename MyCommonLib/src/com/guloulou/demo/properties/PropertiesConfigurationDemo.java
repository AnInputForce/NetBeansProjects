/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.guloulou.demo.properties;

/**
 *
 * @author kang.cunhua
 */
import java.util.List;

import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.ConfigurationException;
import org.apache.commons.configuration.PropertiesConfiguration;

public class PropertiesConfigurationDemo {

    public static void main(String[] args) throws ConfigurationException {

        Configuration config = new PropertiesConfiguration(
                PropertiesConfigurationDemo.class.getResource("/com/guloulou/demo/properties/baseconfig.properties"));
        String ip = config.getString("ip");
        String account = config.getString("account");
        String password = config.getString("password");
        String role1 = config.getString("role1");
        String role2 = config.getString("role2");
        String role3 = config.getString("role3");

        System.out.println("IP: " + ip);
        System.out.println("Account: " + account);
        System.out.println("Password: " + password);

        System.out.println("★★★★★ Roles Begin ★★★★★");
        System.out.println("Role1: " + role1);
        System.out.println("Role2: " + role2);
        System.out.println("Role3: " + role3);
        System.out.println("★★★★★  Roles End  ★★★★★");

        String[] colors = config.getStringArray("colors.pie");
        System.out.println("★★★★★ Use StringArray Begin ★★★★★");
        for (int i = 0; i < colors.length; i++) {
            System.out.println(colors[i]);
        }
        System.out.println("★★★★★  Use StringArray End  ★★★★★");

        List<?> colorList = config.getList("colors.pie");
        System.out.println("★★★★★ Use List Begin ★★★★★");
        for (int i = 0; i < colorList.size(); i++) {
            System.out.println(colorList.get(i));
        }
        System.out.println("★★★★★  Use List End  ★★★★★");
    }
}


