---
title: web-08 SSL证书问题处理
draft: false
date: 2024-06-05T13:17:34+08:00
lastmod: 2024-06-05T13:17:34+08:00
categories: [website]
tags:
  - github
  - web
series: [OldWebsite]  
series_order: 8
description: cloudflare代理与GitHub水火不容

---
众所周知啊，现在的浏览器对没有SSL证书的网站都是直接报不安全的，像华为和一些软件的内置浏览器直接就禁止访问了，所以要给网站加自定义域名，就得给域名申请一个SSL证书

GitHub pages很好地迎合了这个需求，和Let's Encrypt合作，可以免费为GitHub pages的自定义域名申请证书并自动续费，但是前提是域名必须直接指向GitHub的服务器  
也就是说GitHub只有确定了你的域名真的是给GitHub pages用的，才会为你申请证书

但是当我们把域名挂到cloudflare上后，因为cloudflare提供了一层cdn服务，所以如果查dns，查到的是cloudflare的cdn服务器ip，这就导致GitHub不认了，于是证书申请不下来，一直卡着
可以在powershell里使用命令`nslookup <url>`查询dns

去搜索了一下，根据前人的经验[GitHub Pages HTTPS证书自动签发错误解决 | Heary's Blog](https://heary.cn/posts/GitHub-Pages-HTTPS%E8%AF%81%E4%B9%A6%E8%87%AA%E5%8A%A8%E7%AD%BE%E5%8F%91%E9%94%99%E8%AF%AF%E8%A7%A3%E5%86%B3/)
目前有两种解决方案
* 一是直接取消cloudflare与GitHub间的SSL，反正用户是通过cloudflare的中介访问网站，用户到cloudflare总是有SSL证书的，只是cloudflare访问GitHub没有证书，用http其实也无伤大雅
* 二是关闭cloudflare的cdn加速，让GitHub成功申请

前人的博客中提供了一种方案，经检验大概是可行的，dns查询确实没问题了，但是半天申请也没通过  
但是实际上不需要这么多操作，cloudflare似乎也没有一键关闭代理，一通操作麻烦得很  

因为我们是在namesilo买的域名，而namesilo提供免费的dns服务，所以我们直接去namesilo把dns解析服务商先改了，等十分钟再去申请，几乎马上就通过了，然后再把dns服务商改回cloudflare就好  

这一招偷梁换柱非常方便，只是证书只有3个月，每三个月都得花点时间申请，有点难绷  
