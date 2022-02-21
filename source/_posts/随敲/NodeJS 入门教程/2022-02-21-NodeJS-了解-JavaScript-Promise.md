---
title: NodeJS | 了解 JavaScript Promise
tags: NodeJS
categories:
  - 随敲
  - NodeJS
date: 2022-02-21 22:52:47
---

## Promise 简介

Promise 通常被定义为 **最终会变为可用值的代理**

Promise 是一种处理异步代码同时规避掉回调地狱的方式。

多年来，promise 已成为语言的一部分（在 ES2015 中进行了标准化和引入），并且最近变得更加集成，在 ES2017 中具有了 async 和 await。

**异步函数**在底层使用了 promise，因此了解 promise 的工作方式是了解 `async` 和 `await` 的基础。

<!-- more -->

## Promise 如何运作
