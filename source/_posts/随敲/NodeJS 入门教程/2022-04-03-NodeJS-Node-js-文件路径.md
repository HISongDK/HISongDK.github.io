---
title: NodeJS | Node.js 文件路径
tags: NodeJS
categories:
    - 随敲
    - NodeJS
date: 2022-04-03 23:16:35
---

系统中每个文件都有路径。

在 Linux 和 macOS 上，路径可能类似于

`/users/joe/file.txt`

在 windows 上则有不同，具体类似以下的结构：

`C:\users\joe\file.txt`

<!-- 区别：windows 有盘符，然后是反斜杠，linux、mac 是直接斜杠 -->

当在应用程序中使用路径时需要注意，因为必须考虑到这种差异。

可以使用以下方式将此模块引入到文件中：

```js
const path = require('path')
```

<!-- more -->

## 从路径中获取信息

给定一个路径，可以使用以下方法从其中提取信息：

-   `dirname` ：获取文件名的父文件夹
-   `basename` ：获取文件名部分
-   `extname` ：获取文件的扩展名

例如：

```js
const notes = '/users/joe/notes.txt'
path.dirname(notes)
path.basename(notes)
path.extname(notes)
```

可以通过为 `basename` 指定第二个参数来获取不带拓展名的文件名：

```js
path.basename(notes, path.extname(notes)) // notes
```

## 使用路径

可以使用 `path.join()` 连接路径的两个或多个片段：

```js
const name = 'joe'
path.join('/', 'users', name, 'notes.txt') // '/users/joe/notes.txt'
```

可以使用 `path.resolve()` 获取相对路径的绝对路径计算：

```js
path.resolve('joe/txt') // '/Users/joe/joe.txt'
```

在此示例中，Node.js 只是简单地将 `/joe.txt` 附加到当前工作附录。如果指定第二个文件夹参数，则 `resolve` 会使用第一个参数作为第二个参数的基础：

```js
path.resolve('tmp', 'joe.txt') // 'Users/joe/tmp/joe.txt' 如果从主文件夹运行。
```

如果第一个参数以斜杠开头，则表示它是绝对路径：

```js
path.resolve('/etc', 'joe.txt') // '/etc/joe.txt'
```

`path.normalize()` 是另一个有用的函数，当包含 `.` 、`..` 或双斜杠之类的相对说明符时，其会尝试计算实际的路径：

```js
path.normalize('/users/joe/..//test.txt')
```

解析和规范化都不会检查路径是否存在。其只是根据获得的信息来计算路径。

<!-- 我想着是不是就是文件中根据计算出来的路径来写入/创建文件呢 -->
