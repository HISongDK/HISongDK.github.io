---
title: NodeJS | 查看 npm 包安装的版本
tags: NodeJS
categories:
    - 随敲
    - NodeJS
date: 2022-02-04 20:48:27
---

若要查看所有已安装的 npm 软件包（包括他们的依赖包）的最新版本，则：

```js
npm list
```

例如：

```js
npm list
/User/joe/dev/node/cowsay
└─┬ cowsay@1.3.1
  ├── get-stdin@5.0.1
  ├─┬ optimist@0.6.1
  │ ├── minimist@0.0.10
  │ └── wordwrap@0.0.3
  ├─┬ string-width@2.1.1
  │ ├── is-fullwidth-code-point@2.0.0
  │ └─┬ strip-ansi@4.0.0
  │   └── ansi-regex@3.0.0
  └── strip-eof@1.0.0
```

也可以打开 `package-lock.json` 文件，但这需要进行一些视觉扫描。

`npm list -g` 也一样，但适用于全局安装的软件包。

若要仅获取顶层的软件包（基本上就是告诉 npm 要安装并在 `package.json` 中列出的软件包），则运行 `npm list --depth=0` :

```js
npm list --depth=0
/Users/joe/dev/node/cowsay
└── cowsay@1.3.1
```

也可以通过指定名称来获取特定软件包的版本：

```js
npm list cowsay
/Users/joe/dev/node/cowsay
└── cowsay@1.3.1
```

这也适用于安装的软件包的依赖：

```js
❯ npm list minimist
/Users/joe/dev/node/cowsay
└─┬ cowsay@1.3.1
  └─┬ optimist@0.6.1
    └── minimist@0.0.10
```

如果要查看软件包在 npm 仓库上最新的可用版本，则运行 `npm view [package_name] version` :

```js
npm view cowsay version
1.3.1
```
