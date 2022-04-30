---
title: NodeJS | Node.js 开发环境与生产环境的区别
tags: NodeJS
categories:
    - 随敲
    - NodeJS
date: 2022-05-01 00:45:11
---

可以为生产环境和开发环境使用不同的配置。

Node.js 假定其始终运行在开发环境中。可以通过 `NODE_ENV=production` 环境变量来向 Node.js 发出正在生产环境中运行的信号。

通常通过在 shell 中执行以下命令来完成：

```js
export NODE_ENV = production
```

但最好将其放在 shell 的配置文件中（例如，使用 Bash shell 的 `.bash_profile` ),否则当系统重启时，该设置不会被保留。

也可以通过将环境变量放在应用程序的初始化命令之前来应用它

```sh
export NODE_ENV = production node app.js
```

此环境变量是一个约定，在外部库中也广泛使用。

设置环境为 `production` 通常可以确保：

-   日志记录保持在最低水平
-   更高的缓存级别以优化性能

例如，如果 `NODE_ENV` 未被设置为 `production` ,则 Express 使用的模板库 Pug 会在调试模式下进行编译。Express 页面会在开发模式下按每个请求进行编译，而在生产环境中则会将其缓存。还有更多的示例。

可以使用条件语句在不同的环境中执行代码：

```js
if (process.env.NODE_ENV === 'development') {
    // ...
}

if (process.env.NODE_ENV === 'production') {
    // ...
}

if (['production', 'staging'].indexOf(process.env.NODE_ENV) >= 0) {
    // ...
}
```

例如，在 Express 应用总，可以使用此工具为每个环境配置不同的错误处理程序：

```js
if (process.env.NODE_ENV === 'development') {
    app.use(express.errorHandler({ dumpExceptions: true, showStack: true }))
}

if (process.env.NODE_ENV === 'production') {
    app.use(express.errorHandler({})) // 生产环境中就不用传一些额外的配置，默认应该就是关闭的，那这个错误处理其实当然是主要针对开发时便于定位bug，生产环境保障性能就好了。开发时有需要才开就行，虽然我也不清楚开的啥作用
}
```
