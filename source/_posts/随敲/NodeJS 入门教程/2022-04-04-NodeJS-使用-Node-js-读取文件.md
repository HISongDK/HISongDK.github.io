---
title: NodeJS | 使用 Node.js 读取文件
tags: NodeJS
categories:
    - 随敲
    - NodeJS
date: 2022-04-04 12:40:42
---

在 node.js 中最简单的读取文件的方法是使用 `fs.readFile()` 方法，向其传入文件路径、编码、以及会带上文件数据（以及错误）进行调用的回调函数：

<!-- more -->

```js
const fs = require('fs')

fs.readFile('/etc/passwd', 'utf8', (err, data) => {
    if (err) throw err
    console.log(data)
})
```

另外也可以使用同步版本 `fs.readFileSync()` :

```js
const fs = require('fs')

try {
    const data = fs.readFileSync('/etc/passwd', 'utf-8')
    console.log(data)
} catch (err) {
    console.error(err)
}
```

`fs.rendFile()` 和 `fs.readFileSync` 都会在返回数据之前将文件的全部内容读取到内存中。

这意味着大文件会对内存的消耗和程序执行的速度产生重大影响。

在这种情况下，**更好的选择试使用流来读取文件内容**。
