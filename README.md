# Minzuchess
民族棋类网(Spring+SpringMVC+Mybatis+Shiro+Mysql+Redis)
---
本项目已改为[Spring Boot版](https://github.com/eanson1999/minzuchess-spring-boot),并在该版本上做bug修复
---

## 项目描述
该项目提供了在线对弈平台和AI分析处理接口,实现了AI和人类招法分析、在线对弈和在线观看对弈、对局记录和回放等功能。
## 项目亮点
为了减轻服务端轮询访问改用WebSocket协议实现棋盘数据的及时传输,采用Redis来缓存人类对弈时的步伐并用作之后的招法分析...
## 项目意义
有利于少数民族棋类活动的推广,也让AI设计者减轻一小部分烦恼,让参加比赛的同学只关注AI本身设计，而不用为开发UI界面发愁,平台不仅提供裁判程序,而且还提供了招法记录服务,可以让AI设计者更快更好地分析AI行为。
### 要点
1. ```about.properties```文件中Aliyun短信模板请自行配置
2. sql在resources文件夹下
3. 本项目许多素材尚未填充，但基本逻辑已经实现,同时支持负载均衡
### 具体技术
前端:html+css+javascript+jquery+bootstrap,其它:[轻量级的JavaScript表单验证](https://github.com/jaywcjlove/validator.js) ,[bootswatch主题](https://github.com/thomaspark/bootswatch),[数据表格](https://github.com/DataTables/DataTables)等

后端:Spring+SpringMVC+Mybatis+Shiro+Mysql+Redis,其它:[shiro-redis](https://github.com/alexxiyang/shiro-redis),[Mybatis通用分页插件](https://github.com/pagehelper/Mybatis-PageHelper),[druid](https://github.com/alibaba/druid)

> 写在最后:这是本萌新的第一个较完整的项目,但是还是有很多不足的地方,如果你看到了,请向我指出(前端就算了)
