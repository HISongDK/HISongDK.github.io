---
title: NodeJS | Node.js 路径模块
tags: NodeJS
categories:
    - 随敲
    - NodeJS
date: 2022-04-08 23:19:03
---

`path` 模块提供了许多非常实用的函数来访问文件系统，并与文件系统进行交互。

<!-- 这话看着耳熟 -->

无需安装，你可以通过简单的引用来使用它：

```js
const path = require('path')
```

<details>
	<summary>该模块提供了 <code>path.sep</code> 和 <code>path.delimiter</code></summary>
  <li>path.sep: 作为路径分隔符，在Windows上是 <code>\</code>,在 Linux/macOS 上是 <code>/</code></li>
  <li>path.delimiter: 作为路径定界符，在Windows上是 <code>;</code>,在 Linux/macOS 上是 <code>:</code></li>
</details>

还有这些 `path` 方法：

## `path.basename()`

返回路径的最后一部分。第二个参数可以指定过滤掉扩展名

## `path.dirname()`

返回路径的目录部分，亦即 path.basename 前的部分

## `path.extname()`

返回路径的扩展名

## `path.isAbsolute()`

判断路径是否为绝对路径，返回布尔值

## `path.join()`

拼接多个路径部分 <!-- 我有点理解不了这和字符串拼接的区别 -->

## `path.normalize()`

将包含 `.` 、`..`的相对路径计算为实际的路径

## `path.parse()`

将路径解析成组成他的信息片段：

-   `root`: 根路径
-   `dir`: 从根路径开始的文件夹路径
-   `base`: 文件名 + 扩展名
-   `name`: 文件名
-   `ext`: 扩展名

## `path.relative()`

接收两个路径作为参数，基于当前工作目录，返回从第一个路径到第二个路径的相对路径。

## `path.resolve()`

可以使用 `path.resolve()` 获取相对路径的绝对路径计算

通过指定第二个参数，`resolve`会将第一个路径作为第二个的基准，再计算出二者拼接后所在的绝对路径

如果第一个参数以斜杠开头，就表示它是绝对路径
