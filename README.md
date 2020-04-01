# 人力资源管理系统

## 项目介绍

人力资源管理系统，Spring Boot 项目实战，前后端分离开发，Spring Boot + Vue 。

- 项目地址：[https://github.com/cxy35/hr](https://github.com/cxy35/hr)

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
9. 邮件服务
10. ...

## 项目效果图

登录

![](https://oscimg.oschina.net/oscnet/up-f1bb1a9dcf69435da89054fd98a91bf0f6c.png)

首页

![](https://oscimg.oschina.net/oscnet/up-bf28b202417cb2040b8a9ed1854788a423a.png)

员工列表

![](https://oscimg.oschina.net/oscnet/up-05405d2c04606aaff686d277f9f16ba7b4b.png)

新增员工

![](https://oscimg.oschina.net/oscnet/up-98df569bad73ce4ef4fe32b9b606a7e21ef.png)

角色管理

![](https://oscimg.oschina.net/oscnet/up-4e9c51fe334994c728a0e4d4e8f0e6c9963.png)

用户管理

![](https://oscimg.oschina.net/oscnet/up-9958c4977b05d2ef529413c0ebd5a9376ce.png)

在线聊天

![](https://oscimg.oschina.net/oscnet/up-73929a7a0a07d7fed372401fb08c989fd0e.png)

## 项目部署及二次开发

1. clone 代码到本地的 `hr` 目录： `git clone https://github.com/cxy35/hr.git hr` 。
2. 在本地新建 `hr` 数据库，执行数据库初始化脚本 `hr/hr.sql` 。
3. 用 IntelliJ IDEA 或其他 IDE 导入 `hr` 后端工程（选 hr 目录即可）。如果不是二次开发，则可跳过此步骤。
4. 修改 `hr-web` 工程下的 `application.properties` 配置文件中的数据库、ActiveMQ/RabbitMQ、Redis 等配置，之后通过 IDE 启动 或 Maven 打包后启动后端服务，默认 `8081` 端口（见 `application.properties` 配置文件）。
5. 修改 `hr-mail` 工程下的 `application.properties` 配置文件中的邮件服务、ActiveMQ/RabbitMQ 等配置，之后通过 IDE 启动 或 Maven 打包后启动邮件服务，默认 `8082` 端口（见 `application.properties` 配置文件）。如果不想发邮件，则可跳过此步骤。
6. 用 WebStorm 或其他 IDE 导入 `hr-vue` 前端工程（选 hr-vue 目录）。如果不是二次开发，则可跳过此步骤。
7. 在 `hr-vue` 根目录下用 `npm install` 命令安装前端相关依赖（需要先安装 `node` 环境，自行百度），如：vue、element-ui、axios 等，具体见 `hr-vue/README.md` 。
8. 在 `hr-vue` 根目录下用 `npm run serve` 命令启动前端服务，默认 `8080` 端口（见 `vue.config.js` 配置文件）。
9. 访问 [http://127.0.0.1:8080](http://127.0.0.1:8080) ，使用 admin/123 登录。

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
- 其他业务模块还未实现...