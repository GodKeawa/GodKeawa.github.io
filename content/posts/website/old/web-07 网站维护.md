---
title: web-07 网站维护
draft: false
date: 2024-03-25T16:22:31+08:00
lastmod: 2024-03-25T16:22:31+08:00
categories: [website]
tags:
  - github
  - obsidian
  - web
series: [OldWebsite]  
series_order: 7
description: 如何方便地维护网站
---

## 网站资源问题
非常值得庆幸的是目前网站所有资源都在本地有备份，图床也是自己的，还在阿里云有个私人备份，但是由于链接的网址问题，后续如果换了域名就得全局修改，不过vscode有全局替换功能，就是不知道会不会出什么幺蛾子，目前来说网站的资源还是比较稳定的，至少本地都有留档

## 文章管理问题 
博客的维护问题根本上还是在于有没有意愿去写，如果写着不舒服就很难维持更新  
考虑到自己已经长期使用obsidian做笔记管理，所以就去看了看有没有相关先辈，学了点东西  

目前的工作流细节大概是：
* 在网站框架根目录套一个obsidian的壳，让obsidian可以管理整个根目录
* 使用Hide folders插件隐藏掉没用的文件或文件夹
* 使用image auto upload插件实现与picgo的联动，全自动上传和粘贴链接
* 使用obsidian自带的模板功能实现front-matters的载入
* 使用obsidian git插件将框架整个上传到github上

待选：
* 使用GitHub Actions自动部署
	* 问题是还是要自行绑定域名，而且部署速度很慢，容易出bug

由于hexo可以随时重新生成网页，所以文章的修改啥的还是很方便的