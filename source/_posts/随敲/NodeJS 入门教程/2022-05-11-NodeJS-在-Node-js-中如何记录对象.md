---
title: NodeJS | 在 Node.js 中如何记录对象
tags: NodeJS
categories:
    - 随敲
    - NodeJS
date: 2022-05-11 23:24:44
---

当在浏览器中运行的 JavaScript 程序中键入 `console.log()` 时，则会在浏览器的控制台中创建一个漂亮的条目。如果点击箭头，则会展开日志，可以清楚地看到对象地属性。

在 Node.js 中，也会发生同样的情况。

当我们记录内容到控制台时，没有那么奢侈，因为它会将对象输出到 shell （如果你手动运行 Node.js 程序）或输出到日志文件。你会获得对象的字符串形式。

在达到一定嵌套级别之前一切都很好。再经过两个级别的嵌套后，Node.js 会放弃并打印 [Object] 作为占位符

<!-- more -->

```js
const obj = {
  name: 'joe',
  age: 35,
  person1: {
    name: 'Tony',
    age: 50,
    person2: {
      name: 'Albert',
      age: 21,
      person3: {
        name: 'Peter',
        age: 23
      }
    }
  }
}
console.log(obj)


{
  name: 'joe',
  age: 35,
  person1: {
    name: 'Tony',
    age: 50,
    person2: {
      name: 'Albert',
      age: 21,
      person3: [Object]
    }
  }
}
```

如何打印整个对象？

最好的方法（同时保留漂亮的打印效果）是使用：

```js
console.log(JSON.stringify(obj, null, 2))
```

其中 2 是用于缩进的空格数。

另一种选择是使用：

```js
require('util').inspect.defaultOptions.depth = null
console.log(obj)
```

但是有个问题，第二级之后的嵌套对象会被展平，这可能是复杂对象的问题。
