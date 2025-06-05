---
title: WSL-03 GUI界面
draft: false
date: 2024-03-29T19:49:21+08:00
lastmod: 2024-03-29T19:49:21+08:00
categories: [tech]
tags:
  - Ubuntu
  - WSL
  - gnome
series: [WSL]  
series_order: 4
description: 给Ubuntu配置桌面的踩坑经历

---

# 给WSL安装桌面
## 踩坑经历
网上还是有很多先辈尝试过的
### gnome桌面尝试
#### X server  技术栈
目前来说最完整的是这篇文章
[Windows中WSL2 配置运行GNOME桌面版 Ubuntu-CSDN博客](https://blog.csdn.net/HackEle/article/details/122572418)
但是时隔几年，WSL2变了很多
* 基本流程不变，apt-fast可以不安装
* 主要安装两个包`ubuntu-desktop和gnome`，`gnome-session`大概率是包含的
* 在安装包之前要进行一个操作，还有一些可能的问题要处理
	* 见[WSL2 Ubuntu22.04安装KDE桌面_setting up acpi-support (0.144) ... failed to retr-CSDN博客](https://blog.csdn.net/qq_30448087/article/details/134897586)
* VcXsrv照常配置

最主要的变化就是图像输出地址的变化
在目前的绝大部分博客中都是写的
> 在.bashrc文件末尾写入： 
> export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0 
> export LIBGL_ALWAYS_INDIRECT=1

这个DISPLAY的地址和配置代理的地址是一样的，后面的:0是控制几号屏幕和几号窗口的
其实最后面的东西根本没必要看别人说怎么配置，自己打开VcXsrv，就能看到标题里有
![image.png](https://picbed.godke.blog/img/20240403191620.png)
所以直接用-1（让软件自己选择），然后地址上配0.0就行

而前面的ip地址有很多说法，包括
* 上面的说法，即Ubuntu的namesever地址
* 本机（windows）的ipv4地址
* Ubuntu的ipv4虚拟地址

然而实际上这些地址都有问题，在新的Ubuntu里因为WSLg的存在，绝大部分情况下输出图像都被WSLg承接了
可以使用测试程序`xeyes`,就会发现眼睛出现在独立窗口里，而不是VcXsrc里

经过本人的多次尝试，事实上DISPLAY地址应该是`localhost:0.0`
在这样的情况下，只要这一行，便可以实现将图像输出到VcXsrc

然后就是各种bug，最好的情况也就是能打开桌面然后动一动了，终端都是打不开的
这里踩了超多坑，虽然有记录但是已经没意义了，因为未来大概率不支持了
[GNOME 正在采取措施逐步放弃 X11 - Linux迷 (linuxmi.com)](https://www.linuxmi.com/gnome-towards-dropping-x11.html)
而这条技术栈完全依赖于X11，走不远就不走了

#### vnc 技术栈
大差不差，用xrdp来实现远程控制
[Windows10 WSL2 安装Ubuntu并使用图形化界面_WSL2 ubuntu图形界面-CSDN博客](https://blog.csdn.net/flr_0831/article/details/123970357)
问题和X server技术栈如出一辙
* 要么没图像，要么直接报错
* 性能还不好

### KDE尝试
很少有人玩这个，我只是尝试了一下，问题一堆，还是快跑吧
[WSL2 Ubuntu22.04安装KDE桌面_setting up acpi-support (0.144) ... failed to retr-CSDN博客](https://blog.csdn.net/qq_30448087/article/details/134897586)

### xfce4尝试
问题不多，效果拉跨，不如没有
目前网上大部分人都是跑的xfce4，因为简单防傻，没多大作用
[win11系统通过WSL/WSL2安装ubuntu，开启图形桌面 - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/436441212)
VcXsrc和xrdp的技术栈目前来说都还行，但是太丑了

## 最终方案
> 装个锤锤gui，就一开发环境，还是远程开发，又不是kali，为什么需要桌面

直接使用微软的WSLg方案
[使用 WSL 运行 Linux GUI 应用 | Microsoft Learn](https://learn.microsoft.com/zh-cn/windows/WSL/tutorials/gui-apps)
* 大部分都装上最好，没有GIMP倒是问题不大，只是编辑不了图片
* VLC必装，不然没有媒体播放器，声音支持似乎也靠它
* Nautilus就是文件管理器，可以直接通过WSLg打开，非常方便
	* 就是会产生一些莫名的报错，目前不是很影响使用，其实直接用vscode进行文件管理最好，只是有权限问题，不过大部分系统文件最好还是到终端用nano改

另外可以安装包管理器
[在 Ubuntu 中使用轻量的 Apt 软件包管理器 Synaptic | Linux 中国 - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/150879173)

目前来说Ubuntu不是很适合搞GUI界面，要GUI还是看后面的kali-linux吧