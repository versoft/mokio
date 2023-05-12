function MokioFrontendEditor() {
  var blockSave = false;

  this.init = function () {
    this.addStylesToEditableSections();
    var _this = this;
    var tinyButtons = [['strong', 'em', 'del'], ['link']];
    var standardButtons = [
      ['viewHTML'],
      ['undo', 'redo'], // Only supported in Blink browsers
      ['formatting'],
      ['strong', 'em', 'del'],
      // ['superscript', 'subscript'],
      ['link'],
      // ['insertImage'],
      // ['justifyLeft', 'justifyCenter', 'justifyRight', 'justifyFull'],
      ['unorderedList', 'orderedList'],
      // ['horizontalRule'],
      ['removeformat'],
      // ['fullscreen']
    ];

    $('.mokio-editor-editableblock').each(function (e) {
      var editorObj = $(this);
      var dEditormode = $(this).attr("data-editor-mode");
      var contentIsChange = false;

      var e = editorObj.trumbowyg({
        svgPath: mFrontendEditorIconPath,
        btns: dEditormode == 'tiny' ? tinyButtons : standardButtons,
      })
        .on('tbwfocus', function () {
          contentIsChange = false;
          editorObj.closest('.trumbowyg-box').find('.trumbowyg-button-pane').fadeIn();
        })
        .on('tbwblur', function () {
          editorObj.closest('.trumbowyg-box').find('.trumbowyg-button-pane').hide();
          if (contentIsChange) {
            var html = editorObj.trumbowyg('html');
            _this.save(editorObj, html);
          }
        })
        .on('tbwinit', function () {
          editorObj.closest('.trumbowyg-box').find('.trumbowyg-button-pane').hide();
          var textArea = editorObj.closest('.trumbowyg-box').find('.trumbowyg-textarea');
          textArea.on("focus", function () {
            editorObj.closest('.trumbowyg-box').find('.trumbowyg-button-pane').show();
          })
        })
        .on('tbwchange', function () {
          contentIsChange = true;
          _this.setUnsavedBorder(editorObj);
        })

      _this.setDefaultBorder(editorObj);
    })
  }

  this.addStylesToEditableSections = function () {
    var _this = this;
    const editorStyles = `
      #mokio-frontend-editor {
        border-top-left-radius: 20px;
        border-top-right-radius: 20px;
        overflow: hidden;
        background-color: #de1329;
        position: fixed;
        bottom: 0;
        width: 400px;
        height: 40px;
        left: 50%;
        margin-left:-200px;
      }

      #editableblock-toolbar {
        display: none;
        position: absolute;
        border-color: red;
        z-index:99999;
        border-radius: 5px;
        padding: 2px;
        background-color: #f1f1f1;
        border: 1px solid #716d6d;
      }
      *[data-editableblock] {
        min-height:20px;
      }
      .mfe-default {
        border: 1px dashed #afadad!important;;
        outline: none;
      }
      .mfe-unsaved {
        border: 1px dashed #ff9234!important;
      }
      img.toolbar-action {
        border: 0;  cursor: pointer;
        border: 1px solid #f1f1f1;
      }
      img.toolbar-action:hover { border: 1px solid #dcdcdc; }
    `;
    $('<style>').text(editorStyles).appendTo(document.head);
  }

  this.save = function (editorElement, html) {
    if (blockSave) {
      return;
    }

    var _this = this;
    var hashId = editorElement.attr('data-editableblock');
    var locale = $("#mokio-frontend-editor").attr("data-locale");
    var location = $("#mokio-frontend-editor").attr("data-location");
    var params = {
      "editable_block": {
        "content": html,
        "hash_id": hashId,
        "lang": locale,
        "location": location
      }
    };
    $.ajax({
      type: "POST",
      contentType: "application/json",
      dataType: "json",
      beforeSend: function (request) {
        request.setRequestHeader(
          "X-CSRF-Token",
          document.getElementsByName('csrf-token')[0].content
        );
      },
      url: '/backend/editable_blocks',
      data: JSON.stringify(params),
      success: function (msg) {
        _this.setDefaultBorder(editorElement);
      },
      error: function (msg) {
        console.error("error", msg)
      }
    });
  }

  this.restore = function (editorElement) {
    var _this = this;
    var hashId = editorElement.attr('data-editableblock');
    var locale = $("#mokio-frontend-editor").attr("data-locale");
    var location = $("#mokio-frontend-editor").attr("data-location");
    var params = {
      "editable_block": {
        "hash_id": hashId,
        "lang": locale,
        "location": location
      }
    };
    $.ajax({
      type: "DELETE",
      contentType: "application/json",
      dataType: "json",
      beforeSend: function (request) {
        request.setRequestHeader(
          "X-CSRF-Token",
          document.getElementsByName('csrf-token')[0].content
        );
      },
      url: `/backend/editable_blocks/${hashId}`,
      data: JSON.stringify(params),
      success: function (msg) {
        window.location.reload();
      },
      error: function (msg) {
        console.error("error", msg)
      }
    });
  }

  this.setDefaultBorder = function (editor) {
    editor.removeClass("mfe-unsaved").addClass("mfe-default");
  }

  this.setUnsavedBorder = function (editor) {
    editor.removeClass("mfe-default").addClass("mfe-unsaved");
  }

}

$(document).ready(function () {
  var mokioEditor = new MokioFrontendEditor();
  mokioEditor.init();
});
