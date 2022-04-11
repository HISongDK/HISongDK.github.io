---
title: NodeJS | Node.js http 模块
tags: NodeJS
categories:
    - 随敲
    - NodeJS
date: 2022-04-11 23:27:09
---

HTTP 核心模块是 Node.js 网络的关键模块。

可以使用以下代码：

```js
const http = require('http')
```

该模块提供了一些属性、方法、以及类。

<!-- more -->

## 属性

### `http.METHODS`

此属性列出了所有支持的 HTTP 方法

### `http.STATUS_CODES`

此属性列出了所有 http 状态码及其描述

### `http.globalAgent`

指向 Agent 对象的全局实例，该实例是 `http.Agent` 类实例。

用于管理 HTTP 客户端连接的持久性和服用，它是 Node.js HTTP 网络的关键组件。

稍后会在 `http.Agent` 类的说明中提供更多的描述。

## 方法

### `http.createServer()`

返回 `http.Server` 类的新实例。

用法：

```js
const server = http.createServer((req, res) => {
    // 使用此回调处理每个单独的请求。
})
```

### `http.request()`

发送 HTTP 请求到服务器，并创建 `http.ClientRequest` 类的实例。

### `http.get()`

类似于 `http.request()` ,但会自动设置 HTTP 方法为 GET，并自动调用 `req.end()`

## 类

HTTP 模块提供了五个类：

-   `http.Agent`
-   `http.ClientRequest`
-   `http.Server`
-   `http.ServerResponse`
-   `http.IncomingMessage`

### `http.Agent`

Node.js 会创建 http.Agent 类的全局实例，以管理 HTTP 客户端的持久性和服用，这是 Node.js HTTP 网络的关键组成部分。

该对象会确保对服务器的每个请求进行排队并且当个 socket 被复用。

他还维护一个 socket 池。出于性能原因，这是关键。
