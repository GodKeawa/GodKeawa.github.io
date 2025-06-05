---
title: WSL-04 开发环境配置
draft: false
date: 2024-04-01T11:30:51+08:00
lastmod: 2024-04-01T11:30:51+08:00
categories: [tech]
tags:
  - vscode
  - Ubuntu
  - pwndbg
series: [WSL]  
series_order: 5
description: 给Ubuntu配置好编译环境

---

# 编译环境
实际上没有什么好配置的，Ubuntu天生就是拿来搞开发的  
直接安装GNU工具链  
`sudo apt install binutils diffutils gcc gdb grep g++ make tar`  
其实就已经差不多了，只是要依赖自己在终端编译运行，习惯就好  
python3现在ubuntu自带的都是3.10.12版本，而且是系统必备库  

偶尔可能出现一些找不到程序的情况，大部分时候谷歌一下再做个软链接就行  
 
然后就是配置一下VScode的插件，大部分都可以直接从windows迁移  
VScode一些配置文件最好也设置一下，方便自定义  
[ubuntu下vscode编写C++环境配置，包括launch.json、tasks.json和c_cpp_properties.json文件说明](https://blog.csdn.net/weixin_41823188/article/details/113530573)  
之后就可以在windows上进行快乐的远程开发了  
# pwndbg
其实考虑了一下，发现这东西应该装在kali里,不过有一个还是挺好的  
一个显著的优点就是可以查看各种更细节的东西了，比如汇编代码，栈和寄存器的内容，且是支持VScode读取的  
未安装pwndbg的情况下，尝试打开寄存器选项会导致gdb直接崩溃  

只要直接clone下来安装就行  
```bash
git clone https://github.com/pwndbg/pwndbg
cd pwndbg
./setup.sh
```
因为pwndbg是python的库，作为gdb的插件，所以安装时会顺便安装python的各种环境，属于是一举两得  
配置好网络就是愉快的一键安装，防傻又好用  


# 坑
* 关于makefile的编写
* 关于Cmake的使用
* 控制台优化——tmux
