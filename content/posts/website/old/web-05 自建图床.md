---
title: web-05 自建图床
draft: false
date: 2024-03-22T11:33:37+08:00
lastmod: 2024-03-22T11:33:37+08:00
categories: [website]
tags:
  - github
  - picbed
series: [OldWebsite]  
series_order: 5
description: 如何用GitHub白嫖无数个1G图床

---
## 图床搭建
1. 登录你的 Github 之后，创建一个新的仓库
![](https://pic3.zhimg.com/80/v2-bdae2009a14221c498dbde14714f951e_1440w.webp)
2. 填写仓库先关资料，一般只需要选一个合适的仓库名，然后确保仓库为 `public` 其他的保持默认就好
![](https://pic4.zhimg.com/80/v2-79c5e7f0d53bf92b27ade85b244aadcf_1440w.webp)
3. 一般创建成功之后，会出现如下界面，至此，我们的图床算是创建好了，接下来就是如何上传图片了；
![](https://pic3.zhimg.com/80/v2-569e9028620c1d14a8e92dc58647b506_1440w.webp)

## 上传图片

通过上面的步骤，我们的图床时搭建好了，但是通过传统的方法向 Github 上传图片太麻烦了，这里我们推荐使用一个开源图床工具 [PicGo](https://link.zhihu.com/?target=https%3A//molunerfinn.com/PicGo/) 来作为我们的图片上传工具；

PicGo 的安装就不说了，去他的 [官网](https://link.zhihu.com/?target=https%3A//molunerfinn.com/PicGo/) 下载对应版本进行安装即可，我们主要讲讲如何用它来上传图片。安装后，打开软件其主页面如下：

![](https://pic2.zhimg.com/80/v2-16147bc5d47b3fb6aad2e4fd628dbd25_1440w.webp)


接下来就是配置 PicGo 的过程了。

1. 首先，我们先要去 Github 创建一个 token；

以此打开 `Settings -> Developer settings -> Personal access tokens -> token(classic)`，最后点击 `generate new token`；

2. 填写目的，记得勾选repo选项让token有权访问和修改仓库，然后点击 `Genetate token` 即可；

3. `token` 生成，注意它只会显示一次，所以你最好把它复制下来到你的备忘录存好，方便下次使用，否则下次有需要重新新建；
![](https://pic4.zhimg.com/80/v2-3044094ad71f2ec6b86aa3be0881fec7_1440w.webp)

4. 配置 PicGo，依次打开 图床设置 -> Github 图床；

![](https://pic1.zhimg.com/80/v2-04accf30607158803f5164fdd2b834c0_1440w.webp)

5. 填写相关信息，最后点击 `确定`即可，要将其作为默认图床的话，点击设为默认图床； 
这里最好还是选择一个文件夹专门存放图片，或者也可以通过修改指定的存储路径实现分类存储
![](https://pic3.zhimg.com/80/v2-d417deedd8102f93d2375a1e89d13b52_1440w.webp)

6. 上传图片，通过上传区上传即可（Ctrl V 或者将图片拖拽都可以），也可以通过快捷键的方式
由于网络问题可能需要打开代理来上传，但是部分代理不提供安全的协议，会被拒绝访问

## 后续维护
由于一些原因图床不能通过前端简单的删除图片，所以很容易产生大量冗余
而GitHub在仓库大小达到1G时就有可能会进行人工审查，对账号安全有威胁
所以最好定时用GitHub desktop克隆下来，维护后再强制push上去
等大小差不多了就重开一个repo，反正可以无限开