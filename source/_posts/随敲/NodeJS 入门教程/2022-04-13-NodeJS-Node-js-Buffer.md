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
