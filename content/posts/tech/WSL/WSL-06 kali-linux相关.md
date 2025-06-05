---
title: WSL-06 kali-linux相关
draft: false
date: 2024-04-02T16:22:31+08:00
lastmod: 2024-04-02T16:22:31+08:00
categories: [tech]
tags:
  - kali
  - WSL
series: [WSL]  
series_order: 6
description: 在WSL2里安装kali-linux

---

# 安装kali-linux
直接在WSL2上选择kali-linux安装即可

# 安装图形界面
不得不说kali因为图形界面的必要性比较大（渗透测试很多软件都是有图形界面的）
使得kali的图形化技术非常成熟

直接一键安装Win-KeX
```bash
sudo apt update && sudo apt install kali-win-kex
```
然后就能启动使用了
* 因为kali的技术栈就是内置了一共vnc，所以还要给vnc设置个密码，随便设就行

使用直接看官方docs
[Win-KeX | Kali Linux Documentation](https://www.kali.org/docs/WSL/win-kex/)
一共三个模式
* window模式，就是相当于占满屏幕，对多屏幕友好，我就直接用这个，放在副屏上
	* 使用命令`kex --win -s`
* 增强模式，与Hyper-V类似，使用`RDP`获得功能更丰富的体验
	* 使用命令`kex --esm --ip -s`
* 无缝模式，类似于WSLg，将部分图形镶嵌到windows里，软件也可以直接在windows里打开，还是很推荐的，这样就不用再到windows上安装一次工具了
	* 使用命令`kex --sl -s`

# 安装工具包
WSL提供的kali是最小版本，很多工具都是没有安装的，可以选择安装一种
* 安装标准工具包
	* `sudo apt install kali-linux-default`
* 安装完整工具包（非常大，建议先迁移）
	* `sudo apt install kali-linux-large`

还有一个top10的工具包，太离谱就不用了，直接装标准就行，反正后续自己装

# 配置声音
kali自带播放器和声音相关包，只是初始可能不运行
目前的方案是
```bash
（1）在终端执行命令：systemctl --user enable pulseaudio （似乎不运行也行，我的甚至没有systemctl）

（2）在/etc/default/目录下，创建一个文件，命名为pulseaudio，并添加以下内容：
PULSEAUDIO_SYSTEM_START=1
DISALLOW_MODULE_LOADING=0
```

重启系统，就有声音了  
PS: 这声音系统时好时坏，配置应该是没问题，时不时dbus启动不了，不知道为什么，重启又能解决

# 配置输入法
[Kali Linux 安装配置中文输入法 Fcitx5_kali fcitx-CSDN博客](https://blog.csdn.net/weixin_43681778/article/details/122562249)
fcitx容易出bug，还是用fcitx5吧
