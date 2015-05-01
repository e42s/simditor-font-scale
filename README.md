# Simditor Small
[![Circle CI](https://circleci.com/gh/mycolorway/simditor-small.png?style=badge)](https://circleci.com/gh/mycolorway/simditor-small)


[Simditor](http://simditor.tower.im/) 的官方扩展，为工具栏提高按钮，把文本增加 small 标签。

###如何使用

在 Simditor 的基础上额外引用 simditor-small 的脚本和样式

```html
<script src="/assets/javascripts/simditor-small.js"></script>
```

配置

```javascript
new Simditor({
	textarea: textareaElement,
	...,
	toolbar: [..., 'small']
})
```
