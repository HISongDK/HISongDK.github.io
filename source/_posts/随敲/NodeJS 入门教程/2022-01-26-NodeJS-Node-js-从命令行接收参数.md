---
title: NodeJS | Node.js 从命令行接收参数
tags: NodeJS
categories:
    - 随敲
    - NodeJS
date: 2022-01-26 23:52:46
---

当使用以下命令调用 Node.js 应用程序时，可以传入任意数量的参数：

```js
node app.js
```

参数可以是独立的，也可以具有键和值。

例如：

```js
node app.js joe
```

或

```js
node app.js name=joe
```
