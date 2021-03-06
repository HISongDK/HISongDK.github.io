---
title: NodeJS | Node.js 事件循环
tags: NodeJS
categories:
    - 随敲
    - NodeJS
date: 2022-02-08 11:17:09
---

## 介绍

事件循环是了解 Node.js 最重要的方面之一。

为什么这么重要？因为它阐明了 Node.js 如何做到异步并具有非阻塞的 I/O,所以它基本阐明了 Node.js 的“杀手级应用”，正是这一点使他成功了。

Node.js JavaScript 代码运行在单个线程上，每次只处理一件事。

这个限制实际上非常用用，因为它大大简化了编程方式，而不必担心并发问题。

只需要注意如何编写代码，并避免任何可能阻塞线程的事情，例如同步的网络调用或无限的循环。

通常，在大多数浏览器中，每个选项卡都有一个事件循环，以使每个进程隔离开，并避免使用无限的循环或繁重的处理来阻止整个页面。

该环境管理多个并发的事件循环，例如 处理 API 调用。Web 工作进程也运行在自己的事件循环中。

主要需要关心代码在单个事件循环上运行，并且在编写代码时牢记这一点，以避免阻塞它。

<!-- more -->

## 阻塞事件循环

任何花费太长时间才能将控制权返回给事件循环的 JavaScript 代码，都会阻塞页面中任何 JavaScript 代码的运行，甚至阻塞 UI 线程，并且用户无法单击浏览、滚动页面等。

JavaScript 中几乎所有的 I/O 基元都是非阻塞的。网络请求、文件系统操作等。被阻塞是个异常，这就是 JavaScript 如此之多基于回调（最近越来越多基于 promise 和 async/await）的原因。

## 调用堆栈

调用堆栈是一个 LIFO 队列（后进先出）

事件循环不断地检查调用堆栈，已查看是否需要运行任何函数。

当执行时，它会将找到的所有函数添加到调用堆栈中，并按照顺寻执行每个函数。

你知道在调试器或浏览器控制台中可能熟悉的错误堆栈跟踪么？浏览器在调用堆栈中查找函数名称，以告知你是哪个函数发起了当前的调用。

## 一个简单的事件循环阐释

举个例子：

```js
const bar = () => console.log('bar')
const baz = () => console.log('baz')

const foo = () => {
    console.log('foo')
    bar()
    baz()
}

foo()
```

此代码会如预期地打印：

```js
foo
bar
baz
```

当运行此代码时，会首先调用 `foo()` 。在 `foo()` 内部，会首先调用 `bar()` ,然后调用 `baz()`。

此时调用堆栈如下所示：

![示例调用堆栈](http://website2.nodejs.cn/static/270ebeb6dbfa7d613152b71257c72a9e/c83ae/call-stack-first-example.png)

每次迭代中的事件循环都会查看调用堆栈中是否有东西，并执行它直到调用堆栈为空：
![示例](http://website2.nodejs.cn/static/ca404c319c6fc595497d5dc097d469ff/fc1a1/execution-order-first-example.png)

## 如对函数执行

上面的示例看起来很正常，没有什么特别的：JavaScript 查找要执行的东西，并按顺序执行它们。

`让我们看看如何将函数推迟直到堆栈被清空`。<!-- 异步，重头戏啊 -->

`setTimeout(()=>{},0)` 的用例是`调用一个函数，但是是在代码中的其他函数已被执行之后`。

举个例子:

```js
const bar = () => console.log('bar')
const baz = () => console.log('baz')

const foo = () => {
    console.log('foo')
    setTimeout(bar, 0)
    baz()
}

foo()
```

该代码会打印：

```js
foo
baz
bar
```

当运行此代码时，会首先调用 foo()。在 foo() 内部会调用 setTimeout,并将 bar 函数作为参数传入，指定延迟时间为 0。然后调用 baz()。

此时调用堆栈如下所示：

![异步堆栈调用示例](http://website2.nodejs.cn/static/be55515b9343074d00b43de88c495331/966a0/call-stack-second-example.png)

这是程序中所有函数的执行顺序：

![异步函数执行顺序图示](http://website2.nodejs.cn/static/585ff3207d814911a7e44d55fbde483b/f96db/execution-order-second-example.png)

为什么会这样呢？

## 消息队列

当调用 setTimeout() 时，浏览器或 Node.js 会启动定时器。当定时器到期时，回调函数会被放入`消息队列`中.

在消息队列中，用户触发的事件（如单击或键盘事件、或获取响应）也会在此排队，然后代码才有机会对其作出反应。类似 `onload` 这样的 DOM 事件也是如此。

时间循环会赋予调用堆栈较高的优先级，它首先处理在调用堆栈找到的所有东西，一旦调用堆栈中没有任何东西，便开始处理消息队列中的东西。

我们不必等待诸如 setTimeout、fetch、或其他的函数完成它们的工作，因为它们时浏览器提供的，并且位于它们自身的线程中。例如，如果将 setTimeout 的超时时间设置为 2 秒，但不必等待 2 秒，等待发生在其他地方。

## ES6 作业队列

ECMAScript 2015 引入了作业队列的概念，Promise 使用了该队列（也在 ES6 中引入）。这种方式会尽快的执行异步函数的结构，而不是放在调用堆栈的末尾。

在当前函数结束之前 resolve 的 Promise 会在当前函数之后被立即执行。

有个游乐场中的过山车的比喻很好： 消息队列将你排在队列的后面（在所有其他人的后面），你不得不等待你的回合，而工作队列则是快速通道票，这样你就可以在完成行一次乘车后立即乘坐另一辆车。

示例：

```js
const bar = () => console.log('bar')
const baz = () => console.log('baz')

const foo = () => {
    console.log('foo')
    setTimeout(bar, 0)
    new Promise((resolve) => {
        resolve('应该在 baz 之后、bar之前')
    }).then((resolve) => console.log(resolve))
    /**
     * 如上所属
     * 据我所知
     *
     * 消息队列对应我所听说的宏任务
     * 作业队列对应我所听说的微任务
     */
    console.log('baz')
}
```

这回打印：

```js
foo
baz
应该在 baz 之后、bar之前
bar
```

这是 Promise（已经基于 promise 构建的 async/await）与通过 `setTimeout()` 或其他平台 API 的普通的旧异步函数之间的巨大区别。
