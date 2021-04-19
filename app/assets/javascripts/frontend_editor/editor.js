function MokioFrontendEditor() {
  this.init = function () {
    this.addStylesToEditableSections();
    this.setupOnKeyDownEvent();
  }

  this.setupOnKeyDownEvent = function () {
    var _this = this;
    $('*[data-editableblock]').keydown(function (e) {
      _this.changeTagWhenRootIsEmpty(e);
      _this.processOnEnter(e);
    });
    $('*[data-editableblock]').keyup(function (e) {
      _this.setEditorPosition($(this));
      _this.setUnsavedBorder($(this));
    });
    $('*[data-editableblock]').bind("paste", function (e) {
      var text = e.originalEvent.clipboardData.getData('text');
      const selection = window.getSelection();
      if (!selection.rangeCount) return false;
      selection.deleteFromDocument();
      var clearedText = _this.clearHtml(text);
      selection.getRangeAt(0).insertNode(document.createTextNode(clearedText));
      e.preventDefault();
    });
  }

  this.processOnEnter = function (ev) {
    if (ev.keyCode == 13 && !ev.shiftKey) {
      var selection = window.getSelection();
      var container = $(selection.anchorNode).closest(".mokio-editor-editableblock");
      var editorTag = container.prop("tagName").toUpperCase();
      switch (editorTag) {
        case "H1":
        case "H2":
        case "H3":
        case "H4":
        case "H5":
        case "H6":
        case "SPAN":
        case "LI":
        case "P":
        case "DIV":
          ev.preventDefault();
          ev.stopPropagation();
          break;
      }

      if (editorTag == "DIV") {
        document.execCommand('insertParagraph', false);
      }
    }
  }

  this.changeTagWhenRootIsEmpty = function (ev) {
    if (ev.keyCode != 13) {
      var selection = window.getSelection();
      var container = $(selection.anchorNode).closest(".mokio-editor-editableblock");
      var containerCharsSize = container.html().length;
      var editorTag = container.prop("tagName").toUpperCase();
      if (editorTag == "DIV" && containerCharsSize == 0) {
        ev.preventDefault();
        ev.stopPropagation();
        document.execCommand('formatblock', false, 'p');
      } else if (editorTag == "UL" && containerCharsSize == 0) {
        ev.preventDefault();
        ev.stopPropagation();
        container.html("<li>" + String.fromCharCode(ev.which) + "</li>");
      }
    }
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
        background-color: #e0d5d5;
        border: 1px solid #716d6d;
      }
      *[data-editableblock] {
        min-height:20px;
      }
      .mfe-default {
        border: 1px dashed #afadad;
      }
      .mfe-unsaved {
        border: 1px dashed #ff9234;
      }
      img.toolbar-action { border: 0;  cursor: pointer; }
      img.toolbar-action:hover { border: 1px solid black; }
    `;
    $('<style>').text(editorStyles).appendTo(document.head);
    const toolbarHtml = `
      <div id="editableblock-toolbar">
        <img class="toolbar-action" title="Cofnij" data-action="undo" src="data:image/gif;base64,R0lGODlhFgAWAOMKADljwliE33mOrpGjuYKl8aezxqPD+7/I19DV3NHa7P///////////////////////yH5BAEKAA8ALAAAAAAWABYAAARR8MlJq7046807TkaYeJJBnES4EeUJvIGapWYAC0CsocQ7SDlWJkAkCA6ToMYWIARGQF3mRQVIEjkkSVLIbSfEwhdRIH4fh/DZMICe3/C4nBQBADs=" />
        <img class="toolbar-action" title="Ponów" data-action="redo" src="data:image/gif;base64,R0lGODlhFgAWAMIHAB1ChDljwl9vj1iE34Kl8aPD+7/I1////yH5BAEKAAcALAAAAAAWABYAAANKeLrc/jDKSesyphi7SiEgsVXZEATDICqBVJjpqWZt9NaEDNbQK1wCQsxlYnxMAImhyDoFAElJasRRvAZVRqqQXUy7Cgx4TC6bswkAOw==" />
        <img class="toolbar-action" title="Usuń formatowanie" data-action="removeFormat" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABYAAAAWCAYAAADEtGw7AAAABGdBTUEAALGPC/xhBQAAAAZiS0dEAP8A/wD/oL2nkwAAAAlwSFlzAAAOxAAADsQBlSsOGwAAAAd0SU1FB9oECQMCKPI8CIIAAAAIdEVYdENvbW1lbnQA9syWvwAAAuhJREFUOMtjYBgFxAB501ZWBvVaL2nHnlmk6mXCJbF69zU+Hz/9fB5O1lx+bg45qhl8/fYr5it3XrP/YWTUvvvk3VeqGXz70TvbJy8+Wv39+2/Hz19/mGwjZzuTYjALuoBv9jImaXHeyD3H7kU8fPj2ICML8z92dlbtMzdeiG3fco7J08foH1kurkm3E9iw54YvKwuTuom+LPt/BgbWf3//sf37/1/c02cCG1lB8f//f95DZx74MTMzshhoSm6szrQ/a6Ir/Z2RkfEjBxuLYFpDiDi6Af///2ckaHBp7+7wmavP5n76+P2ClrLIYl8H9W36auJCbCxM4szMTJac7Kza////R3H1w2cfWAgafPbqs5g7D95++/P1B4+ECK8tAwMDw/1H7159+/7r7ZcvPz4fOHbzEwMDwx8GBgaGnNatfHZx8zqrJ+4VJBh5CQEGOySEua/v3n7hXmqI8WUGBgYGL3vVG7fuPK3i5GD9/fja7ZsMDAzMG/Ze52mZeSj4yu1XEq/ff7W5dvfVAS1lsXc4Db7z8C3r8p7Qjf///2dnZGxlqJuyr3rPqQd/Hhyu7oSpYWScylDQsd3kzvnH738wMDzj5GBN1VIWW4c3KDon7VOvm7S3paB9u5qsU5/x5KUnlY+eexQbkLNsErK61+++VnAJcfkyMTIwffj0QwZbJDKjcETs1Y8evyd48toz8y/ffzv//vPP4veffxpX77z6l5JewHPu8MqTDAwMDLzyrjb/mZm0JcT5Lj+89+Ybm6zz95oMh7s4XbygN3Sluq4Mj5K8iKMgP4f0////fv77//8nLy+7MCcXmyYDAwODS9jM9tcvPypd35pne3ljdjvj26+H2dhYpuENikgfvQeXNmSl3tqepxXsqhXPyc666s+fv1fMdKR3TK72zpix8nTc7bdfhfkEeVbC9KhbK/9iYWHiErbu6MWbY/7//8/4//9/pgOnH6jGVazvFDRtq2VgiBIZrUTIBgCk+ivHvuEKwAAAAABJRU5ErkJggg==">
        <img class="toolbar-action" title="Bold" data-action="bold" src="data:image/gif;base64,R0lGODlhFgAWAID/AMDAwAAAACH5BAEAAAAALAAAAAAWABYAQAInhI+pa+H9mJy0LhdgtrxzDG5WGFVk6aXqyk6Y9kXvKKNuLbb6zgMFADs=" />
        <img class="toolbar-action" title="Italic" data-action="italic" src="data:image/gif;base64,R0lGODlhFgAWAKEDAAAAAF9vj5WIbf///yH5BAEAAAMALAAAAAAWABYAAAIjnI+py+0Po5x0gXvruEKHrF2BB1YiCWgbMFIYpsbyTNd2UwAAOw==" />
        <img class="toolbar-action" title="Underline" data-action="underline" src="data:image/gif;base64,R0lGODlhFgAWAKECAAAAAF9vj////////yH5BAEAAAIALAAAAAAWABYAAAIrlI+py+0Po5zUgAsEzvEeL4Ea15EiJJ5PSqJmuwKBEKgxVuXWtun+DwxCCgA7" />
      </div>
    `;

    $(toolbarHtml).appendTo(document.body);

    $("#editableblock-toolbar .toolbar-action").click(function (e) {
      var action = $(this).attr('data-action');
      document.execCommand(action, false);
    });

    $("*[data-editableblock]").each(function () {
      var editorElement = $(this);
      editorElement.focus(function () {
        _this.setEditorPosition(editorElement);
      });
      editorElement.focusout(function () {
        _this.save(editorElement);
      });
      _this.setDefaultBorder(editorElement);
    });

    $(document).click(function (e) {
      var toolbar = $("#editableblock-toolbar");
      var notEditor = !$(e.target).closest(".mokio-editor-editableblock").length;
      // var notEditor = !$(e.target).closest("*[data-editableblock]").length;
      var notToolbar = !$(e.target).closest("#editableblock-toolbar").length;
      if (notEditor && notToolbar) {
        toolbar.hide();
      }
    });
  }

  this.save = function (editorElement) {
    var _this = this;
    var html = editorElement[0].outerHTML;
    var hashId = editorElement.attr('data-editableblock');
    var locale = $("#mokio-frontend-editor").attr("data-locale");
    var location = $("#mokio-frontend-editor").attr("data-location");
    // clean up HTML before save
    html = html.replace("mfe-default", "");
    html = html.replace("mfe-unsaved", "");
    html = html.replace(" mokio-editor-editableblock", "");
    html = html.replace("mokio-editor-editableblock", "");
    html = html.replace('class=" "', "");
    html = html.replace('class=""', "");
    html = html.replace('data-editableblock="' + hashId + '"', "");
    html = html.replace('contenteditable="true"', "");
    html = html.replace('   ', " ");
    html = html.replace('  ', " ");

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

  this.setEditorPosition = function (editorElement) {
    var toolbar = $("#editableblock-toolbar");
    var offset = editorElement.offset();
    var screenY = offset.top + window.screenX - 83;
    var screenX = offset.left + window.screenY;
    toolbar.css({ top: screenY, left: screenX });
    toolbar.show();
  }

  this.setDefaultBorder = function (editor) {
    editor.removeClass("mfe-unsaved").addClass("mfe-default");
  }

  this.setUnsavedBorder = function (editor) {
    editor.removeClass("mfe-default").addClass("mfe-unsaved");
  }

  this.clearHtml = function (str) {
    str = str.replace(/<o:p>\s*<\/o:p>/g, "");
    str = str.replace(/<o:p>.*?<\/o:p>/g, "&nbsp;");
    str = str.replace(/\s*mso-[^:]+:[^;"]+;?/gi, "");
    str = str.replace(/\s*MARGIN: 0cm 0cm 0pt\s*;/gi, "");
    str = str.replace(/\s*MARGIN: 0cm 0cm 0pt\s*"/gi, "\"");
    str = str.replace(/\s*TEXT-INDENT: 0cm\s*;/gi, "");
    str = str.replace(/\s*TEXT-INDENT: 0cm\s*"/gi, "\"");
    str = str.replace(/\s*TEXT-ALIGN: [^\s;]+;?"/gi, "\"");
    str = str.replace(/\s*PAGE-BREAK-BEFORE: [^\s;]+;?"/gi, "\"");
    str = str.replace(/\s*FONT-VARIANT: [^\s;]+;?"/gi, "\"");
    str = str.replace(/\s*tab-stops:[^;"]*;?/gi, "");
    str = str.replace(/\s*tab-stops:[^"]*/gi, "");
    str = str.replace(/\s*face="[^"]*"/gi, "");
    str = str.replace(/\s*face=[^ >]*/gi, "");
    str = str.replace(/\s*FONT-FAMILY:[^;"]*;?/gi, "");
    str = str.replace(/<(\w[^>]*) class=([^ |>]*)([^>]*)/gi, "<$1$3");
    str = str.replace(/<(\w[^>]*) style="([^\"]*)"([^>]*)/gi, "<$1$3");
    str = str.replace(/\s*style="\s*"/gi, '');
    str = str.replace(/<SPAN\s*[^>]*>\s*&nbsp;\s*<\/SPAN>/gi, '&nbsp;');
    str = str.replace(/<SPAN\s*[^>]*><\/SPAN>/gi, '');
    str = str.replace(/<(\w[^>]*) lang=([^ |>]*)([^>]*)/gi, "<$1$3");
    str = str.replace(/<SPAN\s*>(.*?)<\/SPAN>/gi, '$1');
    str = str.replace(/<FONT\s*>(.*?)<\/FONT>/gi, '$1');
    str = str.replace(/<\\?\?xml[^>]*>/gi, "");
    str = str.replace(/<\/?\w+:[^>]*>/gi, "");
    str = str.replace(/<H\d>\s*<\/H\d>/gi, '');
    str = str.replace(/<H1([^>]*)>/gi, '');
    str = str.replace(/<H2([^>]*)>/gi, '');
    str = str.replace(/<H3([^>]*)>/gi, '');
    str = str.replace(/<H4([^>]*)>/gi, '');
    str = str.replace(/<H5([^>]*)>/gi, '');
    str = str.replace(/<H6([^>]*)>/gi, '');
    str = str.replace(/<\/H\d>/gi, '<br>'); //remove this to take out breaks where Heading tags were
    str = str.replace(/<(U|I|STRIKE)>&nbsp;<\/\1>/g, '&nbsp;');
    str = str.replace(/<(B|b)>&nbsp;<\/\b|B>/g, '');
    str = str.replace(/<([^\s>]+)[^>]*>\s*<\/\1>/g, '');
    str = str.replace(/<([^\s>]+)[^>]*>\s*<\/\1>/g, '');
    str = str.replace(/<([^\s>]+)[^>]*>\s*<\/\1>/g, '');
    //some RegEx code for the picky browsers
    var re = new RegExp("(<P)([^>]*>.*?)(<\/P>)", "gi");
    str = str.replace(re, "<div$2</div>");
    var re2 = new RegExp("(<font|<FONT)([^*>]*>.*?)(<\/FONT>|<\/font>)", "gi");
    str = str.replace(re2, "<div$2</div>");
    str = str.replace(/size|SIZE = ([\d]{1})/g, '');
    return str;
  }
}

$(document).ready(function () {
  var mokioEditor = new MokioFrontendEditor();
  mokioEditor.init();
});
