---
title: REACT 井字棋
tags:
---
- [环境准备](#环境准备)
  - [方式一：在浏览器中编写代码[^1]](#方式一在浏览器中编写代码1)
  - [方式二：搭建本地环境](#方式二搭建本地环境)
- [概览](#概览)
  - [React 是什么](#react-是什么)
  - [阅读初始代码](#阅读初始代码)
  - [通过 Props 传递数据](#通过-props-传递数据)
  - [给组件添加交互功能](#给组件添加交互功能)
  - [开发者工具](#开发者工具)
  - [游戏完善](#游戏完善)
  - [状态提升](#状态提升)
  - [为什么不可变性在 React 中非常重要](#为什么不可变性在-react-中非常重要)
    - [简化复杂的功能](#简化复杂的功能)
    - [跟踪数据的变化](#跟踪数据的变化)
    - [确定在 React 中何时重新渲染](#确定在-react-中何时重新渲染)
    - [函数组件](#函数组件)
  - [轮流落子](#轮流落子)
  - [判断出胜者](#判断出胜者)
  - [时间旅行](#时间旅行)
    - [保存历史记录](#保存历史记录)
    - [再次提升状态](#再次提升状态)
    - [选择一个 key](#选择一个-key)
    - [实现时间旅行](#实现时间旅行)
- [总结](#总结)
<!-- # 井字棋 -->
<!-- more -->
## 环境准备

完成这篇教程有两种方式：

1. 可以直接在浏览器中编写代码
2. 也可以在你电脑上搭建本地开发环境

### 方式一：在浏览器中编写代码[^1]

[^1]: 不考虑

### 方式二：搭建本地环境

这是完全可选的，本教程不强制要求。

可选项：使用你喜欢的文本编辑器进行本地开发的步骤：

虽然在本地搭建环境要费一些时间，但是你可以选择自己喜欢的编辑器来完成开发。以下是具体步骤：

1. 确保你安装了较新版本的 `Nodejs`
2. 按照`Create React App`[安装指南](https://zh-hans.reactjs.org/docs/create-a-new-react-app.html#create-react-app)创建一个新的项目

   ```js
   npx create-react-app my-app
   // 由此可见 得使用 npx 命令
   // 项目名称可以有 连字符 但是不能大写
   ```

3. 删除掉新项目`src/`文件夹下的所有文件

   ```bash
   注意：
   不要删除整个 src 文件夹
   删除里面的源文件
   我们会在接下来的步骤中使用示例代码替换原文件

   // 删除命令：
   cd hello-vue3
   cd src

   # 如果你使用 Mac 或 Linux：
   rm -f *

   # 如果你使用 Windows：
   del *

   # 然后回到项目文件夹
   cd ..
   ```

4. 在`src/`文件夹下创建一个名为`index.css`的文件，并拷贝这[些 CSS 代码](https://codepen.io/gaearon/pen/oWWQNa?editors=0100)。

5. 在`src/`文件夹下创建一个名为`index.js`的文件，并拷贝[这些 JS 代码](https://codepen.io/gaearon/pen/oWWQNa?editors=0010)

6. 拷贝以下三行代码到`src/`文件夹下的`index.js`文件的顶部：

```js
import React from "react";
import ReactDOM from "react-dom";
import "./index.css";
```

现在，在项目文件夹下执行`npm start`命令，然后在浏览器访问`http://localhost:3000`。这样你就可以在浏览器中看见一个空的井字棋的棋盘了。

## 概览

你已经准备好了，让我们先大致了解一些 React 吧！

### React 是什么

React 是一个声明式，高效且灵活的用于构建用户界面的 JavaScript 库。使用 React 将一些简短、独立的代码片段组合成复杂的 UI 界面，这些代码被称作组件。

React 中拥有多种不同类型的组件，我们先从`React.Component`的子类开始介绍：

```js
class ShoppingList extends React.Component {
  render() {
    return (
      <div className="shopping-list">
        <h1>Shopping List for {this.props.name}</h1>
        <ul>
          <li> Instagram </li>
          <li> WhatsApp </li>
          <li> Oculus </li>
        </ul>
      </div>
    );
  }
}
// 用法示例： <ShoppingList name="mark">
```

我们马上会谈论这些又奇怪、又像 XML 的标签。我们通过使用组件来告诉 React 我们希望在屏幕上看到什么。当数据发生改变时，React 会高效地更新并重新渲染我们的组件。

其中，ShoppingList 是一个 React 组件累，或者说是一个 React 组件类型。一个组件接收一些参数，我们把这些参数叫做 props （“props”是“property”简写），然后通过 render 方法返回需要展示在屏幕上的视图层次结构。

render 方法的返回值 _描述了_ 你希望在屏幕上看到的内容。 React 根据描述，把结果展示出来。更具体地来说，render 返回了一个 React 元素，这是一种对渲染内容的 **轻量级** 描述。大多数的 React 开发者使用一种名为 "JSX" 的特殊语法，JSX 可以让你更轻松的书写这些结构。语法`<div/>`会被编译成 `React.createElement('div')`。上述的代码等同于：

```js
return React.createElement('div',{className:'shopping-list'},
   React.createElement('h1',/* ... h1 children ... */),
   React.createElement('ul',/* ... ul children ... */)
),
```

如果你对这个比较感兴趣，可以查阅 API 文档了解有关`createElemnt()`更详细的用法。但是接下来的教程中，我们并不会直接使用这个方法，而是继续使用 **JSX**。

在 JSX 中你可以任意使用 **JavaScript 表达式**，只需要用一个大括号括起来。

每一个 React 元素 事实上都是一个 _JavaScript 对象_，你可以在你的程序里把它保存在变量中或者作为参数传递。

前文中的 `ShoppingList` 组件只会渲染一些内置的 DOM 组件（是说标签元素吧）,如`<div />、<li />`等。但是你也可以组合和渲染自定义的 React 组件。例如，你可以通过 `<ShoppingList />`来表示整个购物清单组件。每个组件都是封装好的，并且可以单独运行，这样你就可以通过简单的组件来构建复杂的 UI 界面。

### 阅读初始代码

如果你要在 **浏览器** 中学习该教程，在新标签页中打开初始代码。
如果你要在本地环境中学已开发该教程的内容，就在你的工程文件夹下打开 `src/index.js`（你已经在前面的环境准备中创建过这个文件了） <!-- Yes I remember -->

这些初始代码，是我们要开发小游戏的基础代码。我们已经提供了 CSS 样式，这样你只需要关注使用 React 来开发这个井字棋了。

通过阅读代码，你开一看到我们又三个 React 组件：

- Square
- Board
- Game

Square 组件渲染了含有默认值的一个棋盘，我们一会会修改这些默认值。到目前为止还没有可以交互的组件。

### 通过 Props 传递数据

让我们试试水，尝试将数据从 Board 组件传递到 Square 组件中。

我们强烈建议你手动编写本教程中的代码，不要使用 _复制/粘贴_ 。这将加深你对 React 的记忆和理解。

在 Board 组件中的 `renderSquare` 方法中，我们将代码改写成下面这样，**传递一个名为`value`的`prop`到`Square`组件当中**：

```js
class Board extends React.Component {
  renderSquare(i) {
    return <Square value={i} />;
    // 封装成 函数 应该就是方便【传参】调用
    // 也简化了书写，要不然使用到的每个【Square】组件都要写【value】属性了
  }
}
```

修改 Square 组建中的 render 方法，把 `l{/* TODO */}`，以显示上文传入的值：

```js
class Square extends React.Component {
  render() {
    return <button className="Square">{this.props.value}</button>;
  }
}
```

恭喜你！你刚刚成功地把一个 prop 从父组件 Board **传递** 给了子组件 Square 。在 React 应用中，数据通过 props 的传递，从父组件流向子组件。

### 给组件添加交互功能

接下来我们试着让期盼的每一个格子在点击之后能落下一颗 "X" ,作为棋子。首先，我们把 Square 组件中的 render() 方法的返回值中 button 标签修改为如下内容：

```js
class Square extends React.Component {
  render() {
    return (
      <button className="Square" onClick={() => alert("click")}>
        {this.porps.value}
      </button>
    );
  }
}
```

如果此刻点击某个格子，浏览器就会弹出提示框。

`注意: 为了减少代码量，同时避免*[this]造成的困扰，我们在这里使用 [箭头函数] 来进行事件处理。`
`注意：此处使用了*onClick={()=>alert("click")}*的方式向*onClick*这个*prop*传入一个函数。 React 将在单机时调用此函数。但很多人经常忘记编写 ()=> ,而写成 onClick = {alert("click")},这种常见的错误会导致每次这个组件渲染的时候都会出发弹出框`

接下来，我们希望 Square 可以 “记住” 他被点击过，然后用 “X" 来填充对应的方格。我们用 state 来实现所谓的 “记忆” 功能。

可以通过在 React 组建的构造函数中设置 this.state 来初始化 state。 this.state 应该被是为一个组建的私有属性。我们在`this.state`中储存当前每个方格（Square）的值，并且在每次方格被点击时改变这个值。

首先，我们向这个 class 中添加一个构造函数，用来初始化 state：

```js
class Square extends React.Component{
   constructor(props){
      super(props)

      this.state = {
         value:null,
      }
   }

   render(){
      return (
         <button className="square" onClick={() => alert('click')}>
            {this.props.value}
         </button>
         );
      }
   }
}
```

`注意：在JavaScript中，每次你定义其子类的构造函数时，都需要调用 super 方法。因此，在所有含有构造函数的 React 组件中，**构造函数必须以super(props)开头**。`<!--这件事我一直想知道原因-->

现在，我们来修改一下 Square 组件的 render 方法，这样，每当方格被点击的时候，就可以显示当前 state 的值了：

- 在`button`标签中，把`this.props.value`替换为 `this.state.value`
- 将`onClick={...}`事件监听函数替换为`onClick={()=>this.setState({value:"X"})}`。
- 为了更好的可读性，将`className`和`onClick`的 prop 分两行书写。

修改之后，Square 组件中的 render 方法的返回值中的 button 标签变成了下面这样：

```js
class Square extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      value: null,
    };
  }

  render() {
    return (
      <button className="Square" onClick={() => this.setState({ value: "X" })}>
        {this.state.value}
      </button>
    );
  }
}
```

在 Square 组件 render 方法中 onClick 事件监听函数中调用 this.setState ,我们就可以在每次 `<button>`被点击的时候通知 React 去重新渲染 Square 组件。组件更新之后，Square 组件的 this.state.value 的值会变为 “X”，因此，我们在游戏棋盘上就能看见 X 了。点击任意一个方格， X 就会出现。

每次在组件中调用 `setState` 时，React 都会自动更新其子组件。

### 开发者工具

在 Chrome 或者 Firefox 中安装扩展 `React Devtools`可以让你在浏览器开发工具中查看 React 组件树。

你还可以在 React Devtools 中检查 React 组件的 state 和 props 。

安装 React Devtools 之后，右键点击页面的任何一个元素，然后选择**查看**，这样就能打开浏览器的开发者工具了，并且工具栏最后会多展示一个 React 的选项卡（包含 `components`和`profiler`）。你可以使用 _components_ 来检查组件树。

### 游戏完善

我们现在已经编写好了，游戏中最基础的可以落子的棋盘。为了开发一个完整的游戏，**我们还需要交替在棋盘上放置“X”和“O”，并且判断出胜者**

### 状态提升

当前，每个 Square 组件都维护了游戏的状态。我们可以把所有 9 个 Square 放在一个地方，这样我们就可以判断出胜者了。

你可能回想，我们也可以在棋盘 Board 组件中收集每个格子 Square 组件中的 state。虽然技术上来讲是可以实现的，但是代码如此编写会让人很难理解，并且我们以后想要维护重构时也会非常困难。

所以，最好的解决方式是直接将所有的 **state** 状态数据存储在 Board 父组件当中。之后 Board 组件可以将这些数据通过 props 传递给各个 Square 子组件，正如上文：我们把数字传递给每个 Square 一样。

**`当你需要同时获取多个子组件的数据，或者两个组件之间需要相互通讯的情况下，需要把自组建的 state 提升至其共同的父组件当中保存。之后父组件可以通过 props 将状态数据传递到子组件当中。这样应用当中所有的组件状态数据就能够方便的同步共享了`**

像这种将组件 state 提升到父组件的情形在重构 React 组件时经常会遇到————借此我们来实践一下。

为 Board 组件添加构造函数，将 Board 组件的初始状态设置为长度为 9 的空值数组：

```js
// 唉！。。。
// 到这我可以理解：分别获取每个子组件的状态就算可实现也是不切实际。所以通过父组件统一控制状态并分发给子组件确实是很好的选择。
// 但是我是真的没想到父组件要，设定什么样的状态数据结构，也完全想不到怎么去实现
class Board extends React.Component{
   constructor(props){
      super(props)
      this.state={
         squares=Array(9).fill(null)
         // 高级，这数组操作我是没掌握
      }
   }

   renderSquare(i){
      return <Square value={i}>
   }
}
```

当我们填充棋盘后，`this.state.squares`数组的值可能如下所示：

```js
["O", null, "X", "X", "X", "O", "O", null, null];
// 本来还在想数组怎么会呈现这样的结构呢
// 原来就是三个一换行啊
```

开始时，我们依次把 0 到 8 的值通过 prop 从 Board 向下传递，从而让他们显示出来。上一步与此不同，我们根据 Square 自己内部的 state， 使用了 “X” 来代替之前的数字。因此，Square 忽略了从 Board 传递给它的那个 `value` prop。

让我们再一次使用 prop 的传递机制。我们通过修改 Board 来指示每一个 Square 的当前值（“X”，“O",或者 null）。我们在 Board 的构造函数中已经定义好了 squares 数组，这样，我们就可以通过修改 Board 的 renderSquare 方法来读取这些值了。

```js
renderSquare(i){
   return <Square value={this.state.squares[i]}>
   // 我是真没想到，之前每个穿的数组干什么用，做个标识看看么
   // 没想到能直接拿到这当 数组 索引 绝了
   // 还有就是，本来点击显示 X ，之后不是该讲显示 O 了么？
   // 怎么就岔开将状态提升了，原来之前显示 X 只是个示例
   // 真实优化修改还没讲到啊
}
```

这样，每个 Square 就都能结束到一个 `value` prop 了，这个 prop 的值可以是 "X"、"O"或 null（null 代表空方格）。

接下来，我们要修改一下 Square 的点击事件监听函数。Board 组件当前维护了那些已经被填充了的方格。**我们需要想办法让 Square 去更新 Board 的 state**。由于 state 对于每个组件来说是私有的，因此我们不能直接通过 Square 来更新 Board 的 state 。

相反，**从 Board 组件向 Square 组件传递一个函数，当 Square 被点击的时候，这个函数就会被调用。**接着，我们将 Board 组件的 renderSquare 方法改写为如下效果：

```js
renderSquare(i){
   return(
      <Square
         value={this.state.squares[i]}
         onClick={()=>this.handleClick(i)}
      />
   )
}
```

**`注意：为了提到可读性，我们把返回的 React 元素拆分成了多行。同时在最外层加了小括号，这样 JavaScript 解析的时候就不会咋 return 的后面自动插入一个分号，从而破坏代码结构了`**

现在我们从 Board 组件向 Square 组件中传递了两个 porps 参数 value 和 onClick 。onClick prop是一个 Square 组件点击事件监听函数。接下来，我们需要修改 Square 的代码：

- 将 Square 组件的 render 方法中的 this.state.value 替换为 this.props.value

- 将 Square 组件的 render 方法中的 this.setState() 替换为 `this.props.onClick()`
  <!-- 我真是没想到 这个属性还真的要在子组件里面重新调用一下 我是真懵 -->
  <!-- 我还以为子组件里面点击事件都不需要了 -->
  <!-- 还是 too young 啊 -->
- 删除 Square 组件中的构造函数 constructor ，该组件不需要再保存游戏的 state

进行上述修改之后，代码会变成下面这样：

```js
class Square extends React.Component{
  render(){
    return (
      <button 
        className="Square"
        onClick={()=>this.props.onClick()}
      >
        {this.props.value}
      </button>
    )
  }
}
```

每一个 Square 被点击时，Board 提供的 onClick 函数就会触发。我们回顾一下这是怎么实现的：

1. 向 DOM 元素 button **添加 onClick prop ，让 React 开启对点击事件的监听。**
2. 当 button 被点击时， React 会调用 Square 组件的 render() 方法中 onClick 事件处理函数
3. 事件处理函数触发了传入其中的 `this.props.onClick()` 方法。这个方法是由 Board 组件传递给 Square 的。
4. 由于 Board 把 `onClick={()=>this.handleClick(i)}` 传递给了 Square ，所以当 Square 中的事件处理函数触发时，其实就是出发的 Board 当中的 this.handleClick(i) 方法。
5. 我们还未定义 handleClick 方法，所以代码还不能正常工作。如果此时点击 Square ，你会在屏幕上看到红色的错误提示，提示内容为： " this.handleClick is not a function "。
  
**`注意：因为 DOM 元素 <button/> 是一个内置组件[ 哦哦懂了，我一直以为该说时html元素的，原来这是指 react 内置组件啊 ]`**

这时候我们点击 Square 的时候,浏览器汇报从,因为我们还没有定义 handleClick 方法。我们现在来向 Board 里添加 handleClick 方法：

```jsx
 class Board extends React.Component{
   constructor(props){
     super(props)
     this.state = {
       squares: Array(9).fill(null)
     }
   }
   
   handleClick(i){
     const squares = this.state.squares.slice();
     // slice 是生成一个深拷贝的新数组么？
     squares[i] = "X"
     this.setState({
       squares:squares
     })
     // 还有一点想到就是，这个存状态的数据，竟然不直接 map 生成 jsx ，而是一个个写出来，调用函数，传入 1~9 数字作为索引。
     // 是让初学者更容易看懂么？
   }

   renderSquare(i){
     return (
       <Square
        value = {this.state.squares[i]}
        onClick = {()=>this.handleClick(i)}
        // 刚才还纳闷，方法为什么都不用箭头函数
        // 想到可能是：使用箭头函数 或者 bind this 都是解决 this 指向的，方法里面没用到 this 自然不用
       />
     )
   }

   render(){
     const status = "Next player: X"

     return (
       <div>
        <div className="status">{ status }</div>       
        <div className="board_row">
          {/* class 我还是用下划线吧，毕竟不会像连字符一样当成两个独立的单词 */}
          {this.renderSquare(1)}
          {this.renderSquare(2)}
          {this.renderSquare(3)}
        </div>
        <div className="board_row">
          {this.renderSquare(4)}
          {this.renderSquare(5)}
          {this.renderSquare(6)}
        </div>
        <div className="board_row">
          {this.renderSquare(7)}
          {this.renderSquare(8)}
          {this.renderSquare(9)}
        </div>
       </div>
     )
   }
 }
```

现在，我们可以通过点击 Square 来填充那些方格，效果与之前相同。但是，当前 state 没有保存再单个的 Square 组件中，而是保存在了 Board 组件中。每当 Board 的 state 发生变化的时候，这些 Square 组件都会重新渲染一次。把所有的 Square 的 state 保存再 Board 组件中可以让我们在将来判断出游戏的胜者。

因为 Square 组件不再持有 state，因此每次他们被点击的时候，Square 组件就会从 Board 组件中接受值，并且通知 Board 组件。在 React 术语中，我们把目前的 Square 组件称作“受控组件”。在这种情况下，Board 组件完全控制了 Square 组件。

注意，我们调用了 `.slice()` 方法创建了 `squares` 数组的一个副本，而不是直接在现有的数组上进行修改。在协议姐，我们会介绍为什么我们需要创建 `square`数组的副本。

### 为什么不可变性在 React 中非常重要

在上一节内容当中，我们建议使用 `.slice()` 方法对数组进行拷贝，而非直接修改现有的数组。
接下来我们学习 **不可变性** 以及 **不可变性的重要性**。

一般来说，有两种改变数据的方式。第一种方式是直接 *修改* 变量的值，第二种方式是 *使用新的一份数据替换旧数据*

**直接修改数据：**

```js
var player = {score:1,name:'jeff'};
play.score = 2;
// player 修改后的值为 {score:2,name:'jeff'}
```

**新数据替换旧数据：**

```js
var player = {score:1,name:'jeff'}
var newPlayer = Object.assign({},player,{score:2});
// player 的值没有改变， newPlayer 的值为 {score:2,name:'jeff'}

// 使用对象展开语法，可以写成：
var newPlayer= {...player,score:2}
```

不直接修改（或改变底层数据）这种方式和前一种方式的结果是一样的，这种方式有一些几点好处：

#### 简化复杂的功能

不可变性使得复杂的特性更容易实现。在后面的章节里，我们会实现一种叫做“时间旅行”的功能。“时间旅行”可以使我们回顾井字棋的历史步骤，并且可以“跳回”之前的步骤。这个功能并不是只有游戏才会用到————撤销和恢复功能在开发中是一个很常见的需求。<!--确实，我有一个取消的功能就没有实现-->不直接修改可以让我们追溯并复用游戏的历史纪录。

#### 跟踪数据的变化

如果直接修改数据，那么就很难跟踪到数据的改变。跟踪数据的改变需要可变对象可以与改变之前的版本进行对比，这样整个对象树都需要被遍历一次。

跟踪不可变数据的变化相对来说就容易多了。如果发现对象变成了一个新对象，那么我们就可以说对象发生改变了。

#### 确定在 React 中何时重新渲染

不可变性最主要的优势在于它可以帮助我们在 React 中创建 *pure components* 。我们可以很轻松的确定不可变数据是否发生了改变，从而确定合适对组件进行重新渲染。

查阅性能优化章节，以了解更多有关 should ComponentUpdate() 函数及如何构建 pure components 的内容。

#### 函数组件

接下来我们把 Square 组件重写为一个 **函数组件**。

如果你想写的组件只包含一个 render 方法，并且不包含 state ，那么使用 **函数组件** 就会更简单。 我们不需要定义一个 继承于 React.Component 的类，我们可以定义一个函数，这个函数接受 *props* 作为参数，然后返回需要渲染的元素。函数组件写起来不像 class 组件那么繁琐，很多组件都可以使用函数组件来写。

把 Square 类替换成下面的函数：

```js
function Square(props){
  return (
    <button className = "square" onClick={props.onClick}> {props.value} </button>
  )
}
```

我们把两个 this.props 都换成了 props 。

**`注意：当我们把 Square 修改成函数组件时，我们同时也把 onClick={()=>this.props.onClick()} 改成了更短的 onClick={props.onClick}`(注意：两侧都没括号)**
<!-- 光让我注意，也不讲讲为啥 -->

### 轮流落子

现在井字棋还有一个明显的缺陷有待完善：目前还不能在棋盘上标记 "O"。
我们将 "X" 默认设置为先手棋。你可以通过修改 Board 组件构造函数中的初始 state 来设置默认的第一步棋子：

```js
class Board extends React.Component{
  constructor(props){
    super(props)
    this.state = {
      square:Array(9).fill(null),
      xIsNext:true,
      // 我还在想，不是说设置默认先手棋么?为啥不直接整个 first: 'X',
      // 就是没想到这个可以直接判断每一步该落什么子，X 落过子之后，把 xIsNext 设置为 false 就能直接落 'O' 子了
    }
  }
}
```

棋子每移动一步，xIsNext（布尔值）都会反转，该值将确定下一步轮到哪个玩家，并且游戏的状态会被保存下来。我们将通过修改 Board 组件的函数 handleClick 函数来反转 xIsNext 的值：

```js
handleClick(i){
  const square = this.state.squares.clice();
  square[i] = this.state.xIsNext ? "X" : "O";
  this.setState({
    squares:square,
    xIsNext:!this.state.xIsNext,
  })
}
```

修改之后，我们就实现了 “X” 和 "O" 轮流落子的效果，试玩一下。

接下来修改 Board 组件 render 方法中的 "status" 的值，这样就可以显示下一步是哪个玩家的了。

```js
render(){
  const status = 'Next player is' + (this.xIsNext ? "X" : "O")
}
```

现在你整个的代码应该是这样子的： 略！

### 判断出胜者

至此我们就可以看出下一步会轮到哪位玩家，与此同时，我们还要显示游戏的结果来判定游戏结束。拷贝如下 `calculateWinner` 函数并粘贴到文件底部：

```js
function calculateWinner(squares){
  const lines = [
    // 三行
    [0,1,2],
    [3,4,5],
    [6,7,8],
    // 三列
    [0,3,6],
    [1,4,7],
    [2,5,8],
    // 一个叉
    [0,4,8],
    [2,4,6],
    // 只要用状态通过这个索引判断,是不是相等的,就能判断出胜利者
  ];

  for(let i = 0 ; i<lines.length;i++){
    const [a,b,c] = lines[i];

    if(squares[a] && squares[a] === squares[b] && squares[a]=== squares[c]){
      return squares[a]
    }
  }
  return null;
}
```

传入长度为 9 的数组，此函数将判断出获胜者，并根据情况返回 "X","O",或"null"。
<!-- 本来没看懂,想了一下,妈的绝了 -->
<!-- 我怎么才能相通这些逻辑呢 -->
<!-- 还是只能通过模仿 -->
<!-- 唉 长路漫漫 -->

接着,在 Board 组件中的 render 方法中调用,这个 calculateWinner(squares) 方法检测是否有玩家胜出。一旦有玩家获胜，就把获胜玩家的信息展示出来。

比如,"胜者: X" 或者 "胜者: O" 。现在，我们把 Board 的 render 函数中 status 的定义修改为如下代码：

```js
const winner = calculateWinner(this.state.squares)
let status;
if (winner){
  status = "Winner: " + winner
}else{
  status = "Next player is: " + (this.state.xIsNext ? "X" : "O"
}

return (
  // 其他部分没有修改
```

最后,修改 handleClick 事件,当有玩家胜出,或者某个 Square 已经填充时,该函数不做任何处理直接返回.

```js
handleClick(i){
  const squares = this.state.squares.clice()
  if(calculateWinner(squares) || squares[i]){
    return
  }
  // 啊,我本来就想过,要是点击落子之后,再次点击的话就直接覆盖了,这个你要怎么处理,还有就是结束之后呢
  // 就是没想到,可以直接判断后,不执行更改状态的函数
  // 更想不到直接这么判断就可以,代码写的很简洁
  // 服气的
  square[i] = this.state.xIsNext? "X": "O"
  this.setState({
    suqares,
    xIsNext: !this.state.xIsNext
  })
}
```

恭喜!现在你已经完成了井字棋!除此之外,你也已经掌握了 React 的基本常识.所以坚持到这一步的你才是真正的赢家呀!

### 时间旅行

接下来是最后一个练习,我们将实现 "回到过去" 的功能,从而在游戏里跳回到历史步骤.

#### 保存历史记录

如果我们直接修改了 square 数组,实现时间旅行就会变得很棘手了.

不过,我们可以使用 slice() 函数为每一步创建 squares 数组的副本,同时把这个数组当作不可变对像.这样我们就可以把所有 squares 数组的历史版本都保存下来了,然后可以在历史的步骤中随意跳转.

我们把历史的 squares 数组保存在另一个名为 history 的数组中.
history 数组保存了从第一步到最后一步的所有棋盘状态. history 数组的结构如下所示:

```js
history = [
  // 第一步之前
  {
    squares:[
      null, null, null,
      null, null, null,
      null, null, null,
    ]
  },
  // 第一步之后
  {
    squares:[
      null, null, null,
      null, 'X', null,
      null, null, null,
    ]
  },
  // 第二步之后
  {
    squares:[
      null, null, null,
      null, 'X', null,
      null, null, 'O',
    ]
  },
  // ...
]
```

现在,我们需要确定应该在哪一个组件中保存 history 这个 state.

#### 再次提升状态

我们希望顶层 Game 组件展示出一个历史步骤的列表.这个功能需要访问 history 的数据,因此我们把 history 这个 state 放在顶层的 Game 组件中.

我们把 history state 放在了 Game 组件中,这样就可以从它的子组件 Board 里面删掉 square 中的 state . 正如我们把 Square 组件的抓过你太提升到 Board 组件一样,现在我们来吧 state 从 Board 组件提升到顶层的 Game 组件里.这样,Game 组件就拥有了对 Board 组件数据的完全控制权,除此之外,还可以让 Game 组件控制 Board 组件,并根据 history 渲染历史步骤.

首先,我们在 Game 组件中的构造函数中初始化 state:

```js
class Game extends React.Component {
  constructor(props){
    super(props)
    this.state = {
      history:[{
        suqares:Array(9).fill(null)
      }],
      xIsNext: true,
    }
  }

  render(){
    return(
      <div className="game">
        <div className="game_board">
          <Board />
        </div>
        <div className="game_info">
          <div>{/* status */}</div>
          <ol>{/* TODO */}</ol>
        </div>
      </div>
    )
  }
}
```

下一步,我们让 Board 组件从 Game 组件中接收 squares 和 onClick 这两个 props . 因为当前在 Board 组件中已经有一个对 square 点击事件的监听函数,这样监听函数就知道具体哪一个 Square 被点击了.以下是修改 Board 组建的几个必要步骤:

- 删除 Board 组件中的`constructor`构造函数.
- 把 Board 组件中的 renderSquare 中的 `this.state.squares[i]` 替换为 `this.props.squares[i]`.
- 把 Board 组件的 renderSquare 中的 `this.handleClick(i)` 替换为 `this.props.onClick(i)`

修改后的 Board 组件如下所示:

```js
class Board extends React.Component{
  handleClick(i){
    const squares = this.state.squares.slice();
    if(calculateWinner(squares) || squares[i]){
      return:
    }
    squares[i]=this.state.xIsNext ? "X" : "O"
    this.setstate({
      squares,
      xIsNext:!this.state.xIsNext
    })
  }

  renderSquares(i){
    return (
      <Square 
        value={this.props.value}
        onClick={()=>this.props.onClick(i)}
      />
    )
  }

  render(){
    // 通过状态派生出的内容可以定义在 render 函数的顶部
    const winner = calculateWinner(this.state.squares)
    let status;
    if(winner){
      status = "winner is " + winner
    }else{
      status = "next player is " + (this.state.xIsNext ? "X" : "O")
    }

    return (
      <div>
        <div className="status">{status}</div>
        <div className="board-row">
          {this.renderSquare(0)}
          {this.renderSquare(1)}
          {this.renderSquare(2)}
        </div>
        <div className="board-row">
          {this.renderSquare(3)}
          {this.renderSquare(4)}
          {this.renderSquare(5)}
        </div>
        <div className="board-row">
          {this.renderSquare(6)}
          {this.renderSquare(7)}
          {this.renderSquare(8)}
        </div>
      </div>
    );
  }
}
```

接着,更新 Game 组件的 render 函数,使用最新一次历史记录来确定展示游戏的状态:

```js
render(){
  const history = this.state.history;
  const current = this.state.history[history.length-1]
  const winner = calculateWinner(current.squares)
  let status;
  if(winner){
    status = "winner " + winner
  }else{
    status = "next player :" = (this.state.xIsNext ? "X":"O")
  }

  return (
    <div className="game">
      <div className="game-board">
        <Board
          squares={current.squares}
          onClick={(i) => this.handleClick(i)}
        />
      </div>
      <div className="game-info">
        <div>{status}</div>
        <ol>{/* TODO */}</ol>
      </div>
    </div>
  );
}
```

由于 Game 组件渲染了游戏的抓过你太,因此我们可以将 Board 组件 render 方法中对应的代码移除.修改之后, Board 组件的render 函数如下所示:

```js
  render() {
    return (
      <div>
        <div className="board-row">
          {this.renderSquare(0)}
          {this.renderSquare(1)}
          {this.renderSquare(2)}
        </div>
        <div className="board-row">
          {this.renderSquare(3)}
          {this.renderSquare(4)}
          {this.renderSquare(5)}
        </div>
        <div className="board-row">
          {this.renderSquare(6)}
          {this.renderSquare(7)}
          {this.renderSquare(8)}
        </div>
      </div>
    );
  }
```

最后,我们需要把 Board 组件的 handleClick 方法移动 Game 组件中.同时,我们也需要修改一下 handleClick 方法,因为这两个组件的 state 在结构上有所不同. 在 Game 组件中的 handleClick 方法中,我们需要把新的历史记录拼接到 history 上.

```js
  handleClick(i) {
    const history = this.state.history;
    const current = history[history.length - 1];
    const squares = current.squares.slice();
    if (calculateWinner(squares) || squares[i]) {
      return;
    }
    squares[i] = this.state.xIsNext ? 'X' : 'O';
    this.setState({
      history: history.concat([{
        squares: squares,
      }]),
      xIsNext: !this.state.xIsNext,
    });
  }
```

**`注意: concat() 方法可能与你熟悉的 push() 方法不太一样,它并不会改变原数组,所以我们推荐使用 concat()`**

到目前为止,Board 组件只需要 renderSquare 和 render 这两个方法.而游戏的状态和 handleClick 方法则会放在 Game 组件当中.

由于我们已经记录了井字棋的历史记录,因此我们呢可以把这些记录以历史步骤列表的形式展示给玩家.

在前文中提到的 React 元素,被视为 JavaScript 一等公民中的对象(first-class JavaScript objects),因此我们可以把 React 元素在应用程序中当作参数来传递.在 React 中,我们还可以使用 React 元素的数组来渲染多个元素.

在 JavaScript 中,数组拥有 map() 方法,该方法通常用于把某数组映射为另一个数组,例如:

```js
const numbers = [1,2,3]
const doubled = numbers.map(x=>x*2) // [2,4,6]
```

我们可以通过使用 map 方法,把历史步骤映射为代表按钮的 React 元素,然后可以展示出一个按钮的列表,点击这些按钮,可以"跳转"到对应的历史步骤.

现在,我们在 Game 组件的 render 方法中调用 history 的 map 方法:

```js
  render() {
    const history = this.state.history;
    const current = history[history.length - 1];
    const winner = calculateWinner(current.squares);

    const moves = history.map((step, move) => {
      const desc = move ?
        'Go to move #' + move :
        'Go to game start';
      return (
        <li>
          <button onClick={() => this.jumpTo(move)}>{desc}</button>
        </li>
      );
    });

    let status;
    if (winner) {
      status = 'Winner: ' + winner;
    } else {
      status = 'Next player: ' + (this.state.xIsNext ? 'X' : 'O');
    }

    return (
      <div className="game">
        <div className="game-board">
          <Board
            squares={current.squares}
            onClick={(i) => this.handleClick(i)}
          />
        </div>
        <div className="game-info">
          <div>{status}</div>
          <ol>{moves}</ol>
        </div>
      </div>
    );
  }
```

对于井字棋历史记录的每一步,我们都创建出了一个包含按钮 `<button>` 元素的 `<lI>` 的列表.这些按钮拥有一个 `onClick` 事件处理函数,在这个函数里调用了 `this.jumpTo()` 方法.但是我们还没有实现 `jumpTo()` 方法,到目前为止,我们可以看到一个游戏历史步骤的列表,以及开发者工具控制台的警告信息,警告信息如下:
**`Warning:Each child in an array or iterator should have a unique "key" prop. Check the render method of "Game"`**

我们来看一下上面的警告信息是什么意思.

#### 选择一个 key

当我们要渲染一个列表的时候, React 会存储这个列表每一项的相关信息.当我们要更新这个列表是,React 需要确定哪些项发生了改变.我们有可能增加、删除、重新排序或者更新列表项。

想象一下把下面的代码

```html
<li>Alexa: 7 tasks left</li>
<li>Ben: 5 tasks left</li>
```

转换成下面的代码

```html
<li>Ben: 9 tasks left</li>
<li>Claudia: 8 tasks left</li>
<li>Alexa: 5 tasks left</li>
```

除了数字发生了改变之外,阅读这段代码的人会认为我们把 Alexa 和 Ben 的顺序交换了位置,然后把 Claudia 插入到 Alexa 和 Ben 之间.然而,React 是电脑程序,它并不知道我们想要什么.因为 React 无法得知我们人类的意图,所以我们要给每一个列表项一个确定的 *key* 属性,它可以用来区分不同的列表项和他们的同级兄弟列表项.你可以使用字符串,比如 alexa,ben,Claudia. 如果我们使用从数据库里获取的数据,那么 Alexa、Ben 和 Claudia 的数据库 ID 就可以作为 key 来使用。

```jsx
<li key={user.id}>{user.name}:{user.taskCount} tasks left</li>
```

每当一个列表重新渲染时,React 会根据每一项列表元素的 key 来检索上一次渲染时与每个 key 所匹配的列表项.如果 React 发现当前的列表有一个之前不存在的 key ,那么就会创建出一个新的组件. 如果 React 发现和之前对比上了一个key,那么就会销毁之前对应的组件.如果一个组建的 key 发生了变化,这个组件就会被销毁,然后使用新的 state 重新创建一份.

key 是 React 中一个特殊的保留属性(还有一个是 `ref` ,拥有更高级的特性).当 React 元素被创建出来的时候,React 会提取出`key`属性,然后把 key 直接存储在返回的元素上.虽然 key 看起来好像是 props 中的一个,但是你不能通过`this.props.key`来获取 key .React 会通过 key 来自动判断哪些组件需要更新.组件是不能访问到它的 key 的.

**我们强烈推荐,每次只要你构建动态列表时,都要指定一个合适的 key**.如果你没有找到一个合适的 key,那么你就需要考虑重新整理你的数据结构了,这样才能有合适的key.

如果你没有指定任何 key ,React 会发出警告,并且会把数组的索引当作默认的 key ,但是如果想要对列表进行重新排序、新增、删除操作时，把数组索引作为 key 是有问题的。显式地使用 `key={i}` 来指定 key 确实会消除警告,但是仍然和数组索引存在同样的问题,所以大多数情况下最好不要这么做.

组建的 key 值并不需要在全局都保证唯一,只需要在当前的同一级元素之前保证唯一即可.

#### 实现时间旅行

在井字棋的历史记录中,每一个历史步骤都有一个与之对应的唯一 ID:
这个 ID 就是每一步棋的序号.因为历史步骤不需要重新排序、新增、删除，所以使用步骤的索引作为`key`是安全的。

在 Game 组件的 render 方法中，我们可以这样添加 key ，`<li key= {move}>`,这样关于 key 的警告就会消失了

因为`jumpTo`还未定义,所以你点击列表项会出现报错.实现 jumpTo 之前,我们先向 Game 组件的 state 中添加 stepNumber,这个值代表我们当前正在查看哪一项历史记录.

首先,我们在 Game 的构造函数 constructor 中向初始 state 中添加 `stepNumber: 0`:
<!-- 草!我想到了,通过改这个索引九宫格渲染当前历史state对应的数据,点击列表项更改这个索引就行了-->
<!-- 额…… 我不是想到了，我是看明白了 -->

```js
class Game extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      history: [{
        squares: Array(9).fill(null),
      }],
      stepNumber: 0,
      xIsNext: true,
    };
  }
```

然后,我们在 Game 组件中定义 jumpTo 方法已更新状态 stepNumber .除此之外,当状态 stepNumber 是偶数时,我们还要把 xIsNext 设为 true:

```js
  handleClick(i) {
    // 这个方法无更改
  }

  jumpTo(step) {
    this.setState({
      stepNumber: step,
      xIsNext: (step % 2) === 0,
    });
  }

  render() {
    // 这个方法无更改
  }
```

接下来,我们还要修改 Game 组件的 handleClick 方法,当你点击方格的时候触发该方法.

新添加的 stepNumber state 用于给用户展示当前的步骤.每当我们落下一颗新棋子的时候,我们需要调用 this.setState 并传入参数 `stepNumber:history.length`,以更新 stepNumber.这就保证了每走一步 stepNumber 都会跟着改变.

我们还把读取 this.state.history 换成了读取 `this.state.history.slice(0,this.state.stepNumber + 1)`的值.如果我们"回到过去",然后再走一步新棋子,原来的"未来"历史记录就不正确了,这个替换可以保证我们把这些"未来"的不正确的历史记录丢弃掉.

```js
  handleClick(i) {
    const history = this.state.history.slice(0, this.state.stepNumber + 1);
    const current = history[history.length - 1];
    const squares = current.squares.slice();
    if (calculateWinner(squares) || squares[i]) {
      return;
    }
    squares[i] = this.state.xIsNext ? 'X' : 'O';
    this.setState({
      history: history.concat([{
        squares: squares
      }]),
      stepNumber: history.length,
      xIsNext: !this.state.xIsNext,
    });
  }
```

最后,修改 Game 组件中的 render 方法,将代码从始终根据最后一次移动渲染,修改为根据当前 stepNumber 渲染.

```js
 render() {
    const history = this.state.history;
    const current = history[this.state.stepNumber];
    const winner = calculateWinner(current.squares);

    // 其他部分没有改变
```

如果我们点击游戏历史记录的任意一步,井字棋的棋盘就会立即更新为刚走那一步棋时候的样子.

## 总结

恭喜你! 你已经完成了一个拥有以下功能的井字棋啦:

- tic-toc-toe(三连棋)游戏的所有功能
- 能够判定玩家何时获胜
- 能够记录游戏进程
- 允许玩家查看游戏的历史记录,也可以查看任意一个历史版本的游戏棋盘状态

干得不错!我们希望你至此已经基本掌握了 React 的使用.

在这里可以查看游戏的最终代码:[最终结果](https://codepen.io/gaearon/pen/gWWZgR?editors=0010)

如果你还有充裕的时间,或者想练习一下刚刚学会的 React 新技能,这里有一些可以改进游戏的想法供你参考,这些功能的实现顺序的难度是递增的:

1. 在游戏历史纪录列表显示每一步棋的坐标,格式为(列号,行号)
2. 在历史纪录列表中加粗显示当前选择的项目.
3. 使用两个循环来渲染出棋盘的格子,而不是在代码里写死(hardcode)
4. 添加一个可以升序或降序显示历史记录的按钮
5. 每当有人获胜时,高亮显示连成一线的 3 颗棋子
6. 当无人获胜时,显示一个平局的消息

通过这篇教程,我们接触了 React 中的一些概念,比如 React 元素、React 组件、props，还有 state。更多关于这些概念的细节的解释，参考[文档的其他部分](https://react.docschina.org/docs/hello-world.html)。了解更多关于组件定义的内容，参考[React.Component API reference](https://react.docschina.org/docs/react-component.html)。
