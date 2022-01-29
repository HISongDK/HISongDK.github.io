---
title: NodeJS | 使用 Node.js 输出到命令行
tags: NodeJS
categories:
    - 随敲
    - NodeJS
date: 2022-01-27 13:03:29
---

## 使用控制台模块的基本输出

Node.js 提供了 `console` 模块，该模块提供了大量非常有用的与命令行交互的方法。

它基本与浏览器中的 `console` 对象相同。

最基础、最常用的方法是 `console.log()` ,该方法会打印传入控制台的字符串。

如果传入对象，则它会呈现为字符串。

可以传入多个变量到 `console.log` ,例如：

```js
const x = 'x'
const y = 'y'
console.log(x, y)
```

Node.js 会全部打印出来。

也可以通过传入变量和格式说明符来格式化用语。

<!-- more -->

例如：

```js
console.log('我的%s已经%d岁', '猫', 2)
```

1. `%s` 会格式化变量为字符串
2. `%d` 会格式化变量为数字
3. `%i` 会格式化变量为其整数部分
4. `%o` 会格式化变量为对象

例如：

```js
console.log('%o', Number)
```

## 清空控制台

`console.cler()` 会清空控制台（其行为可能取决于所使用的控制台）

## 元素计数

`console.count()` 是一个便利的方法。

使用以下代码：

```js
const x = 1,
    y = 2,
    z = 3
console.count('x 的值为 ' + x + ' 且已检查了几次？')
console.count('x 的值为 ' + x + ' 且已检查了几次？')
console.count('x 的值为 ' + y + ' 且已检查了几次？')
```

count 方法会对打印的字符串的次数进行计数，并在其旁边打印计数：

数苹果和橙子：

```js
const origin = ['橙子', '橙子']
const apples = ['苹果']

origin.forEach((fruit) => console.count(fruit))
apples.forEach((fruit) => console.count(fruit))
```

## 打印堆栈踪迹

在某些情况下，打印函数的调用堆栈踪迹很有用，可以回答以下问题：如何到达代码的哪一部分？

可以使用 `console.trace()` 实现：

```js
const function2 = () => console.trace()
const function1 = () => function2()
function1()
```

这会打印堆栈踪迹。如果在 Node.js REPL 中尝试此操作，则会打印以下内容：

```bash
Trace
    at function2 (repl:1:33)
    at function1 (repl:1:25)
    at repl:1:1
    at ContextifyScript.Script.runInThisContext (vm.js.44:33)
    at REPLServer.defaultEval (repl.js:239:29)
    at bound (domain.js:301:14)
    at REPLServer.runBound [as eval] (domain.js:314:12)
    at REPLServer.onLine (repl.js:440:10)
    at emitOne (events.js:120:20)
    at REPLServer.emit (events.js:210:7)
```

## 计算耗时

可以使用 `time()` 和 `timeEnd()` 轻松地计算函数运行所需的时间：

```js
const doSomething = () => {
    function name(params) {
        const x = 1
        console.log('=========')
    }
}
const measureDoingSomething = () => {
    console.time('doSomething()')
    // 干点啥，并测量所需的时间。
    doSomething()
    console.timeEnd('doSomething()')
}
measureDoingSomething()
```

## stdout 和 stderr

console.log() 非常适合在控制台中打印消息。这就是所谓的标准输出（或称为 `stdout` ）。

`console.error` 会打印到 `stderr` 流。

他不会出现在控制台中，但是会出现在错误日志中。

## 为输出着色

可以使用[转义序列](https://gist.github.com/iamnewton/8754917)在控制台中为文本的输出着色。转义序列是一组识别颜色的字符。

例如：

```js
console.log('\x1b[33m%s\x1b[0m', '你好')
```

可以在 Node.js REPL 中进行尝试，它会打印黄色的 `你好` 。
