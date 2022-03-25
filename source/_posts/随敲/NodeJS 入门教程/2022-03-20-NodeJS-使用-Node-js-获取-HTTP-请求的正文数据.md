---
title: NodeJS | 使用 Node.js 获取 HTTP 请求的正文数据
tags: NodeJS
categories:
    - 随敲
    - NodeJS
date: 2022-03-20 23:50:28
---

这是在请求正文中提取以 json 格式发送的数据的方式。

如果使用的是 Express，则非常简单：使用 `body-parser` Node.js 模块。

<!-- more -->

例如，获取此请求的正文：

```js
const axios = require('axios')
axios.post('http://nodejs.cn/todos', {
    todo: '做点事情',
})
```

这是对应的服务器端代码：

```js
const express = require('express')
const app = express()

app.use(express.urlencoded({ extended: true }))
app.use(express.json())

app.post('/todos', (req, res) => {
    console.log(req.body.todo)
})
```

如果不使用 Express 并想在普通的 Node.js 中执行此操作，则需要多做一点工作，因为 Express 抽象了很多工作。

要理解的关键是，当使用 `http.createServer()` 初始化 HTTP 服务器时，服务器会在获得所有 HTTP 请求头时调用回调，而不是请求正文时。

在连接回调中传入的 `request` 对象是一个流。

因此，必须监听要处理的主题内容看，并且时按数据块处理的。

首先，通过监听流的 `data` 事件来获取数据，然后在数据结束时调用一次流的 `end` 事件：

```js
const server = http.createServer((req, res) => {
    // 可以访问 HTTP 请求头时调用回调
    req.on('data', (chunk) => {
        console.log(`可用的数据块${chunk}`)
    })
    req.on('end', () => {
        // 数据结束
    })
})
```

因此，若想要访问数据（假设期望接收到字符串）,则必须将其放入数组中：

```js
const server = http.createServer((req, res) => {
    let data = ''
    req.on('data', (chunk) => {
        data += chunk
    })
    req.on('end', () => {
        JSON.parse(data).todo // ‘做点事情’
    })
})
```
