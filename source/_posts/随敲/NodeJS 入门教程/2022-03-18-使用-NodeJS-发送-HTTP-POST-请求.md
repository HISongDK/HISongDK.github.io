---
title: 使用 NodeJS | 发送 HTTP POST 请求
tags: NodeJS
categories:
    - 随敲
    - NodeJS
date: 2022-03-18 00:42:59
---

在 nodejs 中可以使用多种方式执行 HTTP POST 请求，具体要取决于要使用的抽象级别。

使用 Node.js 执行 HTTP 请求，最简单的方式是使用 Axios 库：

```js
const axios = require('axios')

axios
    .post('http://nodejs.cn/todos', {
        todo: '做点事情',
    })
    .then((res) => {
        console.log(`${状态码}`)
        console.log(res)
    })
    .catch((err) => {
        console.error(error)
    })
```

Axios 需要使用第三方库。

<!-- more -->

也可以只使用 Node.js 的标准模块来发送 POST 请求，尽管它比前面的选择冗长些：

```js
const https = require('https')
const data = JSON.stringify({ todo: 'doSomething' })

const options = {
    hostname: 'nodejs.cn',
    post: 443,
    path: '/todos',
    methods: 'POST',
    headers: {
        'Content-Type': 'application/json',
        'Content-Length': data.length,
    },
}

const req = https.request(options, (res) => {
    console.log(`状态码：${res.statusCode}`)

    res.on('data', (d) => {
        process.stdout.write(d)
    })
})

req.on('error', (error) => {
    console.log(error)
})

req.write(data)
req.end()
```
