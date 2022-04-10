---
title: NodeJS | Node.js 事件模块
tags: NodeJS
categories:
    - 随敲
    - NodeJS
date: 2022-04-10 23:13:46
---

`events` 模块提供了 `EventEmitter` 类，这是在 node.js 中处理事件的关键。

```js
const EventEmitter = require('events')
const door = new EventEmitter()
```

事件监听器返回及使用以下事件：

-   当监听器被添加时返回 `newListener`
-   当监听器被移除时返回 `removeListener`

以下是最常用方法的详细说明：

## `emitter.addListener()`

`emitter.on()` 的别名

## `emitter.emit()`

触发事件，按照事件注册的顺序同步调用每个事件注册器。

```js
door.emit('slam') // 触发 slam 事件
```

## `emitter.eventNames()`

返回字符串数组，表示在当前 `EventEmitter` 对象上注册的事件：

```js
door.eventNames()
```

## `emitter.getMaxListeners()`

获取到可以添加到 `EventEmitter` 对象的监听器的最大数量，默认值为 10 ，可以使用 `setMaxListeners()` 进行增减。

```js
door.getMaxListeners()
```

## `emitter.listenerCount()`

获取作为参数传入的事件监听器计数：

```js
door.listenerCount('open')
```

## `emitter.listeners()`

获取作为参数传入事件监听器的数组：

```js
door.listeners()
```

## `emitter.off()`

`emitter.removeListener()` 的别名，新增于 Node.js 10

## `emitter.on()`

添加当事件被触发时调用的回调函数。

用法：

```js
door.on('open', () => {
    console.log('打开')
})
```

## `emitter.once()`

添加当事件首次触发时的回调函数。该回调只会被调用一次，不会再次调用。

```js
const EventEmitter = require('events')
const ee = new EventEmitter()

ee.once('my-event', () => {
    // 只调用一次的回调函数
})
```

## `emitter.prependListener()`

当使用 `on` 或 `addListener` 添加监听器时，监听器会被添加到队列中的最后一个，并且最后一个被调用。使用 `prependListener` 可以在其他监听器之前添加并调用。

## `emitter.prependOnceListener()`

当使用 `once` 添加事件首次触发的回调时，会添加到队尾，并最后调用。使用 `prependOnceListener` 可以在其他监听器之前添加被调用。

<!-- 上面这两 API 描述我有点懵的是，不是事件触发了才执行么，那触发怎么还能按顺序么 -->

## `emitter.removeAllListeners()`

移除 `EventEmitter` 对象的所有监听特定事件的事件监听<!--额..这上面也有非特定的自带事件么-->

## `emitter.removeListener()`

移除特定的监听器。可以通过将回调函数保存在变量中，以便以后可以引用它：

```js
const doSomething = () => {}
door.on('open', doSomething)
door.removeListener('open', doSomething)
```

## `emitter.setMaxListeners()`

指定可以添加到 `EventEmitter` 实例对象的监听器最大数量。

```js
door.setMaxListeners(50)
```
