(function (root, factory) {
  if (typeof define === 'function' && define.amd) {
    // AMD. Register as an anonymous module unless amdModuleId is set
    define('simditor-small', ["jquery","simditor"], function (a0,b1) {
      return (root['SmallButton'] = factory(a0,b1));
    });
  } else if (typeof exports === 'object') {
    // Node. Does not work with strict CommonJS, but
    // only CommonJS-like environments that support module.exports,
    // like Node.
    module.exports = factory(require("jquery"),require("Simditor"));
  } else {
    root['SimditorSmall'] = factory(jQuery,Simditor);
  }
}(this, function ($, Simditor) {

var SmallButton,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

SmallButton = (function(_super) {
  __extends(SmallButton, _super);

  function SmallButton() {
    return SmallButton.__super__.constructor.apply(this, arguments);
  }

  SmallButton.prototype.name = 'small';

  SmallButton.prototype.icon = 'font-minus';

  SmallButton.prototype.disableTag = 'pre';

  SmallButton.prototype.htmlTag = 'small';

  SmallButton.prototype._init = function() {
    SmallButton.__super__._init.call(this);
    return $.merge(this.editor.formatter._allowedTags, ['small']);
  };

  SmallButton.prototype.status = function($node) {
    var range;
    if ($node != null) {
      this.setDisabled($node.is(this.disableTag));
    }
    if (this.disabled) {
      return true;
    }
    range = this.editor.selection.getRange();
    this.setActive($(range.startContainer).parents('small').length > 0);
    return this.active;
  };

  SmallButton.prototype.command = function() {
    var $node, $small, accept, firstSmall, node, nodeList, range, recoverNormal, split, treeWalker, _i, _j, _len, _len1;
    range = this.editor.selection.getRange();
    if (range.collapsed) {
      return;
    }
    firstSmall = $(range.cloneContents()).contents().first();
    if (!firstSmall.is('small')) {
      firstSmall = firstSmall.find('small:first');
    }
    recoverNormal = this.active || (firstSmall.length > 0 && !firstSmall[0].previousSibling);
    this.editor.selection.save();
    accept = false;
    if (recoverNormal) {
      treeWalker = document.createTreeWalker(range.commonAncestorContainer, NodeFilter.SHOW_ALL, {
        acceptNode: function(node) {
          var $node;
          $node = $(node);
          if ($node.is('span.simditor-caret-start')) {
            accept = true;
            return NodeFilter.FILTER_REJECT;
          } else if ($node.is('span.simditor-caret-end')) {
            accept = false;
            return NodeFilter.FILTER_REJECT;
          } else if (accept && $node.parents('small').length > 0) {
            return NodeFilter.FILTER_ACCEPT;
          } else {
            return NodeFilter.FILTER_SKIP;
          }
        }
      }, false);
      nodeList = [];
      while (treeWalker.nextNode()) {
        nodeList.push(treeWalker.currentNode);
      }
      split = function($node) {
        var tag;
        tag = $node[0].nodeName.toLowerCase();
        $node.contents().each(function() {
          var $n;
          $n = $(this);
          if (this.nodeType === 3) {
            return $n.wrap("<" + tag + " />");
          } else if (this.nodeType === 1 && $n.find('span.simditor-caret-start, span.simditor-caret-end').length > 0) {
            return split($n);
          }
        });
        return $node.replaceWith($node.contents());
      };
      for (_i = 0, _len = nodeList.length; _i < _len; _i++) {
        node = nodeList[_i];
        $node = $(node);
        $small = $node.parents('small');
        if ($small.length === 0) {
          continue;
        }
        split($small);
        $node.parents('small').replaceWith($node);
      }
    } else {
      treeWalker = document.createTreeWalker(range.commonAncestorContainer, NodeFilter.SHOW_All, {
        acceptNode: function(node) {
          $node = $(node);
          if ($node.is('span.simditor-caret-start')) {
            accept = true;
            return NodeFilter.FILTER_REJECT;
          } else if ($node.is('span.simditor-caret-end')) {
            accept = false;
            return NodeFilter.FILTER_REJECT;
          } else if ($node.parents('small').length > 0) {
            return NodeFilter.FILTER_REJECT;
          } else if (accept && node.nodeType === 3 && /\S/.test(node.nodeValue)) {
            return NodeFilter.FILTER_ACCEPT;
          } else {
            return NodeFilter.FILTER_SKIP;
          }
        }
      }, false);
      nodeList = [];
      while (treeWalker.nextNode()) {
        nodeList.push(treeWalker.currentNode);
      }
      for (_j = 0, _len1 = nodeList.length; _j < _len1; _j++) {
        node = nodeList[_j];
        $(node).wrap('<small/>');
      }
    }
    this.editor.selection.restore();
    this.editor.trigger('valuechanged');
    return $(document).trigger('selectionchange');
  };

  return SmallButton;

})(Simditor.Button);

Simditor.Toolbar.addButton(SmallButton);

return SmallButton;

}));
