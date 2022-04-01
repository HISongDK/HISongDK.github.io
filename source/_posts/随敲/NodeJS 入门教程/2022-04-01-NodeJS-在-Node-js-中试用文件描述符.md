---
title: NodeJS | 在 Node.js 中试用文件描述符
tags: NodeJS
categories:
    - 随敲
    - NodeJS
date: 2022-04-01 23:16:38
---

在与位于文件系统的文件交互前，需要先获取文件的描述符。

文件描述符是使用 `fs` 模块的 `open` 方法打开文件后返回的：

```js
const fs = require('fs')
fs.open('/Users/joe/test.txt', 'r', (err, fd) => {
    // fd 是文件描述符。
})
```

注意，将 `r` 作为 `fs.open()` 调用的第二个参数。

该标志意味着打开文件用于读取。

其他常用的标志有：

-   `r+` 打开文件用于读写
-   `w+` 打开文件用于读写，将流定位到文件的开头。如果文件不存在则创建文件。
-   `a` 打开文件用于写入，将流定位到文件的末尾。如果文件不存在则创建文件。
-   `a+` 打开文件用于读写，将流定位到文件的末尾。如果文件不存在则创建文件。

也可以使用 `fs.openSync()` 方法打开文件，该方法会直接返回文件描述符，不是在回调中提供：

```js
const fs = require('fs')

try {
    const fd = fs.openSync('/Users/joe/test.txt', 'r')
} catch (err) {
    console.error(err)
}
```

一旦获得文件描述符，就可以用任何方式执行所有需要它的操作，例如调用 `fs.open()` 和许多与文件系统交互的操作。
