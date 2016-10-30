package com.git.base.common;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2004</p>
 * <p>Company: </p>
 * @author not attributable
 * @version 1.0
 */
import java.util.Vector;
import javax.sql.*;
import java.sql.*;
import org.apache.log4j.*;

import com.git.base.dbmanager.*;
import com.git.base.exceptions.ApplicationException;
import com.git.base.cfg.Service;
/**
 * 定义系统字典的存储
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2003</p>
 * <p>Company: git</p>
 * @author llh
 * @version 1.0
 */
public class DictionaryRepository {

  //系统的的所有字典
  private static Vector totalDic;
  //系统的的根字典
  private static String rootDicID="1";
  private final static int  Reload =1;
  private final static int  unionViewFlag=1;  //数据库是否支持带有union 的View
  private static String appendDicView="m01AppendDic";
  private static String appendDicCountView="m01AppendDicCount";
  private static int reloadFlag=0;
  private static Vector dicDesc;
  private static final Logger log = Logger.getLogger(DictionaryRepository.class);

  private DictionaryRepository() {
  }

  public static DictionaryRepository getInstance() {

    return d_instance;
  }

  public void reload(){
    reloadFlag=1;
  }

  /**
   * get getTotalDic
   * @return Vector
   */
  public Vector getTotalDic() throws Exception{
    try {
      if(reloadFlag==Reload){
         reloadFlag=0;
         //如果字典内容修改，就重新载入;
         initTotalDic();
         //System.out.print("init a new totalDic");
         log.info("init a new totalDic");
      }else{
        if (totalDic == null) {
         //如果字典内容修改，就重新载入;
             initTotalDic();
             //System.out.print("init a new totalDic");
             log.info("init a new totalDic");
        }else{
             //System.out.print("already have a totalDic");
             //log.info("already have a totalDic");
        }


      }
    }
    catch (Exception se) {
      ApplicationException ae=new ApplicationException("the exception in totalDic singleton is:" +
                               se.getMessage());
      log.error(ae.errorMsg) ;

    }
    return totalDic;
  }


  /**
   * 初始化2级菜单
  */
  private void initTotalDic() throws Exception{


    String strDic=" select m01zddh,m01xmdh,m01zwsm,xh from M01 where m01zddh<>"+rootDicID +" order by 1,4,2";
    String strDicDesc="select m01zddh,m01index,m01count from  M01_view ";
    String strAppendDic="";
    String strCount="";
    if(unionViewFlag==1){
         strAppendDic="select m01zddh,m01xmdh,m01zwsm,listOrder from m01AppendDic order by 1,4,2 ";
         //strCount="select m01zddh,m01count from m01AppendDicCount order by 1 ";
         strCount="select m01zddh,count(*) as m01count from m01AppendDic group by m01zddh order by 1 ";

    }else{
          strAppendDic="select 300 as m01zddh,AppOpKind as m01xmdh,AppOpName as m01zwsm  from ApplicationConfig "+
                        "union " +
                        "select 301 as m01zddh,branchCode as m01xmdh,branchName as m01zwsm  from InterBranch " +
                        "union " +
                        "select 302 as m01zddh,roleCode as m01xmdh,roleName  as m01zwsm from BankRole "+
                        "union "+
                        "select 303 as m01zddh,userCode as m01xmdh,userName as m01zwsm  from BankUser "+
                        "union "+
                        "select 304 as m01zddh,Ind_LevelCode as m01xmdh,Ind_levelName as m01zwsm  from Ind_LevelCatalog "+
                        "where CodeClass=1 "+
                        "union "+
                        "select 305 as m01zddh,Ind_LevelCode as m01xmdh,Ind_levelName as m01zwsm  from Ind_LevelCatalog "+
                        "where CodeClass=2 "+
                        "union "+
                        "select 306 as m01zddh,Ind_LevelCode as m01xmdh,Ind_levelName as m01zwsm  from Ind_LevelCatalog "+
                        "where CodeClass=3 "+
                        "union "+
                        "select 307 as m01zddh,Ind_LevelCode as m01xmdh,Ind_levelName as m01zwsm  from Ind_LevelCatalog "+
                        "where CodeClass=4 "+

                        //"order by m01zddh,m01xmdh ";
                        "order by 1,2 ";

           strCount="select 300 as m01zddh,count(*) as m01count from ApplicationConfig "+
                    "union "+
                    "select 301 as m01zddh,count(*) as m01count from InterBranch "+
                    "union "+
                    "select 302 as m01zddh,count(*) as m01count from BankRole "+
                    "union "+
                    "select 303 as m01zddh,count(*) as m01count from BankUser "+
                    "union "+
                    "select 304 as m01zddh,count(*) as m01count from Ind_LevelCatalog "+
                    "where CodeClass=1 "+
                    "union "+
                    "select 305 as m01zddh,count(*) as m01count from Ind_LevelCatalog "+
                    "where CodeClass=2 "+
                    "union "+
                    "select 306 as m01zddh,count(*) as m01count from Ind_LevelCatalog "+
                    "where CodeClass=3 "+
                    "union "+
                    "select 307 as m01zddh,count(*) as m01count from Ind_LevelCatalog "+
                    "where CodeClass=4 "+

                    //"order by m01zddh";
                    "order by 1 ";
    }
    Vector appendCount=null;
    Vector appendDic=null;
    int appendIndex=0;
//    Manager om=new Manager();
    try{
      totalDic = Manager.getInstance().execSQL(strDic);
      appendIndex=totalDic.size();
      appendCount=Manager.getInstance().execSQL(strCount);
      if(appendCount!=null){
        for(int i=0;i<appendCount.size();i++){
          String[] result=(String[])appendCount.elementAt(i);

          strDicDesc+=" union select "+result[0]+" as m01zddh,"+
                  String.valueOf(appendIndex)+" as m01index,"+result[1]+" as m01count ";

          appendIndex+=Integer.parseInt(result[1]);
        }
        //strDicDesc+=" order by m01zddh ";
        strDicDesc+=" order by 1 ";
      }

      appendDic= Manager.getInstance().execSQL(strAppendDic);
      if(appendDic!=null){
         for(int i=0;i<appendDic.size();i++){
           String[] result=(String[])appendDic.elementAt(i);
           totalDic.add(result);
         }

      }
      dicDesc=Manager.getInstance().execSQL(strDicDesc);


      //System.out.println("the vector value: "+dicDesc.get(0));
      //System.out.println("the vector length  is: "+dicDesc.size());
    }catch(Exception se){
       se.printStackTrace();
       throw se;
     }


  }

  public Vector getSubDic(String dicID) throws Exception{
  try{
        Vector dic=new Vector();
        String[] result=null;
        String[] descResult=null;
        int start=0;
        int leng=0;
        this.getTotalDic();

        for(int i=0;i<dicDesc.size();i++){
            descResult=(String[])dicDesc.elementAt(i);
            if(dicID.equalsIgnoreCase(descResult[0])){
              start=Integer.parseInt(descResult[1]);
              leng=Integer.parseInt(descResult[2]);
              break;
            }
        }
        //System.out.println("start:"+String.valueOf(start)+"----leng:"+String.valueOf(leng));
        for(int i=start;i<start+leng;i++){
            result=(String[])totalDic.elementAt(i);

            if(dicID.equalsIgnoreCase(result[0])){
              String[] result2=new String[2];
              result2[0]=result[1].trim();
              result2[1]=result[2].trim();
              dic.add(result2);
            }
        }

       return dic;

     }catch(Exception se){
        se.printStackTrace();
        throw se;
     }

  }


  private static final DictionaryRepository d_instance = new DictionaryRepository();



}
