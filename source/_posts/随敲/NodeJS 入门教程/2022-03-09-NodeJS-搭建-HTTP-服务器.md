---
title: NodeJS | 搭建 HTTP 服务器
tags: NodeJS
categories:
    - 随敲
    - NodeJS
date: 2022-03-09 20:26:20
---

这是一个简单的 HTTP web 服务器示例：

```js
const http = require('http')
const port = 3000

const server = http.createServer((req, res) => {
    res.statusCode = 200
    res.setHeader('Content-Type', 'text/plain')
    res.end('你好世界\n')
})

server.listen(port, () => {
    console.log(`服务器运行在 http://${hostname}:${port}`)
    // 欸！才知道还有 hostname 这个全局变量么这是
})
```

<!-- more -->

简要分析一下，这里引入了 `http` 模块。

使用该模块来创建 HTTP 服务器。

服务器被设置为在指定的 3000 端口监听。当服务器就绪，则 `listen` 函数会被调用。

传入的回调函数会在每次接收到请求时执行 <!-- 是说的 createServer 的回调啊，我还以为书接上文指的是 listen 的回调呢 -->。每当接受到新请求，`request` 事件会被调用，并提供两个对象：一个请求 `http.IncomingMessage` 对象，和一个 `http.SeverResponse` 对象。

`request` 提供了请求的详细信息。通过它可以访问请求头和请求的数据。
`response` 用于构建要返回给客户端的数据。

在此示例中：

```js
res.statusCode = 200
```

设置 statusCode 属性为 200，以表明相应成功。

还设置了 Content-Type 响应头：

```js
res.setHeader('Content-Type', 'text/plain')
```

最后结束关闭响应，将内容作为参数添加到 `end()`

```js
res.end('你好世界\n')
```
