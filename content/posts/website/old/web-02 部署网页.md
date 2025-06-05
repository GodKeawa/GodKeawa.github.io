---
title: web-02 Github deploy
draft: false
date: 2024-03-14T17:40:59+08:00
lastmod: 2024-03-14T17:40:59+08:00
categories: [website]
tags:
  - hexo
  - git
  - pages
  - github
series: [OldWebsite]  
series_order: 2
description: hexo一键部署

---

网页放在本地服务器上肯定是毫无价值的，所以我们要将它发布到互联网上
方法有很多，最方便的就是白嫖github pages，缺点就是只能部署静态网页
后续可能会部署到树莓派上

## 一键部署
一键部署有很多方法，详细见文档[部署 | Hexo](https://hexo.io/zh-cn/docs/one-command-deployment)
我最喜欢的方法是使用git和一个插件

### 前置工作
* git相关
	* git全局信息设置
	* ssh 和 git-credential
	* http和https可能需要关闭验证机制
* 安装插件
	* 在根目录使用命令`npm install hexo-deployer-git --save`一键安装

### 配置网站
#### 首先要修改一些框架的配置
找到框架_config.yml里的deploy项，修改为：
```yaml
deploy:  
  type: git  
  repo: <repository url> # 你的项目地址，注意不是下载地址，是下载地址去掉.git  
  branch: [branch]  # 决定上传到哪一分支
  message: [message] # 可选，上传的message
```

#### 配置个人仓库
**个人仓库只能有一个**
在github上创建一个repo，取名为`<username>.github.io`
然后就不用管了，把地址复制下来，这时的地址带有.git后缀，可以选择不复制

将地址填入框架配置文件里，并将branch设置为master（默认在这个分支创建网页）
当然也可以设置为其他branch，这就需要在github再进行一次配置

#### 配置项目仓库
**项目仓库可以有无数个**
在github上随便创造一个repo，随便取名
然后就不用管了，但是地址还是要复制下来，注意还是不需要.git后缀

将地址填入框架配置文件里，并将branch设置为gh-pages（默认在这个分支创建网页）
**配置网址**
一般来说网址只要配置相应的url即可
#### 推送到github
因为我们使用了方便的插件，所以操作很简单
* 首先使用`hexo clean`/`hexo cl`清理工作目录，这有利于一些变动的应用，可以多多使用，如果你发现某个改变没有应用上，就清理后再生成
* 然后`hexo g`生成网页
* 再然后你可以使用`hexo s`审视一下自己的网站，也可以不看
* 最后使用`hexo d`一键推送到github

### github设置
来到github就能发现文件已经被上传到了仓库中，这时可以进行一些操作
* 在仓库的settings里点击Pages，可以调整一些网页生成的选项
	* 修改生成依赖的分支
	* 修改生成依赖的目录（如果你想把框架也上传到同一个仓库）
	* 设置自定义域名（前提是你买了）
* 在仓库的Actions中可以看到网页生成的进度和历史，如果网页生成出错了，错误报告也到这里看

### 后续工作
如果熟练的话可以选择将框架也放在仓库中
因为很容易发现实际上框架根目录下有一个文件夹`.deploy_git`,其实这就是上传的内容
但是由于deploy命令具有覆盖性，所以必须要把框架放在另一个branch里
比如创建一个framework的branch，专门保存框架
但是正如之前所言，git的branch不应该完全不同，不然还不如开两个仓库

最好开另一个仓库保存框架，这样命令行用起来舒服
并且后续可以通过GitHub actions自动部署
