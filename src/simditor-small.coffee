
class SmallButton extends Simditor.Button
  name: 'small'

  icon: 'font'

  disableTag: 'pre'

  htmlTag: 'small'

  _init: ->
    super()
    $.merge @editor.formatter._allowedTags, ['small']

  status: ($node) ->
    @setDisabled $node.is(@disableTag) if $node?
    return true if @disabled

    range = @editor.selection.getRange()
    @setActive $(range.startContainer).parents(@htmlTag).length > 0
    @active

  command: ->
    range = @editor.selection.getRange()
    @editor.selection.save()
    accept = false

    if @active
      treeWalker = document.createTreeWalker(
        range.commonAncestorContainer,
        NodeFilter.SHOW_ALL,
        {
          acceptNode: (node) ->
            $node = $(node)

            if $node.is('span.simditor-caret-start')
              accept = true
              return NodeFilter.FILTER_REJECT
            else if $node.is('span.simditor-caret-end')
              accept = false
              return NodeFilter.FILTER_REJECT
            else if accept and $node.parents('small').length > 0
              return NodeFilter.FILTER_ACCEPT
            else
              return NodeFilter.FILTER_SKIP
        },
        false
      );

      nodeList = [];
      while treeWalker.nextNode()
        nodeList.push(treeWalker.currentNode)

      split = ($node) ->
        tag = $node[0].nodeName.toLowerCase()

        $node.contents().each ->
          $n = $ @

          if @nodeType is 3
            $n.wrap("<#{tag} />")
          else if @nodeType is 1 and $n.find('span.simditor-caret-start, span.simditor-caret-end').length > 0
            split($n)

        $node.replaceWith $node.contents()

      for node in nodeList
        $node = $(node)
        $small = $node.parents('small')
        continue if $small.length is 0

        split $small
        $node.parents('small').replaceWith $node
    else
      treeWalker = document.createTreeWalker(
        range.commonAncestorContainer,
        NodeFilter.SHOW_All,
        {
          acceptNode: (node) ->
            $node = $(node)

            if $node.is('span.simditor-caret-start')
              accept = true
              return NodeFilter.FILTER_REJECT
            else if $node.is('span.simditor-caret-end')
              accept = false
              return NodeFilter.FILTER_REJECT
            else if $node.parents('small').length > 0
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
        $(node).wrap('<small/>')

    @editor.selection.restore()
    @editor.trigger 'valuechanged'

Simditor.Toolbar.addButton SmallButton