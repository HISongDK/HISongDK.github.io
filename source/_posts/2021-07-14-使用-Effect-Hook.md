---
title: 使用 Effect Hook
date: 2021-07-14 21:47:50
tags:
---

## 使用 Effect Hook

_Hook 是 React 16.8 的新增特性。它可以让你在不编写 class 的情况下使用 state 以及其他的 React 特性。_

_Effect Hook_ 可以让你在函数中执行副作用操作

```js
import React, { useState, useEffect } from "react";

function Example() {
  const [count, setCount] = useState(0);

  // Similar to componentDidMount and componentDidUpdate:
  useEffect(() => {
    // Update the document title using the browser API
    document.title = `You clicked ${count} times`;
  });

  return (
    <div>
      <p>You clicked {count} times</p>
      <button onClick={() => setCount(count + 1)}>Click me</button>
    </div>
  );
}
```

这段代码基于上一章节中的计数器示例进行修改，我们为计数器增加了一个小功能：将 document 的 title 设置为包含了点击次数的消息。

数据获取，设置订阅以及手动更改 React 组件中的 DOM 都属于副作用。不管你知不知道这些操作，或是“副作用”这个名字，应该都在组件中使用过它们。

**`提示： 如果你熟悉 React class 的生命周期函数，你可以把 useEffect Hook 看作componentDidMount，componentDidUpdate 和 componentWillUnmount 这三个函数的组合。`**

在 React 组件中有两种常见的副作用操作：需要清除的和不需要清除的。我们来更仔细地看一下它们之间的区别。

### 无需清楚的 effect

有时候，我们只想 **在 React 更新 DOM 之后运行一些额外的代码。**比如发送网络请求，手动变更 DOM ，记录日志，这些都是常见的无需清除地操作。因为我们执行完这些操作之后，就可以忽略他们了。让我们对比一下使用 class 和 Hook 都是怎么实现这些副作用的。

#### 使用 class 的示例

在 React 的 class 组件中，render 函数是不应该有任何副作用的。一般来说，在这里执行操作太早了，我们基本都希望在 React 更新 DOM 之后才执行我们的操作。

这就是为什么在 React class 中，我们把副作用操作放到 componentDidMount 和 componentDidUpdate 函数中。回到示例中，这是一个 React 计数器的 class 组件。它在 React 对 DOM 进行操作之后，立即更新了 document 的 title 属性

```js
class Example extends React.Component {
  constructor(porps) {
    super(props);
    this.state = {
      count: 0,
    };
  }

  componentDidMount() {
    document.title = `点了${this.state.count}次`;
  }
  componentDidUpdate() {
    document.title = `点了${this.state.count}次`;
  }
  render() {
    return (
      <div>
        <p>You clicked {this.state.count} times</p>
        <button onClick={() => this.setState({ count: this.state.count + 1 })}>
          Click me
        </button>
      </div>
    );
  }
}
```

注意，**在这个 class 中，我们需要在两个生命周期中编写重复的代码**。<!--这个注意可把你厉害坏了-->

这是因为很多情况下，我们希望在组件加载和更新后执行同样的操作。从概念上说，我们希望他在每次渲染之后执行————但 React 的 class 组件没有提供这样的方法。即使我们提出一个方法，我们还是要在两个地方调用它。

现在我们来看看如何使用 useEffect 执行相同的操作。

#### 使用 Hook 的示例

我们在本章节开始时已经看到了这个示例，但让我们再仔细观察它：

```js
import React, { useState, useEffect } from 'react';

function Example() {
  const [count, setCount] = useState(0);

  useEffect(() => {
    document.title = `You clicked ${count} times`;
  });

  return (
    <div>
      <p>You clicked {count} times</p>
      <button onClick={() => setCount(count + 1)}>
        Click me
      </button>
    </div>
  );
}
```

**Effect 做了什么？**通过这个 Hook ，你可以告诉 React 组件需要在渲染后执行某些操作。React 会保存你传递的函数（我们将他称之为"effect"),并且在执行 DOM 更新之后调用它。在这个 effect 中，我们设置了 document 的 title 属性，不过我们也可以执行数据获取或调用其他命令式的 API。

**为什么在组件内部调用 useEffect？** 将 useEffect 放在组件内部让我们可以在 effect 中直接访问 count state 变量（或其他 porps）。我们不需要特殊的 API 来读取它————它已经保存在函数作用域中了。Hook 使用了 JavaScript 的闭包机制，而不用在 JavaScript 已经提供了解决方案的情况下，还引入特定的 React API。

**useEffect 会在每次渲染后都执行么？**是的，默认情况下，他在第一次渲染之后和每次更新之后都会执行。（我们稍后会谈如何控制它）你可能更容易接受 effect 发生在"渲染之后"这种概念，不用去考虑"挂载"还是"更新"。**React 保证了每次运行 effect 的同时，DOM 都已经更新完毕。**

### 详细说明

我们已经对 effect 有了大致了解，下面这些代码应该不难看懂了：

```js
function Example() {
  const [count, setCount] = useState(0);

  useEffect(() => {
    document.title = `You clicked ${count} times`;
  });
}
```

我们声明了 count state 变量，并告诉 React 我们需要使用 effect 。紧接着传递给 useEffect Hook。此函数就是我们的effect。然后使用 document.title 浏览器 API 设置 document的title。我们可以在 effect 中获取到最新的 count 值，因为他在函数的作用域内。当 React 渲染组件时，会保存以使用的 effect，并在更新完 DOM 后执行它。这个过程在每次渲染时都会发生，包括首次渲染。

