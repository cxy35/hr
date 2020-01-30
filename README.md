# hr

## 项目介绍

人力资源管理系统，前后端分离，Spring Boot + Vue

- 项目地址：[https://github.com/zhengjian511/hr](https://github.com/zhengjian511/hr)

## 项目技术栈

### 前端技术栈

1. Vue
2. ElementUI
3. axios
4. vue-router
5. Vuex
6. WebSocket
7. vue-cli4
8. ...

### 后端技术栈

1. Spring Boot
2. Spring Security
3. MyBatis
4. MySQL
5. Redis
6. ActiveMQ/RabbitMQ
7. Spring Cache
8. WebSocket
9. ...

## 项目效果图

登录页

![登录页](https://oscimg.oschina.net/oscnet/up-f1bb1a9dcf69435da89054fd98a91bf0f6c.png)

内容页

![内容页](https://oscimg.oschina.net/oscnet/up-bf28b202417cb2040b8a9ed1854788a423a.png)

![内容页2](https://oscimg.oschina.net/oscnet/up-00785e25b240211e0d58705039afacb70e4.png)

## 项目部署

TODO

## 项目文档

- [数据库初始化脚本](https://github.com/zhengjian511/hr/blob/master/hr.sql)
- [需求规格说明书](https://github.com/zhengjian511/hr/blob/master/%E4%BA%BA%E4%BA%8B%E7%AE%A1%E7%90%86%E7%B3%BB%E7%BB%9F%E9%9C%80%E6%B1%82%E8%A7%84%E6%A0%BC%E8%AF%B4%E6%98%8E%E4%B9%A6.pdf)
- [设计说明书](https://github.com/lenve/vhr/wiki)

## 项目研发历程

- 前端，创建 hr-vue 工程
- 前端，登录页面
- 后端，创建 hr 工程
- 后端，登录接口
- 前后端，登录功能联调
- 前端，首页（包含左侧导航菜单）
- 后端，菜单接口
- 前端，所有菜单对应的页面（内容暂时只包含菜单名称）
- 前后端，菜单功能联调
- 后端，统一增加所有请求地址的权限控制
- 系统管理-基础信息设置
- 系统管理-基础信息设置-职位管理
- 系统管理-基础信息设置-职称管理
- 系统管理-基础信息设置-角色管理
- 系统管理-基础信息设置-部门管理
- 系统管理-用户管理
- 员工资料-基本资料
- 新增员工自动发送入职通知邮件
- 薪资管理-工资账套管理
- 薪资管理-员工账套管理
- 在线聊天