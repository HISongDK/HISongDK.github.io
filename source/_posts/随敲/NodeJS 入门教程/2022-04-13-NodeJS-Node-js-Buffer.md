---
title: NodeJS | Node.js Buffer
tags: NodeJS
categories:
    - 随敲
    - NodeJS
date: 2022-04-13 23:31:03
---

## 什么是 Buffer?

Buffer 是内存区域。JavaScript 开发者可能对这个概念并不熟悉，比每天与内存交互的 C、C++ 或 Go 开发者（或使用系统编程语言的任何程序员）要少得多。

它表示 V8 JavaScript 引擎外部分配的固定大小的内存块（无法调整大小）

可以将 buffer 视为整数数组，每个整数代表一个数据字节。

它由 Node.js Buffer 类实现。

<!-- more -->

## 为什么需要 buffer

Buffer 用以处理二进制数据，传统只是处理字符串而非二进制数据。

Buffer 与流紧密相连。当流处理器接受数据的速度快于消化的速度时，则会将数据放入 buffer 中。

一个简单的场景是：当观看 YouTube 视频时，红线超过了观看点：即下载数据的速度比查看数据的速度快，浏览器会对数据进行缓冲。

## 如何创建 buffer

使用 `Buffer.from()` 、`Buffer.alloc()` 和 `Buffer.allocUnsafe()` 方法可以创建 buffer。

```js
const buf = Buffer.from('Hey!')
```

-   `Buffer.from(array)`
-   `Buffer.from(arrayBuffer[,byteOffset[,length]])`
-   `Buffer.from(buffer)`
-   `Buffer.from(string[,encoding])`

也可以只初始化 buffer （传入大小）。以下会创建一个 1KB 的 buffer：

```js
const buf = Buffer.alloc(1024)
const buf = Buffer.allocUnsafe(1024)
```

虽然 `alloc` 和 `allocUnsafe` 均分指定大小的 `Buffer` (以字节为单位),但是 `alloc` 创建的 `Buffer` 会被使用 0 进行初始化，而 `allocUnsafe` 创建的 `Buffer` 不会被初始化。这意味着，尽管 `allocUnsafe` 比 `alloc` 要快得多，但是分配的内存片段可能包含敏感的旧数据。

当 `Buffer` 内存被读取时，如果内存中存在较旧的数据，则可以被访问或泄露。这就是真正使 `allocUnsafe` 不安全的原因，在使用它时必须格外小心。
