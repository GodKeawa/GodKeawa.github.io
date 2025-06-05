---
title: WSL-01 安装WSL和Ubuntu
draft: false
date: 2024-03-27T21:53:46+08:00
lastmod: 2024-03-27T21:53:46+08:00
categories: [tech]
tags:
  - WSL
  - Ubuntu
series: [WSL]  
series_order: 2
description: 如何安装WSL和Ubuntu

---
# 写在前面
由于WSL2使用hyper-v的问题目前还没有解决，所以本人使用了一条新的道路
```shell
# 管理员模式下输入
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
# 切换WSL版本到1
WSL --set-default-version 1
# 后续治好了WSL2就可以再次转换到WSL2
WSL --set-version <发行版名称> 2
```

# WSL堂堂复活
这次直接使用狠活，把网络的所有设置重置了，将VMware的毒完全刮尽
这时候想要去重新开启hyper-v，却发现在windows功能里没有hyper-v选项
看了看似乎是专业版才有，家庭版不让设置

使用脚本强制安装hyper-v功能
在文本中写入以下代码，再将扩展名改成cmd或bat运行
```shell
pushd "%~dp0"

dir /b %SystemRoot%\servicing\Packages\*Hyper-V*.mum >hyper-v.txt

for /f %%i in ('findstr /i . hyper-v.txt 2^>nul') do dism /online /norestart /add-package:"%SystemRoot%\servicing\Packages\%%i"

del hyper-v.txt

Dism /online /enable-feature /featurename:Microsoft-Hyper-V-All /LimitAccess /ALL
```

需要安装一段时间，安装完成后就能发现windows服务里有hyper-v和WSL了
先把两个功能都关闭，重启，把所有设置重置

再打开两个功能，重启，现在电脑就像没碰过VMware一样
又可以愉快地安装WSL2了

**PS: 一劳永逸，直接重装，痛失GitHub 2FA认证码**
# 关于WSL
[适用于 Linux 的 Windows 子系统文档 | Microsoft Learn](https://learn.microsoft.com/zh-cn/windows/WSL/)
作为微软的产品，当然是直接去看文档啦

# 安装WSL和Ubuntu
* 如果你的windows系统“紧跟潮流”的话，就可以舒服地享受一键安装的快乐，只需要在powershell使用命令`WSL --install`即可
* 如果发现命令无效，那就只能玩硬核的了
[旧版 WSL 的手动安装步骤 | Microsoft Learn](https://learn.microsoft.com/zh-cn/windows/WSL/install-manual)

* 当然也不可能完全一帆风顺，你大天朝的网络总是“值得信赖”的
![image.png](https://picbed.godke.blog/img/20240327144550.png)
* 我故意没开代理，果然卡了，所以记得保持代理开着

* 安装完成后会让你对Ubuntu进行初始化设置
	* 首先输入用户名，和windows性质一样，但是一定要用小写字母和数字，且最好字母开头
		* 其他的形式可能造成未知bug
	* 然后输入密码，这是你以后sudo要用的，
	* 最好重复输入密码，初始化完成

现在已经成功进入到Ubuntu了，也可以在终端为Ubuntu单开一个专属于Ubuntu的控制台
![image.png](https://picbed.godke.blog/img/20240327145006.png)




