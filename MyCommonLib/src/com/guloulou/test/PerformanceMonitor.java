/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.guloulou.test;

/**
 *
 * @author kang.cunhua
 */
public class PerformanceMonitor {

//
//    private SNMPv1CommunicationInterface _snmpConn;
//  private long _lOldIdle = 0;
//  private long _lOldSystem = 0;
//  private long _lOldNice = 0;
//  private long _lOldUser = 0;
//
//  public static void main(String[] sArgs)
//  {
//   InetAddress hostAddress = InetAddress.getByName("127.0.0.1");  //machine ip
//   SNMPv1CommunicationInterface snmpConn = new SNMPv1CommunicationInterface(0, hostAddress, "public");
//   while(true)
//   {
//    try
//    {
//     double[] dCpu = getCPUInfo();
//     long[] lMemory = getMemoryInfo();
//     System.out.println("values");     //将这些值输出到屏幕，也可以到文档或数据结构中
//     Thread.sleep(1000);               //每秒取一次，可以自行调整
//    }
//    catch(Exception E)
//    {
//     E.printStackTrace();
//    }
//   }
//  }
//
//       //取得CPU空闲率，使用率（User/System/Nice）
//       //需要保存上一个监控点的计数，再将本次监控的值减去上一个监控点的计数
//       //将Idel/System/User/Nice四个值相加得到总CPU计数
//       //分别和Idel/System/User/Nice四个值相比就得到CPU空闲率和使用率了
//  protected double[] getCPUInfo()
//  {
//   long lCurCpuUser = getValue("1.3.6.1.4.1.11.2.3.1.1.13.0");
//   long lCurCpuSystem = getValue("1.3.6.1.4.1.11.2.3.1.1.14.0");
//   long lCurCpuIdle = getValue("1.3.6.1.4.1.11.2.3.1.1.15.0");
//   long lCurCpuNice = getValue("1.3.6.1.4.1.11.2.3.1.1.16.0");
//   long lSubCpuUser = lCurCpuUser - _lOldUser;
//   long lSubCpuSystem = lCurCpuSystem - _lOldSystem;
//   long lSubCpuIdle = lCurCpuIdle - _lOldIdle;
//   long lSubCpuNice = lCurCpuNice - _lOldNice;
//   long lTotal = lSubCpuUser + lSubCpuSystem + lSubCpuIdle + lSubCpuNice;
//
//   _lOldUser = lCurCpuUser;
//   _lOldSystem = lCurCpuSystem;
//   _lOldIdle = lCurCpuIdle;
//   _lOldNice = lCurCpuNice;
//   if(lTotal != 0)
//   {
//    double dCpuUser = (double)(lSubCpuUser * 100) / (double)lTotal;
//    double dCpuSystem = (double)(lSubCpuSystem * 100) / (double)lTotal;
//    double dCpuIdle = (double)(lSubCpuIdle * 100) / (double)lTotal;
//    double dCpuNice = (double)(lSubCpuNice * 100) / (double)lTotal;
//    return new double[]{dCpuUser, dCpuSystem, dCpuIdle, dCpuNice};
//   }
//   else
//   {
//    return new double[]{0.0, 0.0, 0.0, 0.0};
//   }
//  }
//
//       //取得空闲物理内存和总物理内存
//       //直接取得相应OID的值
//       //如果要计算内存使用率，将(lSystemMemory-lFreeMemory)*100/lSystemMemory即可，计算前要转换成double型计算
//  protected long[] getMemoryInfo()
//  {
//   long lFreeMemory = getValue("1.3.6.1.4.1.11.2.3.1.1.7.0");
//   long lSystemMemory = getValue("1.3.6.1.4.1.11.2.3.1.1.8.0);
//   return new long[]{lFreeMemory, lSystemMemory};
//  }
//
//        //通过SNMP协议取得指定OID的值
//  protected long getValue(String sOID)
//  {
//   try
//   {
//    SNMPVarBindList newVars = snmpConn.getMIBEntry(sOID);
//    SNMPSequence pair = (SNMPSequence)(newVars.getSNMPObjectAt(0));
//    SNMPObject snmpValue = pair.getSNMPObjectAt(1);
//    BigInteger biValue = (BigInteger)snmpValue.getValue();
//    return biValue.longValue();
//   }
//   catch(Exception E)
//   {
//    System.out.println("Encounter exception while getting value " +
//     "which OID is " + sOID + " by SNMP: " + E.getMessage());
//    return 0;
//   }
//  }


//    private int availableProcessors = getOperatingSystemMXBean().getAvailableProcessors();
//    private long lastSystemTime = 0;
//    private long lastProcessCpuTime = 0;
//
//    public synchronized double getCpuUsage() {
//        if (lastSystemTime == 0) {
//            baselineCounters();
//            return;
//        }
//        long systemTime = System.nanoTime();
//        long processCpuTime = 0;
//        if (getOperatingSystemMXBean() instanceof OperatingSystemMXBean) {
//            processCpuTime = ((OperatingSystemMXBean) getOperatingSystemMXBean()).getProcessCpuTime();
//        }
//        double cpuUsage = (double) (processCpuTime - lastProcessCpuTime) / (systemTime - lastSystemTime);
//        lastSystemTime = systemTime;
//        lastProcessCpuTime = processCpuTime;
//        return cpuUsage / availableProcessors;
//    }
//
//    private void baselineCounters() {
//        lastSystemTime = System.nanoTime();
//        if (getOperatingSystemMXBean() instanceof OperatingSystemMXBean) {
//            lastProcessCpuTime = ((OperatingSystemMXBean) getOperatingSystemMXBean()).getProcessCpuTime();
//        }
//    }
}
