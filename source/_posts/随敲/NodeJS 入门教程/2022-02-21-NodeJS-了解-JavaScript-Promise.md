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

### Promise 如何运作

当 promise 被调用时，它会以 **处理中状态开始**，这意味着函数会继续执行，而 promise 仍处于处理中直到解决为止，从而为调用的函数提供所请求的任何数据。

被创建的 promise 最终会以 **被解决状态** 或 **被拒绝状态** 结束,并在完成时调用相应的回调函数（传给 `then` 和 `catch` ）。

### 哪些 JS API 使用了 Promsie？

除了自己的代码和库代码，标准的现代 Web API 也使用了 promise，例如：

1. Battery API
2. Fetch API
3. Service Worker

在现代 JavaScript 中，不太可能没有使用 promise，因此让我们开始深入研究它们

---

## 创建 Promise

Promise API 公开了一个 Promise 构造函数，可以使用 `new Promise()` 对其进行初始化：

```js
let done = true
const isItDoneYet = new Promise((reslove, reject) => {
  if (done) {
    const workDone = '这是创建的东西'
    resolve(workDone)
  } else {
    const why = '仍然在处理其他事情'
    reject(why)
  }
})
```

如你所见，promise 检查了全局变量 `done` ,如果为真，则 promise 进入 **被解决** 状态（因为调用了 `resolve` 回调）;否则，则执行 `reject` 回调，将 promise 状态改为被拒绝。如果在执行路径中从未调用过这些函数之一，则 promise 会保持处理中状态。

使用 `resolve` 和 `reject` ，可以向调用者传达最终的 promise 状态以及该如何处理。在上述示例中只返回一个字符串，但是它可以是一个对象，也可以是 `null` 。由于已经在上述的代码片段中创建了 promise，因此它已经开始执行。这对了解下面的 `消费promise` 章节很重要。
