---
title: 安装 TypeScript
date: 2021-08-06 00:06:48
tags: TypeScript
categories:
  - [随敲, TypeScript]
---

TypeScript 的命令行工具安装方法如下：

```js
npm install -g typescript
```

以上命令会在全局环境下安装 `tsc` 命令，安装完成后，我们就可以在任何地方执行 `tsc` 命令了。

编译一个 TypeScript 文件很简单：

```js
tsc hello.ts
```

我们约定使用 TypeScript 编写的文件以 `.ts` 为后缀，用 TypeScript 编写 React 时，以 `.tsc` 为后缀。

<!-- more -->

## 编辑器

TypeScript 最大的优势之一便是增强了编辑器 IDE 的功能，包括代码补全、接口提示、跳转到定义、重构等。

主流的编辑器都支持 TypeScript，这里我推荐使用 Visual Studio Code。

它是一款开源，跨终端的轻量级编辑器，内置了对 TypeScript 的支持。

另外它本身也是 **用 TypeScript 编写的。**

获取其他编辑器或 IDE 对 TypeScript 的支持：

略！！！
