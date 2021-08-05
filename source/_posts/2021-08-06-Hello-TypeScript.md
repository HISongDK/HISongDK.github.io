---
title: Hello TypeScript
date: 2021-08-06 00:16:52
tags:
---

我们从一个简单的例子开始。

将以下代码复制到 `hello.ts` 中：

```ts
function sayHello(person: string){
  return 'Hello, ' + person;
}

let user = 'Tom'
console.log(sayHello(user))
```

然后执行
`tsc hello.ts`

这时候会生成一个编译好的文件 `hello.js`:

```js
function sayHello(person){
  return 'Hello, ' + person;
}
var user = 'Tom'
console.log(sayHello(user))
```

在 TypeScript 中，我们使用 ` : ` ，指定变量的类型，` : ` 的前后有没有空格都可以。

上述例子中，
