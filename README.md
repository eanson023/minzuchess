# Minzuchess
民族棋类网(Spring+SpringMVC+Mybatis+Shiro+Mysql+Redis)
---
demo请见:[nation.eanson.work](http://nation.eanson.work "nation.eanson.work")
---
测试棋盘码:[Test](http://nation.eanson.work/chess?n_t=1586511476075&ex=f96d4f00b2b34a2f86bca3f896ace743&ex2=f0d885aa015a46708898e61f6d632079&code=Test)

具体游戏规则:见[首页](http://nation.eanson.work)右侧链接
## 项目描述
该项目提供AI对弈平台解决方案,实现了AI和人类招法分析、在线对弈和在线观看对弈、对局记录和回放等功能,采用WebSocket协议实现棋盘数据及时传输。
## 项目意义
有利于少数民族棋类活动的推广,也让AI设计者减轻一小部分烦恼,让参加比赛的同学只关注AI本身设计，而不用为开发UI界面发愁,平台不仅提供裁判程序,而且还提供了招法记录服务,可以让AI设计者更快更好地分析AI行为。
### 要点
1. 缺少```about.properties```文件,请自行配置
2. sql在resources文件夹下
3. 本项目许多素材尚未填充，但基本逻辑已经实现,同时支持负载均衡
### 具体技术
前端:html+css+javascript+jquery+bootstrap,其它:[轻量级的JavaScript表单验证](https://github.com/jaywcjlove/validator.js) ,[bootswatch主题](https://github.com/thomaspark/bootswatch),[数据表格](https://github.com/DataTables/DataTables)等

后端:Spring+SpringMVC+Mybatis+Shiro+Mysql+Redis,其它:[shiro-redis](https://github.com/alexxiyang/shiro-redis),[Mybatis通用分页插件](https://github.com/pagehelper/Mybatis-PageHelper),[druid](https://github.com/alibaba/druid)

> 写在最后:这是本萌新的第一个较完整的项目,但是还是有很多不足的地方,如果你看到了,请向我指出(前端就算了)
