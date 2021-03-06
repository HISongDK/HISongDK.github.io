---
title: NodeJS | Node.js 文件系统模块
tags: NodeJS
categories:
    - 随敲
    - NodeJS
date: 2022-04-07 21:57:09
---

`fs` 模块提供了许多非常实用的函数来访问文件系统，并与文件系统进行交互。

无需安装。作为 Node.js 核心的组成部分，可以通过简单地引用来使用它：

```js
const fs = require('fs')
```

一旦这样做就可以访问其所有的方法，包括：

-   `fs.access()` :检查文件是否存在，以及 Node.js 是否有权限访问。
-   `fs.appendFile()`: 追加数据到文件。如果文件不存在，则创建文件
-   `fs.chmod()`: 更改文件的权限（通过传入地文件名指定）。相关方法：`fs.lchmod()` 、`fs.fchmod()`
-   `fs.chown()`: 更改文件的所有者或群组（通过传入地文件名指定）。相关方法：`fs.fchown()` 、`fs.lchmod()` .
-   `fs.close()`: 关闭文件描述符。
-   `fs.copyFile()`: 拷贝文件。
-   `fs.createReadStream()`:创建可读的文件流。
-   `fs.createWriteStream()`:创建可写的文件流。
-   `fs.link()`:新建指向文件的硬链接。
-   `fs.mkdir()`:新建文件夹。
-   `fs.mktemp()`:创建一个临时目录。
-   `fs.open()`:设置文件模式。
-   `fs.readdir()`: 读取目录内容。
-   `fs.readFile()`:读取文件内容。相关方法：`fs.read()`
-   `fs.readlink()`: 读取符号链接的值
-   `fs.realpath()`: 将相对的文件路径指针（`.` 、`..` ）解析为完整的路径。
-   `fs.rename()`: 重命名文件或文件夹。
-   `fs.rmdir()`: 删除文件夹。
-   `fs.stat()`: 返回文件的状态。相关方法：`fs.lstat()` 、`fs.fstat()`
-   `fs.symlink()`: 新建文件的符号链接。
-   `fs.truncate()`: 将文件截断为指定长度。相关方法：`fs.ftruncate()`
-   `fs.unlink()`: 删除文件或符号链接。
-   `fs.unwatchFile()`: 停止监视文件上的更改。
-   `fs.utimes()`: 更改文件的时间戳。相关方法：`fs.futimes()`
-   `fs.watchFile()`: 开始监视文件上的更改。相关方法：`fs.watch()`
-   `fs.writeFile()`: 将数据写入文件。相关方法: `fs.write()`
<!-- 这么些API敲了也记不住 -->

关于 `fs` 模块的特殊之处是，所有的方法默认情况下都是异步的，但是加上 `Sync` 也可以同步工作。

例如：

-   `fs.rename()`
-   `fs.renameSync`
-   `fs.write()`
-   `fs.writeSync()`

这在应用流程中会产生巨大的差异。

> Node.js 10 包含了对基于 promise API 的实验性支持

例如，试验一下 `fs.rename()` 方法。异步的 API 会与回调一起使用:

```js
const fs = require('fs')

fs.rename('before.json', 'after.json', (err) => {
    if (err) {
        return console.error(err)
    }

    // 完成
})
```

同步的 API 则可以这样使用，并使用 try/catch 块来处理错误：

```js
const fs = require('fs')

try {
    fs.renameSync('before.json', 'after.json')
    // 完成
} catch (err) {
    console.error(err)
}
```

此处的主要区别在于，在第二个示例中，脚本的执行过程会阻塞，直到文件操作成功。
