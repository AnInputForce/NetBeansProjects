# NetBeansProjects
2009 ~ 2011年 写的部分代码，或维护的代码，传上来备份。纪念意义多于代码价值。

+ monitor_sys : 维护的一套信贷项目监控子系统代码：因为开发团队不care监控，响应慢，自己拿过来，推进并改造了部分监控。包括：
    + web节点、数据库节点存活监控；
    + Oracle 数据库各种运行参数监控，比如大查询，锁表等等几十种参数；感谢DBA宝哥提供监控SQL
    + 管理批量、报表批量监控；核心会计批量因老大反对，还是钟情“以人为本”，没再坚持写和部署脚本；
    + /monitor_sys/branch_release/6001/src/com/guloulou/kvcode/HealthSql.xml Oracle监控SQL配置
+ MyCommonLib : 根据IBM的某篇文章，尝试建立自己的通用lib，可惜写代码机会少，没继续；
+ webmonitor  : 当年入职时，写的第一个监控脚本。监控应用web server 节点和数据库的存活。
    + 也是做传统应用运维，没代码写，手痒痒
    + /resource/loanconfig.xml 部署到监控目录 监控目标配置
    + /check.jsp 部署到应用节点根目录，请求后检测节点是否给响应
    + /crontab.txt 部署到监控机，使用crontab计划任务来调度，配置参考
    + /loanserver.sh 部署到监控目录
    + 整个代码打包成可执行的loanserver.jar包，供Shell脚本调用
    + 意义在于：入职第一个上线的代码，第一次接触crontab
