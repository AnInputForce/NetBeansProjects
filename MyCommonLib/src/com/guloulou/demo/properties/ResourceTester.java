/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.guloulou.demo.properties;

/**
 *
 * @author kang.cunhua
 */
import java.util.Locale;
import java.util.ResourceBundle;

/**
 * ResourceBundle 重载测试
 * @author Winter Lau
 * @date 2010-5-12 下午11:00:55
 */
public class ResourceTester {

    private final static MyResourceBundleControl ctl = new MyResourceBundleControl();

    /**
     * @param args
     * @throws InterruptedException
     */
    public static void main(String[] args) throws InterruptedException {
        System.out.println(getBundle().getString("author"));
        Thread.sleep(2000);
        System.out.println(getBundle().getString("author"));
    }

    private static ResourceBundle getBundle() {
        return ResourceBundle.getBundle("com/guloulou/demo/properties/baseconfig", Locale.getDefault(), ctl);
    }

    /**
     * 重载控制器，每秒钟重载一次
     * @author Winter Lau
     * @date 2010-5-12 下午11:20:02
     */
    private static class MyResourceBundleControl extends ResourceBundle.Control {

        /**
         * 每一秒钟检查一次
         */
        @Override
        public long getTimeToLive(String baseName, Locale locale) {
            return 1000;
        }

        @Override
        public boolean needsReload(String baseName, Locale locale,
                String format, ClassLoader loader,
                ResourceBundle bundle, long loadTime) {
            return true;
        }
    }
}

