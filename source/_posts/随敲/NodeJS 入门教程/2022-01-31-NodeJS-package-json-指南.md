---
title: NodeJS | package.json 指南
tags: NodeJS
categories:
    - 随敲
    - NodeJS
date: 2022-01-31 22:01:51
---

目录：

- [文件结构](#文件结构)
- [属性分类](#属性分类)
- [软件包版本](#软件包版本)

## 文件结构

这是一个示例的 package.json 文件：

```js
{
}
```

他是空的！对于应用程序，`package.json` 文件中的内容没有固定的要求。唯一的要求是必须遵守 JSON 格式，否则，尝试以编程的方式访问其属性的应用程序则无法读取它。

如果要构建要在 `npm` 上分发的 Node.js 软件包，则必须具有一组可帮助其他人使用它的属性。稍后会详细介绍。

这是另一个 package.json:

```js
{
  "name": "nodejs_cn"
}
```

它定义了 `name` 属性，用于告知应用程序或软件包的名称。

这是一个更复杂的示例，该实例是从 Vue.js 应用程序示例中提取的：

```js
"name":"test-project",
```

## 属性分类

## 软件包版本
