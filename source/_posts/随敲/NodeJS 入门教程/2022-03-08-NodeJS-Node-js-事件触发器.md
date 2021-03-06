---
title: NodeJS | Node.js 事件触发器
tags: NodeJS
categories:
    - 随敲
    - NodeJS
date: 2022-03-08 00:00:00
---

如果你在浏览器中使用 JavaScript，那么你会知道通过事件处理了许多用户的交互：鼠标的点击、键盘按钮的按下、对鼠标移动的反应等等。

在后端，Node.js 也提供了使用 `events` 模块构建类似系统的选项。

具体上，此模块提供了 `EventEmitter` 类，用于事件处理。

使用以下代码进行初始化：

```js
const EventEmitter = require('events')
const eventEmitter = new EventEmitter()
```

该对象公开了 `on` 和 `emit` 方法。

-   `emit` 用于触发事件
-   `on` 用于添加回调函数，在事件被触发时执行

例如，创建 `start` 事件，并提供一个示例，通过记录到控制台进行交互：

```js
eventEmitter.on('start', () => {
    console.log('开始')
})
```

当运行以下代码时：

```js
eventEmitter.emit('start')
```

事件处理函数会被触发，且获得控制台日志。

可以通过将参数作为额外参数传给 `emit` 来将参数传给事件处理程序：

```js
eventEmitter.on('start', (number) => {
    console.log(`开始 ${number}`)
})

eventEmitter.emit('start', 23)
```

多个参数：

```js
eventEmitter.on('start', (start, end) => {
    console.log(`从 ${start} 到 ${end}`)
})

eventEmitter.emit('start', 1, 100)
```

EventEmitter 对象还公开了其他几个与事件进行交互的方法，例如：

-   `once()`:添加单次监听器
-   `removeListener()` / `off()`:从事件中移除事件监听器
-   `removeAllListeners()`:移出事件的所有监听器

可以在事件模块的页面 [http://nodejs.cn/api/events.html](http://nodejs.cn/api/events.html) 上阅读其所有详细信息。
