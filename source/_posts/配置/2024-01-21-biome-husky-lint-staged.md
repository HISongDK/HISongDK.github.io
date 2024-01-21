---
title: biome + husky + lint-staged
tags: NodeJS
categories:
  - 随敲
  - NodeJS
date: 2024-01-21 22:02:37
---

## husky

[查看文档](https://typicode.github.io/husky/getting-started.html)

根据文档命令初始化 husky 后，修改 `.husky/pre-commit` 文件

```shell
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

npm run lint-staged # 使用 lint-staged 脚本命令，需要将 "lint-staged": "lint-staged" 添加到 package.json 文件的 scripts 属性中

# 应该也可以直接使用 npx lint-staged，而且不需要添加  "lint-staged": "lint-staged" 
```

## lint-staged

每次提交只处理当前 `staged` 文件。

需要在 `package.json` 中添加 `lint-staged` 属性：

```json
"lint-staged": {
		"*": [
			"biome check --apply --no-errors-on-unmatched --files-ignore-unknown=true"
		]
}
```

声明在 husky 处理的 `pre-commit` hook 时，`lint-staged` 对应文件扩展类型，需执行的命令操作。

如需在 `.husky/pre-commit` 中使用本地脚本命令，需要在 package.json 文件的 scripts 属性中添加指定命令：

```json
"scripts": {
    // other scripts
    // ......
		"lint-staged": "lint-staged",
	},
```

### biome

安装:

```sh
npm i -D @biomejs/biome
```

生成初始 `biome.json` 文件：

```sh
biome init # 有本地包

npx biome init # 无需安装直接使用
```

修改初始 `biome.json` 文件，自定义配置

1. 添加 `formatter` 格式化配置
   - 默认 `formatWithErrors` 为 `false`，感觉有 `lint` 错误也允许格式化
   - 默认 `indentStyle` 为 `tab` ，很奇怪，`tab` 编辑器或者网页 diff 查看显示的宽度都可能有很大差别，正常应该是推荐使用 `space` 空格替代 `tab`
2. 添加 `javascript.formatter` 格式化撇脂

修改后文件如下:

```json
{
  "$schema": "https://biomejs.dev/schemas/1.5.2/schema.json",
  "organizeImports": {
    "enabled": true
  },
  "linter": {
    "enabled": true,
    "rules": {
      "recommended": true
    }
  },
  "formatter": {
    "enabled": true,
    "formatWithErrors": true,
    "indentStyle": "space",
    "indentWidth": 2,
    "lineWidth": 100,
    "lineEnding": "lf",
    "ignore": []
  },
  "javascript": {
    "formatter": {
      "arrowParentheses": "always",
      "jsxQuoteStyle": "single",
      "semicolons": "asNeeded",
      "trailingComma": "es5",
      "quoteProperties": "asNeeded",
      "bracketSpacing": true,
      "bracketSameLine": false
    }
  },
  "json": {
    "parser": {
      "allowComments": true
    }
  }
}
```
