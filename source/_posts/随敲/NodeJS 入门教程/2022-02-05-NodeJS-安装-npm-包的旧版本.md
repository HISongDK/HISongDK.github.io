---
title: NodeJS | 安装 npm 包的旧版本
tags: NodeJS
categories:
    - 随敲
    - NodeJS
date: 2022-02-05 20:21:49
---

可以使用 `@` 语法来安装 npm 软件包的旧版本：

```js
npm install <package>@<version>
```

示例：

```js
npm install cowsay
```

以上命令会安装 1.3.1 版本（在撰写本文时）

使用以下命令可以安装 1.2.0 版本：

```js
npm install cowsay@1.2.0
```

全局的软件包也可以这样做：

```js
npm install -g webpack@4.16.4
```

可能还需要列出软件包所有的版本。可以使用 `npm view <package> versions`

```js
 npm view cowsay versions

[ '1.0.0',
  '1.0.1',
  '1.0.2',
  '1.0.3',
  '1.1.0',
  '1.1.1',
  '1.1.2',
  '1.1.3',
  '1.1.4',
  '1.1.5',
  '1.1.6',
  '1.1.7',
  '1.1.8',
  '1.1.9',
  '1.2.0',
  '1.2.1',
  '1.3.0',
  '1.3.1' ]
```
