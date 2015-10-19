describe 'Simditor Font Scale', ->
  editor = null
  $textarea = null
  btn = null

  afterEach ->
    editor?.destroy()
    editor = null
    $textarea.remove()
    $textarea = null
    btn = null

  describe 'features', ->
    beforeEach ->
      $textarea = $('<textarea id="editor"></textarea>').appendTo 'body'
      editor = new Simditor
        textarea: $textarea
        toolbar: ['fontScale', 'bold']

      btn = $('.simditor-toolbar .toolbar-item-fontScale')

    it 'should render small button', ->
      expect(btn).toExist()
