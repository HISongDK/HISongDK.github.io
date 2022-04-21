---
title: NodeJS | Node.js 流
tags: NodeJS
categories:
    - 随敲
    - NodeJS
date: 2022-04-20 23:03:12
---

## 什么是流

流是为 Node.js 应用程序提供动力的基本概念之一。

它们是以一种高效的方式处理读/写文件、网络通信、或任何类型的端到端的信息交换。

流不是 Node.js 特有的概念。它们是几十年前在 Unix 操作系统中引入的，程序可以通过管道运算符（`|`）对流进行相互交互。

例如，在传统的方式中，当告诉程序读取文件时，这将会将文件从头到尾读入内存，然后进行处理。

使用流，则可以逐个片段的读取并处理（而无需全部保存在内存中）

Node.js 的 `stream` 模块提供了构建所有流 API 的基础。所有的流都是 `EventEmitter` 的实例。

## 为什么是流

相对于使用其他的数据处理方法，流基本上提供了两个主要有点：

-   `内存效率` 无需加载大量的数据到内存中即可处理。
-   `时间效率` 当获得数据之后即可立即处理数据，这样所需的时间更少，而不必等到整个数据有效负载可用才开始

## 流的示例

一个典型的例子是从磁盘读取文件。

使用 Node.js 的 `fs` 模块，可以读取文件，并在与 HTTP 服务器建立新连接时通过 HTTP 提供文件：

```js
const http = require('http')
const fs = require('fs')

const server = http.createServer((req, res) => {
    fs.readFile(__dirname + '/data.txt', (err, data) => {
        res.end(data)
    })
})
```

`readFile()` 读取文件的全部内容，并在完成时调用回调函数。

回调中的 `res.end(data)` 会返回文件的内容给 HTTP 客户端。

如果文件很大，则该操作会花费较多的时间。以下是使用流编写的相同内容。

```js
const http = require('http');
const fs = require('fs');

const server = http.createServer((req, res) =>{
	const stream = fs.createReadStream(__dirname + '/data.txt)
	stream.pipe(res);
})
```

当要发送的数据块已获得时就立即开始将其流式传输到 HTTP 客户端，而不是等待文件被完全读取。

## pipe()

上面的示例使用了 `stream.pipe(res)` 这行代码：在文件流上调用 `pipe()` 方法。

改行代码的作用是什么？它获取来源流，并通过管道将其传输到目标流。

在来源流上调用它，在该示例中，文件通过管道传输到 HTTP 响应。

`pipe()` 方法的返回值是目标流，这是非常方便的事情，它使得 `pipe()` 可以链式调用，如下所示：

```js
src.pipe(dest1).pipe(dest2)
```

此构造相对于:

```js
src.pipe(dest1)
dest1.pipe(dest2)
```
