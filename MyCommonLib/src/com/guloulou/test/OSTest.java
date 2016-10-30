/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.guloulou.test;

import com.sun.management.OperatingSystemMXBean;
import java.io.File;
import sun.management.ManagementFactory;

/**
 *
 * @author kang.cunhua
 */
public class OSTest {

    public static void main(String[] args) {
        //mem
        OperatingSystemMXBean osmb = (OperatingSystemMXBean) ManagementFactory.getOperatingSystemMXBean();
        long m1, m2;
        m1 = osmb.getTotalPhysicalMemorySize() / 1024 / 1024;
        m2 = osmb.getFreePhysicalMemorySize() / 1024 / 1024;
        System.out.println("系统物理内存总计：" + osmb.getTotalPhysicalMemorySize() / 1024 / 1024 + "MB");
        System.out.println("系统物理可用内存总计：" + osmb.getFreePhysicalMemorySize() / 1024 / 1024 + "MB");
        System.out.println("系统物理已用内存总计：" + (m1 - m2) + "MB");

        //disk
//        File[] roots = File.listRoots();//获取磁盘分区列表
//        for (File file : roots) {
//            System.out.println(file.getPath() + "信息如下:");
//            System.out.println("空闲未使用 = " + file.getFreeSpace() / 1024 / 1024 / 1024 + "G");//空闲空间
//            System.out.println("已经使用 = " + file.getUsableSpace() / 1024 / 1024 / 1024 + "G");//可用空间
//            System.out.println("总容量 = " + file.getTotalSpace() / 1024 / 1024 / 1024 + "G");//总空间
//        }

        System.out.println("osmb.getProcessCpuTime();" + osmb.getProcessCpuTime());


    }
}
