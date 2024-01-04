---
title: react-router
tags: NodeJS
categories:
  - 随敲
  - NodeJS
date: 2024-01-04 14:22:20
---


## 教程文档

跟着 react router 教学文档操作

[React Router Tutorial](https://reactrouter.com/en/main/start/tutorial)

## react-router-dom

react-router 相关需安装 `react-router-dom`，

### browserRouter

从 `react-router-dom` 具名导入 `createBrowserRouter` 方法，以及 `RouterProvider` 组件。

调用 `createBrowserRouter` 方法传入 **路由配置项数组** 获取 browserRouter 作为 `<RouterProvide />` `router` 属性参数。

#### root route

根路由担当渲染根组件布局的作用。后续会嵌套路由渲染。

创建 `routes/root.jsx` 根布局组件。将组件放入 routes 配置中，对应 path 为 “/” 的元素的 `element` 属性

#### handle not found errors

创建 `error-page.jsx` 文件。

从 `react-router-dom` 中引入 `useRouteError` hook，可以从 useRouteError 返回的 Error 对象中获取 `errorStatusText` 和 `errorMessage`。

##### errorElement 属性

本来以为这种路由错误捕获，是在最有一个路由匹配，展示错误页面。

这里使用的是将错误页组件添加为根路由配置项中的 `errorElement` 属性。

#### 嵌套路由

##### children 属性

嵌套路由可以放到根路由的 children 属性配置项中。

##### Outlet 插槽渲染组件

在需要展示嵌套路由的位置使用 `<Outlet/>` 组件占位。子路由会渲染到里面

#### 客户端路由

客户端路由跳转，而不是整个页面文档刷新。使用 `Link` 组件代替 `a` 标签，`to` 属性代替 `href` 属性。

#### 获取数据

由于URL段、布局、数据的天然耦合，提供了简单的约定式获取数据的方法

<!-- 实话说嗷，没太懂为啥要这么去获取数据，不能直接在组件中获取么 -->

主要用到两个API:`loader` 、`useLoaderData`

#### 表单事件

原生 html form 标签会触发页面变动。需使用 react-router-dom 中的 `Form` 组件代替 form 标签。

并且在路由配置中，使用 `action` 接收 `Form` `submit` 事件

<!-- 这么看还是有点奇怪了。确实基本没这么写过。确切说是基本没怎么写过 onSubmit -->

<!-- 哇！这个 action 和 loader 是联动了么，表单 submit 操作之后，useLoaderData 返回的数据也更新了，好高级的感觉 -->

submit 触发的 action ，可以从 action 函数 `props.request.formData` 获取提交的表单数据。使用 `Object.fromEntries()` 方法将 formData 转换成普通对象的表单值使用

#### URL params

路由配置上使用 `:` 后配置的 url 动态参数，也会作为 `params` 属性一起传递给 `loader` 。

#### NavLink

`NavLink`  ，通过 className 传入回调函数，从回调函数的参数中可以获取到当前 NavLink 是否活动中 `isActive` , 或者是否选中后正在获取数据，执行 loader，状态为 `isPending`

#### 全局 Pending 状态

使用 `useNavigation` hook，获取到 `navigate.state` ，如果为 `loading`，就说明是 `pending` 状态

#### Destroy Route

<!-- 这个看着是有点奇怪啊 -->

看实现方式是给 `Form.action` 属性 `'destroy'` ，二次确认通过后自动跳转到 `/destroy` 的相对路径，直接触发删除页面的 `loader` 执行删除操作，成功之后自动重定向到根路由 `/`

#### index route

在根路由或者父级路由，没有匹配子路由时，如有需要展示内容，可以使用 `{ index: true, element: <YourIndexComponent />}` 来渲染 index 默认内容。

<!-- 看这个示例，感觉 ChatGPT 的列表和首页应该就是这种实现 -->

#### 路由回退

使用 `useNavigate` hook，返回的 `navigate` 操作方法，参数传入 `-1` 就是回退。

<!-- 我还想着要是直接复制到这个，编辑页面，取消直接回退到上一个页面的时候会咋样，是路由没法变化么。看是直接浏览器回到初始页了 -->
