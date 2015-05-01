describe 'Simditor Small', ->
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
        toolbar: ['small', 'bold']

      btn = $('.simditor-toolbar .toolbar-item-small')

    it 'should render small button', ->
      expect(btn).toExist()
