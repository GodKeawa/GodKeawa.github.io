---
title: web-06 国内网络加速
draft: false
date: 2024-03-23T17:51:31+08:00
lastmod: 2024-03-23T17:51:31+08:00
categories: [website]
tags:
  - cloudflare
  - github
  - vercel
  - twikoo
  - picbed
  - web
series: [OldWebsite]  
series_order: 6
description: 如何白嫖cloudflare实现国内访问加速

---
## 开启cloudflare
1. 打开cloudflare官网，照着提示做，把自己的域名交给cloudflare管理即可，选免费计划  
	这里比较技术性的就只有修改自己域名的namesevers，这个得看你在哪买的域名  
	总之cloudflare会为你提供两个namesever  

2. 之后去域名管理那里改掉namesever即可，注意只能保留这两个，其他全删掉  
稍等一段时间就能看到自己的域名已经在cloudflare上有效了  
后续你的域名就可以在cloudflare上管理了，只有续费需要回到购买域名的地方  
## 写在前面
记得把之前的域名都改成新设的自定义域名，不然会有未知错误  
虽然访问原域名大部分时候也会重定向到新域名  
## github pages配置
1. 去到dns设置，一般来说cloudflare可以检测到大部分过去的dns选项，如果没有就再设置一次  
github一共五个dns配置  
四个A类型的，指向github的185.199系列ip  
一个cname类型的，指向过去分配的github pages 地址  

1. 去到github项目配置，选settings，进入pages页，在最下面添加自己的域名即可  
github会自动进行dns检测，如果上一步没问题应该可以显示dns配置正常  
然后可以打开强制https，GitHub会帮你到Let's Encrypt申请一个SSL证书，这样与你的网站的连接就都是加密的，浏览器也不会显示危险网页了  

1. 虽然github会自动为你的repo添加一个cname文件，使得你不用自行操作，但是每次部署都要来设置一次自定义域名  

## twikoo配置
没什么难度，dns配置见上图，就两个  
* 一个是A类型的指向vercel的国内专供ip`76.223.126.88`  
* 一个是cname指向vercel的国内专供dns地址`cname-china.vercel-dns.com  

然后到vercel上给项目绑定个新域名，dns检查通过就行，vercel上只用绑定一次  

记得改一下配置文件的envId  

## picbed配置
picbed用cloudflare有点技术活，需要使用cloudflare提供的worker  

1. 登录到 Cloudflare 的管理界面后，点击侧边栏的 “Workers” 选项，然后点击 “创建服务” 创建一个 Worker，现在似乎会提供一个helloworld的例子，无所谓，直接选helloworld修改也行  
 
如果是直接创建记得选http处理程序服务  
给worker取个名字，部署，然后进入修改代码  

2. 将下面的代码复制粘贴到编辑页面的代码编辑器中  
注意修改两个路径，一个是代理路径，一个是token，注释里有写  
```js
/**
 * Welcome to Cloudflare Workers! This is your first worker.
 *
 * - Run "npm run dev" in your terminal to start a development server
 * - Open a browser tab at http://localhost:8787/ to see your worker in action
 * - Run "npm run deploy" to publish your worker
 *
 * Learn more at https://developers.cloudflare.com/workers/
 */

// Website you intended to retrieve for users.
const upstream = "raw.githubusercontent.com";

// Custom pathname for the upstream website.
// (1) 填写代理的路径，格式为 /<用户>/<仓库名>/<分支>
const upstream_path = "/GodKeawa/picbed/main";

// github personal access token.
// (2) 填写github令牌
const github_token = "<your token>";

// Website you intended to retrieve for users using mobile devices.
const upstream_mobile = upstream;

// Countries and regions where you wish to suspend your service.
const blocked_region = [];

// IP addresses which you wish to block from using your service.
const blocked_ip_address = ["0.0.0.0", "127.0.0.1"];

// Whether to use HTTPS protocol for upstream address.
const https = true;

// Whether to disable cache.
const disable_cache = false;

// Replace texts.
const replace_dict = {
  $upstream: "$custom_domain",
};

addEventListener("fetch", (event) => {
  event.respondWith(fetchAndApply(event.request));
});

