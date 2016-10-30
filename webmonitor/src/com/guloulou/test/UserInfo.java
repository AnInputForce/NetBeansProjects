package com.guloulou.test;

import java.io.Serializable;

public class UserInfo implements Serializable {   
    public String userName;   
    public String userPass;   
    //注意，userAge变量前面的transient   
    public transient int userAge;   
  
    public UserInfo(){   
    }   
  
    public UserInfo(String username,String userpass,int userage){   
        this.userName=username;   
        this.userPass=userpass;   
        this.userAge=userage;   
    }   
  
    public String toString(){   
        return "用户名: "+this.userName+";密码："+this.userPass+   
            ";年龄："+this.userAge;   
    }   
}  

