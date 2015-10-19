# Simditor Font Scale
[![Circle CI](https://circleci.com/gh/mycolorway/simditor-font-scale.png?style=badge)](https://circleci.com/gh/mycolorway/simditor-font-scale)


[Simditor](http://simditor.tower.im/) 的官方扩展，为工具栏提高按钮，为文本增加字体放大缩小。

###如何使用

在 Simditor 的基础上额外引用 simditor-font-scale 的脚本和样式

```html
<script src="/assets/javascripts/simditor-font-scale.js"></script>
```

配置

```javascript
new Simditor({
	textarea: textareaElement,
	...,
	toolbar: [..., 'fontScale']
})
```
