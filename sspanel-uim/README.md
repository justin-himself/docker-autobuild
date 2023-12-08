<img src="https://cdn.jsdelivr.net/npm/skx@0.1.3/img/uim-logo-round.png" alt="logo" width="130" height="130" align="left" />

<h1>SSPanel UIM</h1>

> Across the Great Wall we can reach every corner in the world

<br/>

![](https://img.shields.io/badge/x86-9cf)
![](https://img.shields.io/badge/x86_64-red)
![](https://img.shields.io/badge/ARM_64-ff69b4)
![](https://img.shields.io/badge/ARM_v7-yellow)
![](https://img.shields.io/badge/ARM_v6-green)
![](https://img.shields.io/badge/PowerPC_64_le-blueviolet)
![](https://img.shields.io/badge/IBM_Z-blue)

### Description

构建自 [SSPanel-UIM](https://github.com/Anankke/SSPanel-Uim), 添加了以下功能:

- 多架构支持
- 傻瓜化配置 (无需任何多余设置开箱即用!)
- 自动初始化数据库
- 自动更新 IP 数据库、下载客户端、初始化管理员账户
- 自豪地使用 Apache 作为服务器程序

Todo List:

- [ ] 解决 “流媒体解锁” 页面的 Error 问题
- [ ] 新增时区设置, 新增用户权限设置
- [ ] 允许变量控制 php 内存大小设置
- [ ] 增加更多主题的镜像

### QuickStart

> 通过 docker-compose 创建容器 

* 


### Parameters

| **Parameter**          | **Function**                                                                          |
| ---------------------- | ------------------------------------------------------------------------------------- |
| PATH_TO_SITE           | SSPanel 以及数据库存放路径                                                            |
| SSPANEL_KEY            | 修改此字符串到一随机数值以保证网站安全                                                |
| SSPANEL_BASEURL        | 用于外部访问的网站域名                                                                |
| SSPANEL_MUKEY          | 用于校验魔改后端请求，可以随意修改，但请保持前后端一致，否则节点不能工作              |
| SSPANEL_APPNAME        | 站点名称, 默认为 `SSPanel-UIM`                                                        |
| SSPANEL_ADMIN_EMAIL    | 管理员账户邮箱, 用于脚本自动创建账户<br />除非你已经手动创建过账户, 否则强烈建议填写! |
| SSPANEL_ADMIN_PASSWORD | 管理员账户密码, 用于脚本自动创建账户<br />除非你已经手动创建过账户, 否则强烈建议填写! |
| SSPANEL_DEBUG          | 可选, 默认为 0<br />生产环境请保持为 0                                                |
| DB_HOST                | 数据库地址                                                                            |
| DB_PORT                | 数据库端口, 默认为 `3306`                                                             |
| DB_DATABASE            | 数据库名称, 默认为 `sspanel`<br />建议修改以保证安全                                  |
| DB_USERNAME            | 数据库用户名, 默认为 `root`                                                           |
| DB_PASSWORD            | 数据库密码                                                                            |
