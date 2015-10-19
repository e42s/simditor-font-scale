class FontScaleButton extends Simditor.Button
  @i18n =
    'zh-CN':
      fontScale: '字体大小'
    'en-US':
      fontScale: 'Font Size'

  name: 'fontScale'

  icon: 'font'

  disableTag: 'pre'

  htmlTag: 'span'

  _init: ->
    @menu = [{
      name: '100%'
      text: '100%'
      param: '1'
    }, '|', {
      name: '150%'
      text: '150%'
      param: '1.5'
    }, {
      name: '125%'
      text: '125%'
      param: '1.25'
    }, {
      name: '75%'
      text: '75%'
      param: '.75'
    }, {
      name: '50%'
      text: '50%'
      param: '.5'
    }]
    $.merge @editor.formatter._allowedTags, ['span']
    $.merge @editor.formatter._allowedStyles['span'], ['font-size']
    @editor.formatter._allowedAttributes['span'] ||= []
    $.merge @editor.formatter._allowedAttributes['span'], ['data-font-scale']
    super()

  setActive: (active, param) ->
    super active

    param = param*100 if active
    @el.removeClass 'active-150 active-125 active-75 active-50'
    @el.addClass('active active-' + param) if active

  _activeStatus: ->
    range = @editor.selection.range()
    $scale = $(range.startContainer).parents('span[data-font-scale]')
    active = $scale.length > 0
    ratio = 1
    ratio = parseFloat $scale[0].style.fontSize if active

    @setActive(active, ratio)
    @active

  command: (param)->
    range = @editor.selection.range()
    return if range.collapsed

    @editor.selection.save()
    accept = false
    treeWalker = document.createTreeWalker(
      range.commonAncestorContainer,
      -1, # using -1 insted of NodeFilter.SHOW_All for safari
      {
        acceptNode: (node) ->
          $node = $(node)

          if $node.is('.simditor-caret-start')
            accept = true
            return NodeFilter.FILTER_REJECT
          else if $node.is('.simditor-caret-end')
            accept = false
            return NodeFilter.FILTER_REJECT
          else if accept and node.nodeType is 3 and /\S/.test(node.nodeValue)
            return NodeFilter.FILTER_ACCEPT
          else
            return NodeFilter.FILTER_SKIP
      },
      false
    );

    nodeList = [];
    while treeWalker.nextNode()
      nodeList.push(treeWalker.currentNode)

    for node in nodeList
      $node = $(node)
      $scale = $node.parents('span[data-font-scale]')
      if $scale.length > 0
        @split($scale)
        $node.parents('span[data-font-scale]').replaceWith $node

      if param*1 isnt 1
        $node.wrap("<span data-font-scale style='font-size:#{param}em' />")

    @editor.selection.restore()
    @editor.trigger 'valuechanged'
    $(document).trigger 'selectionchange'

  split: ($node) ->
    wrapper = $('<div/>').append($node.clone(false).empty()).html()

    $node.contents().each ->
      $n = $ @

      if @nodeType is 3
        if /\S/.test(@nodeValue)
          $n.wrap(wrapper)
        else
          $n.remove()
      else if @nodeType is 1 and $n.find('span.simditor-caret-start, span.simditor-caret-end').length > 0
        split($n)

    $node.replaceWith $node.contents()


Simditor.Toolbar.addButton FontScaleButton
