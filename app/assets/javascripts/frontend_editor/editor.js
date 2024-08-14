function MokioFrontendEditor() {
  var blockSave = false;
  var editorPopupBlockExists = false;
  var editorPopupOverlay = null;
  var openedPopupId = null;

  this.init = function () {

    $('body').append('<div id="popups_container"></div>');
    
    $('.mokio-editor-popup').each(function() {
      $(this).prependTo('#popups_container');
    });

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
      var dEditorpopup = $(this).attr("data-editor-popup");
      var isPopup = false;

      if(dEditorpopup === 'true') {
          editorPopupBlockExists = true;
          isPopup = true;
      }

      var contentIsChange = false;

      var e = editorObj.trumbowyg({
        svgPath: mFrontendEditorIconPath,
        btns: dEditormode == 'tiny' ? tinyButtons : standardButtons,
      })
        .on('tbwfocus', function () {
          contentIsChange = false;
          _this.trumboPaneShow(editorObj, true);
      
        })
        .on('tbwblur', function () {
          _this.trumboPaneHide(editorObj);

          if (contentIsChange) {
            var html = editorObj.trumbowyg('html');
            _this.save(editorObj, html);
          }
        })
        .on('tbwinit', function () {
          if(isPopup === false) {
            _this.trumboPaneHide(editorObj);
          }

          var textArea = editorObj.closest('.trumbowyg-box').find('.trumbowyg-textarea');
          textArea.on("focus", function () {
              _this.trumboPaneShow(editorObj, false);
          })
        })
        .on('tbwchange', function () {
          contentIsChange = true;
          _this.setUnsavedBorder(editorObj);
        })

      _this.setDefaultBorder(editorObj);
    })

    this.initEditorPopup();
  }

  this.trumboPaneShow = function (editorObj, fade = false) {
      if(fade === true) {
          editorObj.closest('.trumbowyg-box').find('.trumbowyg-button-pane').fadeIn();
      }else{
          editorObj.closest('.trumbowyg-box').find('.trumbowyg-button-pane').show();
      }
  }

  this.trumboPaneHide = function (editorObj) {
      if(this.isPopupOpened() === false) {
        editorObj.closest('.trumbowyg-box').find('.trumbowyg-button-pane').hide();
      }
  }

  this.initEditorPopup = function () {
      let _this = this;

      if(editorPopupBlockExists) {
          $('body').append('<div class="mokio-editor-overlay"></div>');
          editorPopupOverlay = $('.mokio-editor-overlay');
          this.addStylesToEditorPopup();
      }


      $('[data-editableblock-section]').each(function() {
          var section_id = $(this).attr('data-editableblock-section');

          $(this).on('click', function(event) {
              event.preventDefault();
              _this.openEditorPopup(this, section_id);
          });
      });

      $('.mokio-editor-overlay').on('click', function(event) {
          event.preventDefault();
          _this.closeEditorPopup( openedPopupId);
      });

      $('.mokio-editor-popup-close-btn').on('click', function(event) {
          event.preventDefault();
          _this.closeEditorPopup( openedPopupId);
      });

 
      
  }

  this.isPopupOpened = function() {
      if(openedPopupId === null) {
          return false;
      }

      return true;
  }

  this.openEditorPopup = function(element, section_id) {
      let popup = $('[data-editableblock-popup="' + section_id +'"]');
      popup.show();
      editorPopupOverlay.show();
      openedPopupId = section_id;
  }

  this.closeEditorPopup = function(section_id) {
      let popup = $('[data-editableblock-popup="' + section_id +'"]');
      popup.hide();
      editorPopupOverlay.hide();
      openedPopupId = null;
  }

  this.addStylesToEditorPopup = function () {
      var _this = this;
      const editorStyles = `
          
          .mokio-editor-overlay {
              position: fixed;
              top: 0;
              left: 0;
              width: 100%;
              height: 100%;
              background-color: rgba(0, 0, 0, 0.5);
              z-index: 99;
              display: none; /* Hidden by default */
          }

          .mokio-editor-popup {
              position: fixed;
              top: 50%;
              left: 50%;
              transform: translate(-50%, -50%);
              background-color: #fff;
              padding: 40px 50px 40px 50px;
              border-radius: 8px;
              box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
              z-index: 100; /* Above the overlay */
              display: none; /* Hidden by default */

              display: flex;
              justify-content: flex-start;
              align-content: center;
              flex-flow: column;

              min-height: 150px;
          }

          .mokio-editor-popup-close-btn {
              position: absolute;
              top: 10px;
              right: 10px;
              background: none;
              border: none;
              font-size: 24px;
              cursor: pointer;
              color: black;
              line-height: 24px;
          }          
          [data-editableblock-section] > :first-child {
              cursor: pointer;
          }

          .mokio-editor-popup .mokio-editor-editableblock * {
             
          }
      `;
      $('<style>').text(editorStyles).appendTo(document.head);
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
        z-index: 200;
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
        outline: none;
      }
      .mfe-unsaved {
        border: 1px dashed #ff9234!important;
      }
      img.toolbar-action {
        border: 0;  cursor: pointer;
        border: 1px solid #f1f1f1;
      }
      .trumbowyg-box {
        border: 1px dashed #AFADAD!important;
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
        $('[data-editableblock-section="'+ hashId +'"]').html(html);
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
