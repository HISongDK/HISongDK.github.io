---
title: NodeJS | package-lock.json 文件
tags: NodeJS
categories:
    - 随敲
    - NodeJS
date: 2022-02-03 13:03:15
---

在版本 5 中，npm 引入了 `package-lock.json` 文件。

那是什么？您可能知道 `package.json` 文件，它更常见并且存在的时间更长。

该文件旨在跟踪被安装的每隔软件包的确切版本，以便产品可以被相同的方式 100%复制（即使软件包的维护者更新了软件包）。

这解决了 `package.json` 一直未解决的特殊问题。在 package.json 中，可以使用 semver 表示法设置要升级的版本（补丁版本或次版本），例如：

-   如果写入的是 `~0.13.0` 则只需更新补丁版本：即 `0.13.1` 可以，但 `0.14.0` 不可以。
-   如果写入的是 `^0.18.0` ,则需要更新补丁版本和次版本：即 `0.13.1` 、`0.14.0` 、依此类推。
-   如果写入的是 `0.13.0` ,则始终使用确切的版本。

无需将 node_modules 文件夹（该文件夹通常很大）提交到 Git，当尝试使用 `npm install` 命令在另一台机器上复制项目时，如果指定了 `~` 语法并且软件包发布了补丁版本，则该软件包会被安装。`^` 和次版本也一样。

> 如果指定确切的版本,例如示例中 `0.13.0` ，则不会受到此问题的影响。

可能是你，或者是其他人，会在某处尝试通过运行 `npm install` 初始化项目。

因此，原始的项目和新初始化的项目实际上是不同的。即使补丁版本不应该引入重大的更改，但还是可能引入缺陷。

`package-lock.json` 会固化当前安装的每个软件包的版本，当运行 `npm install` 时， `npm` 会使用这些确切的版本。

这个概念并不心想，其他编程语言的软件包管理器（例如 PHP 中的 Conposer）使用类似的系统已有多年。

`package-lock.json` 文件需要被提交到 Git 仓库，以便被其他人获取（如果项目是公开的或有合作者，或者将 Git 作为部署源）。

当运行 `npm undate` 时，`package-lock.json` 文件中的依赖项版本会被更新。

## 示例

这是在空文件夹中运行 `npm install cowsay` 时获得的 `package-lock.json` 文件的示例结构：

```json
{
  "requires": true,
  "lockfileVersion": 1,
  "dependencies": {
    "ansi-regex": {
      "version": "3.0.0",
      "resolved": "https://registry.npmjs.org/ansi-regex/-/ansi-regex-3.
0.0.tgz",
      "integrity": "sha1-7QMXwyIGT3lGbAKWa922Bas32Zg="
    },
    "cowsay": {
      "version": "1.3.1",
      "resolved": "https://registry.npmjs.org/cowsay/-/cowsay-1.3.1.tgz"
,
      "integrity": "sha512-3PVFe6FePVtPj1HTeLin9v8WyLl+VmM1l1H/5P+BTTDkM
Ajufp+0F9eLjzRnOHzVAYeIYFF5po5NjRrgefnRMQ==",
      "requires": {
        "get-stdin": "^5.0.1",
        "optimist": "~0.6.1",
        "string-width": "~2.1.1",
        "strip-eof": "^1.0.0"
      }
    },
    "get-stdin": {
      "version": "5.0.1",
      "resolved": "https://registry.npmjs.org/get-stdin/-/get-stdin-5.0.
1.tgz",
      "integrity": "sha1-Ei4WFZHiH/TFJTAwVpPyDmOTo5g="
    },
    "is-fullwidth-code-point": {
      "version": "2.0.0",
      "resolved": "https://registry.npmjs.org/is-fullwidth-code-point/-/
is-fullwidth-code-point-2.0.0.tgz",
      "integrity": "sha1-o7MKXE8ZkYMWeqq5O+764937ZU8="
    },
    "minimist": {
      "version": "0.0.10",
      "resolved": "https://registry.npmjs.org/minimist/-/minimist-0.0.10
.tgz",
      "integrity": "sha1-3j+YVD2/lggr5IrRoMfNqDYwHc8="
    },
    "optimist": {
      "version": "0.6.1",
      "resolved": "https://registry.npmjs.org/optimist/-/optimist-0.6.1.tgz",
      "integrity": "sha1-2j6nRob6IaGaERwybpDrFaAZZoY=",

      "requires": {
        "minimist": "~0.0.1",
        "wordwrap": "~0.0.2"
      }
    },
    "string-width": {
      "version": "2.1.1",
      "resolved": "https://registry.npmjs.org/string-width/-/string-width-2.1.1.tgz",
      "integrity": "sha512-nOqH59deCq9SRHlxq1Aw85Jnt4w6KvLKqWVik6oA9ZklXLNIOlqg4F2yrT1MVaTjAqvVwdfeZ7w7aCvJD7ugkw==",
      "requires": {
        "is-fullwidth-code-point": "^2.0.0",
        "strip-ansi": "^4.0.0"
      }
    },
    "strip-ansi": {
      "version": "4.0.0",
      "resolved": "https://registry.npmjs.org/strip-ansi/-/strip-ansi-4.0.0.tgz",
      "integrity": "sha1-qEeQIusaw2iocTibY1JixQXuNo8=",
      "requires": {
        "ansi-regex": "^3.0.0"
      }
    },
    "strip-eof": {
      "version": "1.0.0",
      "resolved": "https://registry.npmjs.org/strip-eof/-/strip-eof-1.0.0.tgz",
      "integrity": "sha1-u0P/VZim6wXYm1n80SnJgzE2Br8="
    },
    "wordwrap": {
      "version": "0.0.3",
      "resolved": "https://registry.npmjs.org/wordwrap/-/wordwrap-0.0.3.tgz",
      "integrity": "sha1-o9XabNXAvAAI03I0u68b7WMFkQc="
    }
  }
}
```

安装 cowsay，其依赖于：

-   get-stdin
-   optimist
-   string-width
-   strip-eof

这些软件包还需要其他软件包，正如 `require` 属性可以看到的：

-   ansi-regex
-   is-fullwidth-code-point
-   minimist
-   wordwrap
-   string-eof

他们会按照字母顺序被添加到文件中，每隔都有 `version` 字段、指向软件包位置的 `resolved` 字段、以及用于校验软件包的 `integrity` 字符串。
