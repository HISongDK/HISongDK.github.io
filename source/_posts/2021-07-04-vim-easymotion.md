---
title: vim.easymotion
date: 2021-07-04 23:08:03
tags:
---

今天，貌似是下午的时候，发现 vim 指定的 快捷键 `f <eveyChar>`[^f映射为]失效了。
[^f映射为]:vim.easymotion 的 `<leader> <leader> "s"`

起初以为新的 fl980 键盘有问题，换成 nizX87 还是失效。

就有点蒙了，试了半天，才确定是 vim.easymotion 的问题，因为相关的 指定行标记跳转也失效，确定了是 leader leader 没有触发。

得浪费了我一个来小时，上 github 上看了 issue ，果然是出 bug 了。

看着有说上一个版本没问题，且记得 vscode 插件有安装其他版本的提示。就回来回退了版本，果然能用了。

而且也惊讶于 vs 插件版本管理的细致
