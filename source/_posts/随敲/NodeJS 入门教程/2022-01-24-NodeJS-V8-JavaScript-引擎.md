---
title: NodeJS | V8 JavaScript 引擎
tags: NodeJS
categories:
    - 随敲
    - NodeJS
date: 2022-01-24 23:23:36
---

V8 是为 Google Chrome 提供支持的 JavaScript 引擎的名称。当使用 Chrome 进行浏览时，它负责处理并执行 JavaScript。

V8 提供了 JavaScript 运行时环境。DOM 和其他 Web 平台 API 则由浏览器提供。

很酷的是，JavaScript 引擎独立于托管它的浏览器。此关键特性推动了 Node.js 的兴起。V8 于 2009 年被选为为 Node.js 提供支持的引擎，并且随着 Node.js 的爆炸性发展，V8 成为了现在为大量的服务端代码(使用 JavaScript 编写)提供支持的引擎。

Node.js 的生态系统非常庞大，得益于此，V8 还为桌面应用程序(通过 Electron 等项目)提供支持。

## 其他 JS 引擎

其他浏览器也有自己的 JavaScript 引擎：

-   Firefox 具有 `SpiderMonkey`
-   Safari 具有 `JavaScriptCore`(又称为 Nitro)
-   Edge 最初基于 `Chakra` ，但最近使用 `Chromium和V8进行了重建`

还有很多其他的

所有这些引擎都实现了 `ECMA ES-262 标准` （又称为 ECMAScript），这是 JavaScript 使用的标准。

## 对应能的追求

V8 使用 C++ 编写，并且不断地改进。他是可移植的，且可以运行于 Mac、Windows、Linux 和其他一些系统。

在此 V8 的介绍中，省略了 V8 的实现细节：可以去更权威性的网站（例如 [V8 官方网站](https://v8.dev/)）上查看。

与其他 JavaScript 引擎一样，V8 也在不断地发展以加速 Web 和 Node.js 的生态系统。

在 Web 上，性能竞赛一直持续了很多年，作为用户和开发者从这场竞争中受益匪浅，因为年复一年地获得了更快、更优化的机器。

## 编译

JavaScript 通常被认为是一门解释性的语言，但是现代的 JavaScript 引擎不再只是解释 JavaScript,也会对其进行编译。

这从 2009 年开始就一直这样，当时 SpiderMonkey JavaScript 编译器被添加到 Firefox3.5 中，所有人都跟进了这个想法。

JavaScript 是由 V8 在其内部编译的，使用了即时编译（JIT）以加快执行速度。

自 2004 年 Google 地图引入以来，JavaScript 已经从一门通常执行几十行代码的语言演变为能在浏览器中运行具有成千上万行代码的完整应用程序。

现在，应用程序可以在浏览器中运行数小时，而不仅仅是一些表单验证规则或简单的脚本。

在这个新世界中，编译 JavaScript 非常有意义，因为尽管可能需要多花费一点时间来为 JavaScript 做准备，但是一旦完成，则它会比纯解释型的代码具有更高的性能。
