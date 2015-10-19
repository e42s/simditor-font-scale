(function() {
  describe('Simditor Font Scale', function() {
    var $textarea, btn, editor;
    editor = null;
    $textarea = null;
    btn = null;
    afterEach(function() {
      if (editor != null) {
        editor.destroy();
      }
      editor = null;
      $textarea.remove();
      $textarea = null;
      return btn = null;
    });
    return describe('features', function() {
      beforeEach(function() {
        $textarea = $('<textarea id="editor"></textarea>').appendTo('body');
        editor = new Simditor({
          textarea: $textarea,
          toolbar: ['fontScale', 'bold']
        });
        return btn = $('.simditor-toolbar .toolbar-item-fontScale');
      });
      return it('should render small button', function() {
        return expect(btn).toExist();
      });
    });
  });

}).call(this);
