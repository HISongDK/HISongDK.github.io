---
title: NodeJS | 在 Node.js 中从命令行接收输入
tags: NodeJS
categories:
    - 随敲
    - NodeJS
date: 2022-01-30 12:45:47
---

如何使 Node.js CLI 程序具有交互性？

从版本 7 开始，Node.js 提供了 [`readline`模块](http://nodejs.cn/api/readline.html)来执行以下操作：每次一行地从可读流(例如 process.stdin 流，在 Node.js 执行期间该流就是终端输入)获取输入。

```js
const readline = require(readline).createInterface({
    input: process.stdin, // 不是说执行的时候就是么，怎么还需要手动传参
    output: process.stdout, // 才发现，是说的 node执行时 process.stdin 是命令行输入，readline 的获取来源需要指定
})

readline.question(``, (name) => {
    console.log(`你好 ${name}~`)
    readline.close()
})
```

这段代码会询问用户名，当输入了文本并且用户按下回车键时，则会发送问候语。

`question()` 会向控制台显示第一个参数（即问题），并等待用户输入。当按下回车键时它会调用回调函数。

在此回调函数中，关闭里 readline 接口。

`readline` 还提供了其他几个方法，详见上面的文档链接。

如果需要密码，则最好不要回显密码，而是显示 `*` 符号。

最简单的方式是使用 [`readline-sync` 软件包](https://www.npmjs.com/package/readline-sync),其在 API 方面非常类似。

[Inquirer.js](https://github.com/SBoudrias/Inquirer.js)则提供了更完整、更抽象的解决方案。

可以使用 `npm install inquirer` 进行安装，然后复用上面的代码如下：

```js
const inquirer = require('inquirer')

const question = [{ type: 'input', name: 'name', message: '你叫什么名字?' }]

inquirer.prompt(question).then((answers) => {
    console.log(`你好 ${answer['name']}!`) // 只打印不符合 prompt 确认框操作啊
})
```

Inquirer.js 可以执行许多操作，例如询问多项选择、展示单选按钮、确认等。

所有的可选方案都值得了解，尤其是 Node.js 提供的内置方案，但是如果打算将 CLI 提升到更高的水平，则 Inquirer.js 是更优的选择。