经验丰富的 JavaScript 开发人员可能会注意到，传递给 useEffect 的函数在每次渲染中都会有所不同，这是刻意为之的。事实上这真是我们可以在 effect 中获取最新的 count 的值，而不用担心其过期的原因。每次我们重新渲染，都会生成新的 effect ，替换掉之前的。莫种意义上讲，effect 渲染结果的一部分————每个 effect “属于”一次特定的渲染。我们将在本章节后续部分更清楚地了解这样做的意义。

**`提示： 与 componentDidMount 或 componentDidUpdate 不同，使用 useEffect 调度的 effect 不会阻塞浏览器更新屏幕，这让你的应用看起来响应更快。大多数情况下，effect 不需要同步的执行。在个别情况下（例如测量布局），有单独的 useLayoutEffect Hook 供你使用，其 API 与 useEffect相同`**

### 需要清除的 effect

之前我们研究了如何使用不需要清除的副作用，还有一些副作用是需要清除的。例如 **订阅外部数据源**。这种情况下，清除工作是非常重要的，可以防止内存泄漏！现在让我们来比较一下如何用 Class 和 Hook 来实现。

#### 使用 Class 的示例

在 React class 中，你通常会在 componentDidMount 中设置订阅，并在 componentWillUnmount 中清除它。例如，假设我们有一个 ChatAPI 模块，它允许我们订阅好友的在线状态。以下是我们如何使用 class 订阅和显示该状态：

```js
class FriendStatus extends React.Component {
  constructor(props) {
    super(props);
    this.state = { isOnline: null };
    this.handleStatusChange = this.handleStatusChange.bind(this);
  }

  componentDidMount() {
    ChatAPI.subscribeToFriendStatus(
      this.props.friend.id,
      this.handleStatusChange
    );
  }
  componentWillUnmount() {
    ChatAPI.unsubscribeFromFriendStatus(
      this.props.friend.id,
      this.handleStatusChange
    );
  }
  handleStatusChange(status) {
    this.setState({
      isOnline: status.isOnline
    });
  }

  render() {
    if (this.state.isOnline === null) {
      return 'Loading...';
    }
    return this.state.isOnline ? 'Online' : 'Offline';
  }
}
```

你会注意到 componentDidMount 和 componentWillUnmount 之间相互对应。使用生命周期函数迫使我们拆分这些逻辑代码，即使这两部分代码都作用与相同的副作用。

**`注意： 眼尖的读者可能已经注意到，这个实例还需要编写 componentDidUpdate 方法才能保证完全正确。我们先暂时忽略这一点，本章节后续部分会介绍它。`**

#### 使用`Hook`的示例

如何使用 Hook编写这个组件

你可能认为需要单独的 effect 来执行清楚操作。但由于添加和删除订阅的代码的紧密性，所以 useEffect 的设计是在同一个地方执行。如果你的 effect 返回一个函数，React 将会在执行清除操作时调用它：

```js
import React, { useState, useEffect } from 'react';

function FriendStatus(props) {
  const [isOnline, setIsOnline] = useState(null);

  useEffect(() => {
    function handleStatusChange(status) {
      setIsOnline(status.isOnline);
    }
    ChatAPI.subscribeToFriendStatus(props.friend.id, handleStatusChange);
    // Specify how to clean up after this effect:
    return function cleanup() {
      ChatAPI.unsubscribeFromFriendStatus(props.friend.id, handleStatusChange);
    };
  });

  if (isOnline === null) {
    return 'Loading...';
  }
  return isOnline ? 'Online' : 'Offline';
}
```

**为什么要在 effect 中返回一个函数？**这是 effect **可选的清除机制**。每个 effect 都可以返回一个清楚函数。如此可以将添加和移除订阅的逻辑放在一起。它们都属于 effect 的一部分。

**React 何时清除 effect？**React 会在组件卸载的时候执行清楚操作。正如之前学到的，effect 在每次渲染的时候都会执行。这就是为什么 React 会在执行当前 effect 之前对上一个 effect 进行清除。我们稍后会讨论为什么这将有助于避免 bug ，以及如何在遇到性能问题时跳过此行为。

**`注意： 并不是必须为 effect 中返回的函数命名。这里我们将其命名为 cleanup 是为了表明此函数的目的，但其实也可以返回一个箭头函数或者给起一个别的名字`**

### 小结

了解了 useEffect 可以在组件渲染后实现各种不同的副作用。有些副作用可能需要清楚，所以需要返回一个函数：

```js
useEffect(() => {
    function handleStatusChange(status) {
      setIsOnline(status.isOnline);
    }

    ChatAPI.subscribeToFriendStatus(props.friend.id, handleStatusChange);
    return () => {
      ChatAPI.unsubscribeFromFriendStatus(props.friend.id, handleStatusChange);
    };
  });
```

其他的 effect 可能不必清除，所以不需要返回。

```js
useEffect(()=>{
  document.title = `You clicked ${count} times`
})
```

effect Hook 使用同一个 API 来满足这两种情况。

---

**如果你对 Effect Hook 的机制已经有很好的把握，或者暂时难以消化更多内容，你现在就可以跳转到下一章节学习 Hook 的规则。**

---
---

### 使用 Effect 的提示
