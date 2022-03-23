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
