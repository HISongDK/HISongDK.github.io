---
title: 'JavaScript Promise: 去而复返'
tags: 随敲
categories: 随敲
date: 2021-09-24 14:38:13
---

原文：[JavaScript Promises: an introduction](http://www.html5rocks.com/en/tutorials/es6/promises/)
作者：[Jake Archibald](http://www.html5rocks.com/profiles/#jakearchibald)
翻译：[Amio](./#)
转自：[司徒](https://www.cnblogs.com/rubylouvre/p/3495286.html)

女士们先生们，请准备好迎接 Web 开发历史上一个重大时刻......

[鼓声响起]

> JavaScript 有了原生的 Promise!

[漫天的烟花绽放，人群沸腾了]

这时候你大概是这三种人之一：

- 你的身边拥挤着欢呼的人群，但是你却不在其中，甚至你还不大清楚"Promise"是什么。你耸耸肩，烟花的碎屑在你身边落下。这样的话，不要担心，我也是花了多年的时间才明白 Promise 的意义，你可以从[入门简介：他们都在激动什么？](#他们都在激动什么？)开始看起。
- 你一挥拳！太赞了对么！你已经用过一些 Promise 的库，但是所有这些第三方实现在 API 上都略有差异，JavaScript 官方的 API 会是什么样子？看[这里：Promise 术语]！
- 你早就知道了，看着那些欢呼雀跃的新人的你的嘴角泛起一丝不屑的微笑。你可以安静享受一会优越感，然后直接去看[API 参考]吧。

## 他们都在激动什么？

JavaScript 是单线程的，这意味着任何两句代码都不能同时运行，他们得一个接一个来。在浏览器中，JavaScript 和其它任务共享一个线程，不同的线程略有差异，但大体上这些和 JavaScript 共享线程的任务包括重绘、更新样式、用户交互等，所有这些任务操作都会阻塞其他操作。

作为人类，你是多线程的。你可以多个手指同时敲键盘，也可以一边开车一边电话。唯一的全局阻塞函数就是打喷嚏，打喷嚏期间所有其他事务都会暂停。很烦人对么？尤其当你在开着车打着电话的时候。我们都不喜欢这样打喷嚏的代码。

你应该会用事件 + 回调的办法来处理这类情况：

```js
var img1 = document.querySelector('.img-1')

img1.addEventListener('load', function () {
  // woo yey image loaded
})

img1.addEventListener('error', function () {
  // argh everything's broken
})
```

这样就不打喷嚏了。我们添加几个监听函数，请求图片，然后 JavaScript 就停止运行了，直到触发某个监听函数。

上面的例子中唯一的问题是，事件有可能在我们绑定监听器之前就已经发生了，所以我们先要检查图片的`complete`属性：

```js
var img1 = document.querySelector('img-1')

function loaded() {
  // woo yey image loaded
}

if (img1.complete) {
  loaded()
} else {
  img1.addEventListener('load', loaded)
}
img1.addEventListener('error', function () {
  // argh everything's broken
})
```

这样还不够，如果在监听函数之前图片加载发生错误，我们的监听函数还是白费，不幸的是 DOM 也没有为这个需求提供解决办法。而且，这还只是处理一张图片的情况，如果有一堆图片要处理就更麻烦了。

## 事件不是万金油

事件机制最适合处理在同一个对象上反复发生的事情————keyup、touchstart 等等。你不需要考虑当绑定事件之前发生的事情，当碰到异步请求成功/失败的时候，你想要的通常是这样：

```js
img1
  .callThisIfLoadedOrWhenLoaded(function () {
    // loaded
  })
  .orIfFailedCallThis(function () {
    // failed
  })

// and ...
whenAllTheseHaveLoaded([img1, img2])
  .callThis(function () {
    // all load
  })
  .orIfSomeFailedCallThis(function () {
    // one or more failed
  })
```

这就是 Promise。如果 HTML 图片元素有一个`ready()`方法的话，我们就可以这样：

```js
img1.ready().then(
  function () {
    // loaded
  },
  function () {
    // failed
  },
)

// and ...
Promise.all([img1.ready(), img2.ready()]).then(
  function () {
    // all loaded
  },
  function () {
    // one or more failed
  },
)
```

基本上 Promise 还是有点像事件回调的，除了：

- 一个 Promise 只能成功或失败一次，并且状态无法改变（不能从成功变为失败，反之亦然）
- 如果一个 Promise 成功或者失败之后，你为其添加针对成功/失败的回调，则相应的回调函数会立即执行

这些特性非常适合处理异步操作的成功/失败情景，你无需担心事件发生的时间点，而只需对其做出响应。

## 相关术语

[Domenico Denicoia](https://twitter.com/domenic)审阅了本文初稿，给我在术语方面打了个"F",关了禁闭并且责令我打印 [States and Fates](https://github.com/domenic/promises-unwrapping/blob/master/docs/states-and-fates.md)一百遍，还写了一封家长信给我父母。即便如此，我还是对术语有些迷糊，不过基本上应该是这样：

一个 Promise 的状态可以是：

**确认（fulfilled）** - 成功了
**否定（rejected）** - 失败了
**等待（pending）** - 还没有确认或者否定
**结束（settled）** - 已经确认或者否定了

规范里还使用"thenable"来描述一个对象是否是"类 Promise"（拥有名为"then"的方法）的。这个术语是我想起来前英格兰足球经理[Terry Venables](http://en.wikipedia.org/wiki/Terry_Venables),所以我尽量少使用它。

## JavaScript 有了 Promise

其实已经有一些第三方库实现了 Promise：

- [Q](https://github.com/kriskowal/q)
- [when](https://github.com/cujojs/when)
- [WinJS](http://msdn.microsoft.com/en-us/library/windows/apps/br211867.aspx)
- [RSVP.js](https://github.com/tildeio/rsvp.js)

上面这些库和 JavaScript 原生 Promise 都遵守一个通用的、标准化的规范：
[Promise/A+](https://github.com/promises-aplus/promises-spec),jQuery 有一个类似的方法叫 [Deferreds](http://api.jquery.com/category/deferred-object/),但不兼容 Promise/A+规范，于是会[有一点小问题](https://thewayofcode.wordpress.com/tag/jquery-deferred-broken/)，使用需谨慎。jQuery 还有一个 [Promise 类型](http://api.jquery.com/Types/#Promise),但只是 Defereds 的缩减版，所以也会有同样的问题。

尽管Promise的各路实现遵循同一规范，它们的API还是各不相同。JavaScript Promise的API比较接近RSVP.js，如下创建Promise：

```js
var promise = new Promise(function(resolve,reject){
  // do a thing,possibly async,then...

  if(/* everything turned out fine */){
    resolve("Stuff worked!")
  }else{
    reject("It broken")
  }
})
```

Promise 的构造器接受一个函数作为参数，它会传递给这个回调函数两个变量 resolve 和 reject。在回调函数中做一些异步操作，成功之后调用resolve，否则调用reject。

调用 reject 的时候传递给它一个 Error 对象只是个惯例并非必需，这和经典的 JavaScript中的 throw一样。传递 Error 对象的好处是它包含了调用堆栈，在调试的时候会用点好处。

现在来看看如何使用 Promise：

```js
promise.then(function(result){
  console.log(result) // 
})
```
