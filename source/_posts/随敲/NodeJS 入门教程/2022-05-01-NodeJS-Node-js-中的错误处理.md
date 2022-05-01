---
title: NodeJS | Node.js 中的错误处理
tags: NodeJS
categories:
    - 随敲
    - NodeJS
date: 2022-05-01 23:45:32
---

Node.js 中的错误通过异常进行处理。

## 创建异常

使用 `throw` 关键字创建异常：

```js
throw value
```

一旦 JavaScript 执行到此行，常规的程序流会被停止，且控制会被交给最近的异常处理程序。

通常，在客户端代码中，`value` 可以是任何 JavaScript 值（包括字符串、数字、或对象）。

在 Node.js 中，我们不抛出字符串，而仅抛出 Error 对象。

## 错误对象

错误对象是 Error 对象的实例、或者继承自 Error 类（由 Error 核心模块提供）：

```js
throw new Error('错误信息')
```

或：

```js
class NotEnoughCoffeeError extends Error {
    // ...
}

throw new NotEnoughCoffeeError()
```

## 处理异常

异常处理程序是 `try` / `catch` 语句。

`try` 块中包含的代码行中引发的任何异常都会在相应的 `catch` 块中处理：

```js
try {
    // 代码行
} catch (e) {}
```

在此示例中，`e` 是异常值。

可以添加多个处理程序，他们可以捕获各种错误。

## 捕获未捕获的异常

如果在程序执行中引发了未捕获的异常，则程序会泵困。

若要解决此问题，则监听 `process` 对象上的 `uncaughtException` 事件：

```js
process.on('uncaughtException', (err) => {
    console.log('有一个未捕获的错误', err)
    process.exit(1) // 强制性的（根据Node.js文档）
})
```

无需为此导入 `process` 核心模块，因为它是自动导入的。

## Promise 的异常

使用 promise 可以链接不同的操作，并在最后处理错误：

```js
doSomething1()
    .then(doSomething2)
    .then(doSomething3)
    .catch((err) => console.log(err))
```

你怎么知道错误发生在哪里？你并不知道，但是你可以处理所调用的每个函数中的错误，并且在错误处理程序中抛出新的错误，这就会调用外部的 `catch` 处理程序：

```js
const doSomething1 = () => {
    // ...
    try {
        // ...
    } catch (err) {
        throw new Error(err.message)
    }
    // ...
}
```

为了能够在本地，而不是在调用函数中处理错误，则可以断开链条，在每个 `then()` 函数中创建函数并处理异常：

```js
doSomething1()
    .then(() => {
        return doSomething2().catch((err) => {
            // 处理错误
            throw err // 打断链条
        })
    })
    .then(() => {
        return doSomething3().catch((err) => {
            // 处理错误
            throw err // 打断链条
        })
    })
    .catch((err) => console.error(err))
```

## async/await 的错误处理

使用 async/await 时，仍然需要捕获错误，可以通过以下方式进行操作:

```js
async function someFunction() {
    try {
        await someOtherFunction()
    } catch (err) {
        console.error(err.message)
    }
}
```
