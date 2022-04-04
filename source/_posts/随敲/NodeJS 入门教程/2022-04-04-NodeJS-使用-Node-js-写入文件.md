---
title: NodeJS | 使用 Node.js 写入文件
tags: NodeJS
categories:
    - 随敲
    - NodeJS
date: 2022-04-04 18:30:26
---

在 Node.js 中写入文件最简单的方式是使用 `fs.writeFile()` API。

例如：

```js
const fs = require('fs')
const content = '一些内容'

fs.writeFile('/Users/joe/test.txt', content, (err) => {
    if (err) {
        console.error(err)
        return
    }
    // 文件写入成功
})
```

<!-- more -->

另外，也可以使用同步的版本 `fs.writeFileSync()` :

```js
const fs = require('fs')
const content = '一些内容'

try {
    const data = fs.writeFileSync('/Users/joe/test.txt', content)
    // 文件写入成功
} catch (err) {
    console.error(err)
}
```

默认情况下，此 API 会替换文件的内容。

可以通过指定标志修改默认行为：

```js
fs.writeFile('/Users/joe/test.txt', content, { flag: 'a+' }, (err) => {})
```

可能会使用的标志有：

-   `r+` 打开文件用于读写
-   `w+` 打开文件用于读写,将流定位到文件的开头，如果文件不存在则创建
-   `a` 打开文件用于追加，将流定位到文件的末尾，如果文件不存在则创建
-   `a+` 打开文件用于读写，将流定位到文件的末尾，如果文件不存在则创建

（可以在 [[text](http://nodejs.cn/api/fs.html#fs_file_system_flags)](http://nodejs.cn/api/fs.html#fs_file_system_flags)中查看更多标志）

## 追加到文件

将内容追加到文件末尾的便捷方法是 `fs.appendFile()` 及其对应的同步版本 `fs.appendFileSync()` :

```js
const content = '一些内容'
fs.appendFile('file.log', content, (err) => {
    if (err) {
        console.log(err)
        return
    }
    // 完成
})
```

## 使用流

所有这些方法，都是在将全部内容写入文件之后才会将控制权返回给程序（在异步的版本中，这意味着执行回调）。

在这种情况下，更好的选择是使用流写入文件的内容。
