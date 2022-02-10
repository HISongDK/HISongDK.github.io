---
title: NodeJS | 探索 JavaScript 定时器
tags: NodeJS
categories:
    - 随敲
    - NodeJS
date: 2022-02-09 17:18:00
---

## `setTimeout()`

当编写 JavaScript 代码时，可能希望延迟函数的执行。

这就是 setTimeout 的工作。指定一个回调函数供稍后执行，并指定延迟的时间：

```js
setTimeout(() => {
    // 2 秒后执行
}, 2000)

setTimeout(() => {
    // 50 豪秒后执行
}, 50)
```

该语法定义了一个新函数。可在其中调用任何所需的其他函数，也可以传入现有的函数名称和一组函数：

```js
const myFunction = (firstParam, secondParam) => {
    // 做些事情
}

// 两秒后执行
setTimeout(myFunction, 2000, firstParam, secondParam)
```

`setTimeout` 会返回定时器的 id。通常不使用它，但是可以保存此 id，并在要删除此安排的函数执行时清除它：

```js
const id = setTimeout(() => {
    // 两秒后执行
}, 2000)

// 改主意了
clearTimeout(id)
```
