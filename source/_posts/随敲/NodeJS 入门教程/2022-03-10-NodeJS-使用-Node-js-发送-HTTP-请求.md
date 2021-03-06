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

## 执行 POST 请求

```js
const https = require('https')
const data = JSON.stringify({
    todo: '做点事情',
})

const options = {
    hostname: 'nodejs.cn',
    port: 443,
    path: '/todos',
    method: 'POST',
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

req.on('error', (err) => {
    console.log(err)
})

req.write(data) // 这又是什么稀奇古怪的方法
req.end()
```

## PUT 和 DELETE

PUT 和 DELETE 请求使用相同的 POST 请求格式，只需要改 `options.method` 的值即可。
