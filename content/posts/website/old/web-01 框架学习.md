---
title: web-01 hexo框架
draft: false
date: 2024-03-12T19:58:24+08:00
lastmod: 2024-03-12T19:58:24+08:00
categories: [website]
tags:
  - web
  - hexo
  - git
  - pages
series: [OldWebsite]  
series_order: 1
description: hexo框架学习

---


# git学习
由于github是基于git的网站，所以熟练运用git是必不可少的
无论你使用什么框架，最后还是要用git上传和部署

# hexo框架安装
考虑到与时俱进，直接去hexo官网看文档就行，反正也有中文
[文档 | Hexo](https://hexo.io/zh-cn/docs/index.html)
* 注意前置安装node.js和附属的npm

# hexo框架部署
## 部署hexo
* hexo作为一个框架可以非常方便地根据设计数据生成网站并上传到github
* 应当将hexo视为一个生成器，可以为其安排一个repo，但是最好不要放在GitHub pages 的repo里，虽然可以指定一个branch生成页面，但是两个branch完全不同是违背git的初衷的，可以考虑为这个框架单独开一个repo 

依旧讲究与时俱进，看文档吧 [建站 | Hexo](https://hexo.io/zh-cn/docs/setup)
* 该文档内介绍了hexo框架下的部分文件夹的作用
### 基本操作
* 在电脑上挑个喜欢的位置，准备创建一个文件夹储存框架
* 打开命令行，开始操作
```shell
# 跳转到目录位置
cd "<file folder you'd like to put the folder in>"
# 创建工作目录
hexo init <folder> # hexo初始化
cd <folder>
npm install # 安装npm
```

## 配置hexo
**可以自定义配置很多内容，这里只挑出现问题的讲**
本质上不用急着配置，到时候准备好设计网站的时候再一起配置
[配置 | Hexo](https://hexo.io/zh-cn/docs/configuration)

### 配置网址
> 众所周知的是github pages创建的静态网站域名有固定的设置，即
> \<username\>.github.io
> 如果你想要分开部署多个网站，github并不提供三级域名，像
> \<another name\>.\<username\>.github.io
> 而是通过域名下级目录的形式实现，即
> \<username\>.github.io/\<repo name\>

* 如果我们依旧以最初仓库的方法部署这个项目仓库的github pages，将会导致css等文件无法读取，网页渲染只剩下字和链接，格式全没了；
* 而且链接的格式也是错误的，当你点击链接时，会发现原本应该是
  .../\<repo name\>/.../index.html 的链接其实是
  .../.../index.html，根本就没有到项目目录下寻找文件

所以我们需要设置网址相关参数
* url: 改为指定的github pages的域名
* root: 可以不改，目的是解决网站没有部署在根目录上的问题

## 安装主题
### 方法1——npm(推荐)
```shell
npm i hexo-theme-butterfly
```
hexo的主题文件夹将被放在node_modules里
### 方法2——git
[Themes | Hexo](https://hexo.io/themes/)
**hexo的主题就放在框架目录的themes里面**
一般来说主题的发布者都会非常善良地让你一条命令解决问题
只需要呆在根目录，输入
```shell
git clone <branch and url> themes/<name>
```
如果要更新主题，进入主题的文件夹然后git pull即可

**安装主题和下载文件没有本质区别，你可以下载多个主题一个一个尝试**
当你想要使用某个主题时，只要到hexo框架的_config.yml里修改theme参数即可
这个参数本质上是你下载到themes文件夹里的文件夹名，可以自己取名

### 建议
在项目的根目录下复制一个butterfly的_config.yml文件并重命名为_config.butterfly.yml
框架将会优先读取根目录下的config,这样方便升级主题版本

# hexo框架使用
现在终于可以开始创建第一个网站了，当然现在还只是部署在本地
## 开始写作
[写作 | Hexo](https://hexo.io/zh-cn/docs/writing)
hexo写作本质上只是给md（或者其他格式的）文件添加了一些标识而已，在掌握了基本法则后你并没有太大必要调用命令行去生成一个文件再去修改，你可以自己创建文件然后写标识
**俗话说，条条大路通罗马，只要结果一样，怎么做是自己的自由**

```shell
# 基本方法
hexo new [layout] title
# layout默认为post
# 这个命令将会在相应的目录生成一个对应layout的文件
# layout本质上就是指定scaffolds文件夹里的模板，这个模板我们可以自己设计
```
**不同的主题有不同的编写方式和显示逻辑，建议多看看主题的文档**

## 生成网页
通过命令`hexo generate`或者`hexo g`生成网页

## 展示网页
通过命令`hexo server`或`hexo s`启用本地服务器展示网页
默认的访问网址为`http://localhost:4000/`，ctrl+点击即可打开
当然当你[[web-01 框架学习#配置网址|配置了特殊网址]]时，这个网址也会随之变化

