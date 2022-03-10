---
title: NodeJS | 使用 Node.js 发送 HTTP 请求
tags: NodeJS
categories:
    - 随敲
    - NodeJS
date: 2022-03-10 23:25:24
---

## 执行 GET 请求

```js
const https = require('https')
const options = {
    hostname: 'nodejs.cn',
    port: 443,
    path: '/todos',
    method: 'GET',
}

const req = https.request(options, (res) => {
    console.log(`状态码：${res.statusCode}`)

    res.on('data', (d) => {
        // TODO:这个标准输出是具体怎么样呢，我怎么以为是 console.log 一样
        process.stdout.write(d)
    })
})

req.on('error', (err) => {
    console.error(err)
})

req.end()
```
