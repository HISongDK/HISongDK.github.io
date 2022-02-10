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

### 零延迟

如果将尝试延迟指定为 0，则回调函数会尽快执行，但是是在当前函数执行之后：

```js
setTimeout(() => {
    console.log('后者')
}, 0)

console.log('前者')
```

会打印 `前者\n后者` 。

通过在调度程序中排队函数，可以避免在执行繁重的任务时阻塞 CPU，并在执行繁重的计算时执行其他函数。

> 某些浏览器实现的（IE 和 Edge） `setImmediate()` 方法具有相同的确切功能，但是不是标准的，并且在其他浏览器上不可用。但是在 node.js 中它是标准的函数。

## `setInterval()`

`setInterval` 是一个类似 `setTimeout` 的函数，不同之处在于：它会在指定的待定时间一直运行回调函数，而不只是运行一次：

```js
setInterval(() => {
    // 每两秒运行一次
}, 2000)
```

上面的函数每隔 2 秒运行一次，除非是用 `clearInterval` 告诉它停止（传入 `setInterval` 返回的间隔定时器 id):

```js
const id = setInterval(() => {}, 2000)
clearInterval(id)
```

**通常在 `setInterval` 回调函数中调用 `clearInterval`,以使其自行判断是否应该再次运行或停止。**例如，此代码会运行某些事情，除非 `App.somethingIWait` 具有值 `arrived` ：

```js
const interval = setInterval(() => {
    if (App.somethingIWait === 'arrived') {
        clearInterval(interval)
        return
    }
    // do something
}, 100)
```

## 递归的 setTimeout

`setInterval` 每 n 毫秒启动一个函数，而无需考虑函数何时完成执行。

如果一个函数总是花费相同的时间，就没有问题了。函数可能需要不同的执行时间，这具体取决于网络条件，也许一个较长时间的执行会与下一次执行重叠。

为了避免这种情况，可以在回调函数完成时，安排要被调用的递归的 setTimeout：

```js
const myFunction = () => {
    // do something

    setTimeout(myFunction, 1000)
}
setTimeout(myFunction, 1000)
```

`setTimeout` 和 `setInterval` 可通过定时器模块在 Node.js 中使用。

Node.js 还提供 `setImmediate()` ,通常用于与 Node.js 事件循环配合使用。
