---
title: 使用 State Hook
date: 2021-07-13 21:54:27
tags:
---

## 使用 State Hook

*Hook 是 React 16.8 的新增特性。它可以让你在不编写 class 的情况下使用 state 以及其他的 React 特性。*

Hook 简介章节中使用了下面的例子介绍了 Hook：

```js
import React, { useState } from 'react';

function Example() {
  // 声明一个叫 "count" 的 state 变量
  const [count, setCount] = useState(0);

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

我们将通过将这段代码与一个等价的 class 示例进行比较来开始学习 Hook。

### 等价的 class 示例

如果你之前在 React 中使用 class ，这段代码看起来应该很熟悉：

```js
class Example extends React.Component{
 constructor(props){
  super(props)
  this.state = {
   count: 0
  }
 }

 render(){
  <p>You clicked me {this.state.count} times</p>
  <button onClick={()=>this.setState({count:this.state.count+1})}>
   Click me
  </button>
 }
}
```

state 初始值为 { count: 0 },当用户点击按钮后，我们通过调用 this.setState() 来增加 state.count 。整个章节都将使用该 class 的代码片段做示例。

**`注意： 你可能想知道为什么我们在这里使用一个计数器而不是一个更实际的示例。因为我们还只是初步接触 Hook ，这可以帮助我们将注意力集中到 API 本身`**

### Hook 和 函数组件

复习一下，React 的函数组件是这样的：

```js
const Example = (props) =>{
 // 你可以在这使用 Hook 
 return <div/>
}
```

或是这样的：

```js
function Example(props){
 // 你可以在这使用 Hook
 return <div/>
}
```

你之前可能把他们叫做 *无状态组件* 。但现在我们为它们引入了使用 React state 的能力，所以我们更喜欢叫他 *函数组件* 。

Hook 在 class 内部是不起作用的。但是你可以使用他们来取代 class 。

### Hook 是什么


