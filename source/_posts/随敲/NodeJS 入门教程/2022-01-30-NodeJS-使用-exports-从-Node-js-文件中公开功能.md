---
title: NodeJS | 使用 exports 从 Node.js 文件中公开功能
tags: NodeJS
categories:
    - 随敲
    - NodeJS
date: 2022-01-30 13:27:22
---

Node.js 具有内置的模块系统。

Node.js 可以导入其他 Node.js 文件公开的功能。

当想要导入某些东西时，使用

```js
const library = require('./library')
```

可以导入存在于当前文件夹中的 `library.js` 文件中的公开功能。

在此文件中，必须先公开功能，然后其他文件才能导入。

默认情况下，文件中任何定义的其他对象或变量都是私有的，不会公开给外界。

这就是 [`module` 系统](http://nodejs.cn/api/modules.html)提供的 `module.exports` API 可以做的事。

当将对象或函数赋值给 exports 属性时，这就是要被公开的内容，因此可以将其导入应用程序的其他部分或者其他应用程序中。

可以通过两种方式进行操作。

第一种方式是将对象赋值给 `module.exports` (这是模块系统提供的对象),这会使文件只导出该对象：

```js
const car = {
    brand: 'Ford',
    model: 'Fiesta',
}

module.exports = car

// 在另一个文件中
const car = require('./car')
```

第二种方式是将要导出的对象添加为 exports 的属性。这种方式可以到处多个对象、函数或数据：

```js
const car = {
    brand: 'Ford',
    model: 'Fiesta',
}

exports.car = car
```

或直接

```js
exports.car = {
    brand: 'Ford',
    model: 'Fiesta',
}
```

在另一个文件中，则通过引用导入的属性来使用它：

```js
const items = require('./items')
items.car
```

或

```js
const car = require('./items').car
```

`module.exports` 和 `exports` 之间用什么区别？

**前者公开了它指向的对象。后者公开了它指向的对象的属性**
