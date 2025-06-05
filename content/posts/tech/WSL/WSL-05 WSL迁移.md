---
title: WSL-05 WSL迁移
draft: false
date: 2024-04-01T21:53:46+08:00
lastmod: 2024-04-01T21:53:46+08:00
categories: [tech]
tags:
  - WSL
  - Ubuntu
series: [WSL]  
series_order: 6
description: 如何导出和导入WSL2里的系统

---

**WSL迁移不止是为了给C盘腾空间，也是为了方便进行备份**
## 查看WSL状态

```bash
WSL -l -v
如果Running运行状态，关掉它
WSL --shutdown
```

## 导出系统镜像

```bash
WSL --export Ubuntu E:\Ubuntu\ubuntu.tar
```

在路径下有了Ubuntu的压缩包，可以把这个压缩包备份，也可以直接导出到备份盘里，主文件并不受影响
## 注销原有的linux系统

```bash
WSL --unregister Ubuntu
可以再查看是否注销：
WSL -l -v
```

## 导入系统

WSL --import <导入的Linux名称> <导入盘的路径> <ubuntu.tar的路径> --version 2 (代表 WSL2)

```bash
WSL --import Ubuntu E:\Ubuntu\ E:\Ubuntu\ubuntu.tar --version 2
```

对比前面，路径下多了一个 ext4 映像文件
## 修改默认用户

打开WSL ubuntu之后，默认以root身份登录。

```bash
ubuntu.exe config --default-user <你的用户名>
```

ubuntu.exe ：前面导入的时候没指定，所以这里用的默认ubuntu