async function fetchAndApply(request) {
  const region = request.headers.get("cf-ipcountry")?.toUpperCase();
  const ip_address = request.headers.get("cf-connecting-ip");
  const user_agent = request.headers.get("user-agent");

  let response = null;
  let url = new URL(request.url);
  let url_hostname = url.hostname;

  if (https == true) {
    url.protocol = "https:";
  } else {
    url.protocol = "http:";
  }

  if (await device_status(user_agent)) {
    var upstream_domain = upstream;
  } else {
    var upstream_domain = upstream_mobile;
  }

  url.host = upstream_domain;
  if (url.pathname == "/") {
    url.pathname = upstream_path;
  } else {
    url.pathname = upstream_path + url.pathname;
  }

  if (blocked_region.includes(region)) {
    response = new Response(
      "Access denied: WorkersProxy is not available in your region yet.",
      {
        status: 403,
      }
    );
  } else if (blocked_ip_address.includes(ip_address)) {
    response = new Response(
      "Access denied: Your IP address is blocked by WorkersProxy.",
      {
        status: 403,
      }
    );
  } else {
    let method = request.method;
    let request_headers = request.headers;
    let new_request_headers = new Headers(request_headers);

    new_request_headers.set("Host", upstream_domain);
    new_request_headers.set("Referer", url.protocol + "//" + url_hostname);
    new_request_headers.set("Authorization", "token " + github_token);

    let original_response = await fetch(url.href, {
      method: method,
      headers: new_request_headers,
      body: request.body,
    });

    let connection_upgrade = new_request_headers.get("Upgrade");
    if (connection_upgrade && connection_upgrade.toLowerCase() == "websocket") {
      return original_response;
    }

    let original_response_clone = original_response.clone();
    let original_text = null;
    let response_headers = original_response.headers;
    let new_response_headers = new Headers(response_headers);
    let status = original_response.status;

    if (disable_cache) {
      new_response_headers.set("Cache-Control", "no-store");
    } else {
      new_response_headers.set("Cache-Control", "max-age=43200000");
    }

    new_response_headers.set("access-control-allow-origin", "*");
    new_response_headers.set("access-control-allow-credentials", "true");
    new_response_headers.delete("content-security-policy");
    new_response_headers.delete("content-security-policy-report-only");
    new_response_headers.delete("clear-site-data");

    if (new_response_headers.get("x-pjax-url")) {
      new_response_headers.set(
        "x-pjax-url",
        response_headers
          .get("x-pjax-url")
          .replace("//" + upstream_domain, "//" + url_hostname)
      );
    }

    const content_type = new_response_headers.get("content-type");
    if (
      content_type != null &&
      content_type.includes("text/html") &&
      content_type.includes("UTF-8")
    ) {
      original_text = await replace_response_text(
        original_response_clone,
        upstream_domain,
        url_hostname
      );
    } else {
      original_text = original_response_clone.body;
    }

    response = new Response(original_text, {
      status,
      headers: new_response_headers,
    });
  }
  return response;
}

async function replace_response_text(response, upstream_domain, host_name) {
  let text = await response.text();

  var i, j;
  for (i in replace_dict) {
    j = replace_dict[i];
    if (i == "$upstream") {
      i = upstream_domain;
    } else if (i == "$custom_domain") {
      i = host_name;
    }

    if (j == "$upstream") {
      j = upstream_domain;
    } else if (j == "$custom_domain") {
      j = host_name;
    }

    let re = new RegExp(i, "g");
    text = text.replace(re, j);
  }
  return text;
}

async function device_status(user_agent_info) {
  var agents = [
    "Android",
    "iPhone",
    "SymbianOS",
    "Windows Phone",
    "iPad",
    "iPod",
  ];
  var flag = true;
  for (var v = 0; v < agents.length; v++) {
    if (user_agent_info.indexOf(agents[v]) > 0) {
      flag = false;
      break;
    }
  }
  return flag;
}
```

3. 保存后部署运行
cloudflare worker一天的免费请求额度是100000，也就是说支持一天提供一共100000次的图片加载或上传，可以说是太够用了  

4. 最后给worker一个自定义域名  
- 在 Worker 服务的详情页点击“触发器”，然后点击“添加自定义域”。  
- 输入想要绑定的域名后，点击“添加自定义域”。  
	- cloudflare会自动为你添加一个dns解析，可以说是十分的防傻了  
- cloudflare还会为你的图床域名提供SSL，生成需要一段时间，等待生成变为有效状态，到这里，Cloudflare的配置就完成了  

5. 现在去picgo上配置一下自定义域，以后就不用开代理上传了，国内网络也可以直接访问到图片了，不过steam++的加速会导致SSL证书错误，这好像是steam++加速的问题，不开就行  