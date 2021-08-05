---
title: TypeScript 简介
date: 2021-08-05 12:59:37
tags:
---

本部分介绍了在学习 TypeScript 之前都需要了解的知识，具体内容包括：

- [什么是 TypeScript](#什么是-typescript)
	- [TypeScript 的特性](#typescript-的特性)
		- [类型系统](#类型系统)
			- [TypeScript 是静态类型](#typescript-是静态类型)
- [安装 TypeScript](#安装-typescript)
- [Hello TypeScript](#hello-typescript)

## 什么是 TypeScript

> Typed JavaScript at Any Acale.
> 添加了类型系统的 JavaScript，适用于任何规模的项目。

以上是官网对于 TypeScript 的定义。

它强调了 TypeScript 的两个最重要的特性————类型系统、适用于任何规模。

### TypeScript 的特性

#### 类型系统

从 TypeScript 的名字就可以看出来，【类型】是其最核心的特性。
我们知道，JavaScript 是一门非常灵活的编程语言：

- 它没有类型约束，一个变量可能初始化时是字符串，过一会又被赋值为数字。
- 由于隐式类型转换的存在，有的变量的类型就很难再运行前就确定。
- 基于原型的面向对象编程，使得原型上的属性或方法可以在运行时被修改。
- 函数是 JavaScript 中的一等公民，可以赋值给变量，也可以当作参数或返回值。

这种灵活性就像一把双刃剑，一方面使得 JavaScript 蓬勃发展，无所不能，从 2013 年开始就一只蝉连最普遍使用的编程语言排行榜冠军；另一方面也使得它的代码质量参差不齐，维护成本高，运行时错误多。

而 TypeScript 的类型系统，再很大程度上弥补了 JavaScript 的缺点。

##### TypeScript 是静态类型

类型系统按照【类型检查的时机】来分类，可以分为动态类型和静态类型。

动态类型是指在运行时才会进行类型检查，这种语言的类型错误往往会导致运行时错误。JavaScript 是一门解释型语言，没有编译阶段，所以它是动态类型，以下这段代码在运行时才会报错：

```js
let foo = 1；
foo.split(' ')
// Uncaught TypeError: foo.split is not a function
// 运行时会报错（foo.split 不是一个函数），造成线上 bug
```

静态类型是指在编译阶段就能确定每个变量的类型，这种语言的类型错误往往会导致语法错误。TypeScript 在运行前需要先编译为 JavaScript，而在编译阶段就会进行类型检查，所以 TypeScript 是静态类型，这段 TypeScript 代码在编译阶段就会报错了：

```js
let foo = 1;
foo.split(' ');
// Property 'split' does not exist on type 'number'.
// 编译时报错（数字没有 split 方法），无法通过编译
```

你可能会奇怪，

## 安装 TypeScript

## Hello TypeScript
