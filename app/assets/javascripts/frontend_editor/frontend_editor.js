/** Trumbowyg v2.27.3 - A lightweight WYSIWYG editor - alex-d.github.io/Trumbowyg/ - License MIT - Author : Alexandre Demode (Alex-D) / alex-d.fr */
jQuery.trumbowyg={langs:{en:{viewHTML:"View HTML",undo:"Undo",redo:"Redo",formatting:"Formatting",p:"Paragraph",blockquote:"Quote",code:"Code",header:"Header",bold:"Bold",italic:"Italic",strikethrough:"Strikethrough",underline:"Underline",strong:"Strong",em:"Emphasis",del:"Deleted",superscript:"Superscript",subscript:"Subscript",unorderedList:"Unordered list",orderedList:"Ordered list",insertImage:"Insert Image",link:"Link",createLink:"Insert link",unlink:"Remove link",_self:"Same tab (default)",_blank:"New tab",justifyLeft:"Align Left",justifyCenter:"Align Center",justifyRight:"Align Right",justifyFull:"Align Justify",horizontalRule:"Insert horizontal rule",removeformat:"Remove format",fullscreen:"Fullscreen",close:"Close",submit:"Confirm",reset:"Cancel",required:"Required",description:"Description",title:"Title",text:"Text",target:"Target",width:"Width"}},plugins:{},svgPath:null,svgAbsoluteUseHref:!1,hideButtonTexts:null},Object.defineProperty(jQuery.trumbowyg,"defaultOptions",{value:{lang:"en",fixedBtnPane:!1,fixedFullWidth:!1,autogrow:!1,autogrowOnEnter:!1,imageWidthModalEdit:!1,hideButtonTexts:null,prefix:"trumbowyg-",tagClasses:{},semantic:!0,semanticKeepAttributes:!1,resetCss:!1,removeformatPasted:!1,tabToIndent:!1,tagsToRemove:[],tagsToKeep:["hr","img","embed","iframe","input"],btns:[["viewHTML"],["undo","redo"],["formatting"],["strong","em","del"],["superscript","subscript"],["link"],["insertImage"],["justifyLeft","justifyCenter","justifyRight","justifyFull"],["unorderedList","orderedList"],["horizontalRule"],["removeformat"],["fullscreen"]],btnsDef:{},changeActiveDropdownIcon:!1,inlineElementsSelector:"a,abbr,acronym,b,caption,cite,code,col,dfn,dir,dt,dd,em,font,hr,i,kbd,li,q,span,strikeout,strong,sub,sup,u",pasteHandlers:[],plugins:{},urlProtocol:!1,minimalLinks:!1,linkTargets:["_self","_blank"],svgPath:null},writable:!1,enumerable:!0,configurable:!1}),function(e,t,n,a){"use strict";var o="tbwconfirm",r="tbwcancel";a.fn.trumbowyg=function(e,t){var n="trumbowyg";if(e===Object(e)||!e)return this.each((function(){a(this).data(n)||a(this).data(n,new i(this,e))}));if(1===this.length)try{var o=a(this).data(n);switch(e){case"execCmd":return o.execCmd(t.cmd,t.param,t.forceCss,t.skipTrumbowyg);case"openModal":return o.openModal(t.title,t.content);case"closeModal":return o.closeModal();case"openModalInsert":return o.openModalInsert(t.title,t.fields,t.callback);case"saveRange":return o.saveRange();case"getRange":return o.range;case"getRangeText":return o.getRangeText();case"restoreRange":return o.restoreRange();case"enable":return o.setDisabled(!1);case"disable":return o.setDisabled(!0);case"toggle":return o.toggle();case"destroy":return o.destroy();case"empty":return o.empty();case"html":return o.html(t)}}catch(e){}return!1};var i=function(o,r){var i=this,s="trumbowyg-icons",l=a.trumbowyg;i.doc=o.ownerDocument||n,i.$ta=a(o),i.$c=a(o),null!=(r=r||{}).lang||null!=l.langs[r.lang]?i.lang=a.extend(!0,{},l.langs.en,l.langs[r.lang]):i.lang=l.langs.en,i.hideButtonTexts=null!=l.hideButtonTexts?l.hideButtonTexts:r.hideButtonTexts;var d=null!=l.svgPath?l.svgPath:r.svgPath;if(i.hasSvg=!1!==d,!1!==d&&(l.svgAbsoluteUseHref||0===a("#"+s,i.doc).length)){if(null==d)a("script[src]").each((function(e,t){var n=t.src,a=n.match("trumbowyg(.min)?.js");null!=a&&(d=n.substring(0,n.indexOf(a[0]))+"ui/icons.svg")}));if(null==d)console.warn("You must define svgPath: https://goo.gl/CfTY9U");else if(!l.svgAbsoluteUseHref){var c=i.doc.createElement("div");c.id=s,i.doc.body.insertBefore(c,i.doc.body.childNodes[0]),a.ajax({async:!0,type:"GET",contentType:"application/x-www-form-urlencoded; charset=UTF-8",dataType:"xml",crossDomain:!0,url:d,data:null,beforeSend:null,complete:null,success:function(e){c.innerHTML=(new XMLSerializer).serializeToString(e.documentElement)}})}}var u=i.doc.querySelector("base")?t.location.href.replace(t.location.hash,""):"";i.svgPath=l.svgAbsoluteUseHref?d:u;var g=i.lang.header,f=function(){return(t.chrome||t.Intl&&Intl.v8BreakIterator)&&"CSS"in t};i.btnsDef={viewHTML:{fn:"toggle",class:"trumbowyg-not-disable"},undo:{isSupported:f,key:"Z"},redo:{isSupported:f,key:"Y"},p:{fn:"formatBlock"},blockquote:{fn:"formatBlock"},h1:{fn:"formatBlock",title:g+" 1"},h2:{fn:"formatBlock",title:g+" 2"},h3:{fn:"formatBlock",title:g+" 3"},h4:{fn:"formatBlock",title:g+" 4"},h5:{fn:"formatBlock",title:g+" 5"},h6:{fn:"formatBlock",title:g+" 6"},subscript:{tag:"sub"},superscript:{tag:"sup"},bold:{key:"B",tag:"b"},italic:{key:"I",tag:"i"},underline:{tag:"u"},strikethrough:{tag:"strike"},strong:{fn:"bold",key:"B"},em:{fn:"italic",key:"I"},del:{fn:"strikethrough"},createLink:{key:"K",tag:"a"},unlink:{},insertImage:{},justifyLeft:{tag:"left",forceCss:!0},justifyCenter:{tag:"center",forceCss:!0},justifyRight:{tag:"right",forceCss:!0},justifyFull:{tag:"justify",forceCss:!0},unorderedList:{fn:"insertUnorderedList",tag:"ul"},orderedList:{fn:"insertOrderedList",tag:"ol"},horizontalRule:{fn:"insertHorizontalRule"},removeformat:{},fullscreen:{class:"trumbowyg-not-disable"},close:{fn:"destroy",class:"trumbowyg-not-disable"},formatting:{dropdown:["p","blockquote","h1","h2","h3","h4"],ico:"p"},link:{dropdown:["createLink","unlink"]}},i.o=a.extend(!0,{},l.defaultOptions,r),i.o.hasOwnProperty("imgDblClickHandler")||(i.o.imgDblClickHandler=i.getDefaultImgDblClickHandler()),i.urlPrefix=i.setupUrlPrefix(),i.disabled=i.o.disabled||"TEXTAREA"===o.nodeName&&o.disabled,r.btns?i.o.btns=r.btns:i.o.semantic||(i.o.btns[3]=["bold","italic","underline","strikethrough"]),a.each(i.o.btnsDef,(function(e,t){i.addBtnDef(e,t)})),i.eventNamespace="trumbowyg-event",i.keys=[],i.tagToButton={},i.tagHandlers=[],i.pasteHandlers=[].concat(i.o.pasteHandlers),i.isIE=-1!==e.userAgent.indexOf("MSIE")||-1!==e.appVersion.indexOf("Trident/"),i.isMac=-1!==e.platform.toUpperCase().indexOf("MAC"),i.init()};i.prototype={DEFAULT_SEMANTIC_MAP:{b:"strong",i:"em",s:"del",strike:"del",div:"p"},init:function(){var e=this;e.height=e.$ta.outerHeight()-39,e.initPlugins();try{e.doc.execCommand("enableObjectResizing",!1,!1),e.doc.execCommand("defaultParagraphSeparator",!1,"p")}catch(e){}e.buildEditor(),e.buildBtnPane(),e.fixedBtnPaneEvents(),e.buildOverlay(),setTimeout((function(){e.disabled&&e.setDisabled(!0),e.$c.trigger("tbwinit")}))},addBtnDef:function(e,t){this.btnsDef[e]=a.extend(t,this.btnsDef[e]||{})},setupUrlPrefix:function(){var e=this.o.urlProtocol;if(e)return"string"!=typeof e?"https://":e.replace("://","")+"://"},buildEditor:function(){var e=this,n=e.o.prefix,o="";e.$box=a("<div/>",{class:n+"box "+n+"editor-visible "+n+e.o.lang+" trumbowyg"}),e.$edBox=a("<div/>",{class:n+"editor-box"}),e.isTextarea=e.$ta.is("textarea"),e.isTextarea?(o=e.$ta.val(),e.$ed=a("<div/>").appendTo(e.$edBox),e.$box.insertAfter(e.$ta).append(e.$edBox,e.$ta)):(e.$ed=e.$ta,o=e.$ed.html(),e.$ta=a("<textarea/>",{name:e.$ta.attr("id"),height:e.height}).val(o),e.$box.insertAfter(e.$ed).append(e.$ta,e.$edBox),e.$edBox.append(e.$ed),e.syncCode()),e.$ta.addClass(n+"textarea").attr("tabindex",-1),e.$ed.addClass(n+"editor").attr({contenteditable:!0,dir:e.lang._dir||"ltr"}).html(o),e.o.tabindex&&e.$ed.attr("tabindex",e.o.tabindex),e.$c.is("[placeholder]")&&e.$ed.attr("placeholder",e.$c.attr("placeholder")),e.$c.is("[spellcheck]")&&e.$ed.attr("spellcheck",e.$c.attr("spellcheck")),e.o.resetCss&&e.$ed.addClass(n+"reset-css"),e.semanticCode(),e.o.autogrowOnEnter&&e.$ed.addClass(n+"autogrow-on-enter");var r,i=!1,s=!1;e.$ed.on("dblclick","img",e.o.imgDblClickHandler).on("keydown",(function(t){var n=t.which;if(8!==n&&13!==n&&46!==n||e.toggleSpan(!0),!t.ctrlKey&&!t.metaKey||t.altKey){if(e.o.tabToIndent&&"Tab"===t.key)try{return t.shiftKey?e.execCmd("outdent",!0,null):e.execCmd("indent",!0,null),!1}catch(e){}}else{i=!0;var a=e.keys[String.fromCharCode(t.which).toUpperCase()];try{return e.execCmd(a.fn,a.param),!1}catch(e){}}})).on("compositionstart compositionupdate",(function(){s=!0})).on("keyup compositionend",(function(t){if("compositionend"===t.type)s=!1;else if(s)return;var n=t.which;if(!(n>=37&&n<=40)){if(8!==n&&13!==n&&46!==n||e.toggleSpan(),!t.ctrlKey&&!t.metaKey||89!==n&&90!==n)if(i||16===n||17===n)void 0===t.which&&e.semanticCode(!1,!1,!0);else{var a=!e.isIE||"compositionend"===t.type;e.semanticCode(!1,a&&13===n),e.$c.trigger("tbwchange")}else e.semanticCode(!1,!0),e.$c.trigger("tbwchange");setTimeout((function(){i=!1}),50)}})).on("input",(function(t){var n=t.originalEvent;"object"==typeof n&&("insertReplacementText"===n.inputType||"insertText"===n.inputType&&null===n.data)&&e.$c.trigger("tbwchange")})).on("mouseup keydown keyup",(function(t){(!t.ctrlKey&&!t.metaKey||t.altKey)&&setTimeout((function(){i=!1}),50),clearTimeout(r),r=setTimeout((function(){e.updateButtonPaneStatus()}),50)})).on("focus blur",(function(t){if("blur"===t.type&&e.clearButtonPaneStatus(),e.$c.trigger("tbw"+t.type),e.o.autogrowOnEnter){if(e.autogrowOnEnterDontClose)return;"focus"===t.type?(e.autogrowOnEnterWasFocused=!0,e.autogrowEditorOnEnter()):e.o.autogrow||(e.$edBox.css({height:e.$edBox.css("min-height")}),e.$c.trigger("tbwresize"))}})).on("keyup focus",(function(){e.$ta.val().match(/<.*>/)||e.$ed.html().match(/<.*>/)||setTimeout((function(){var t=e.isIE?"<p>":"p";e.doc.execCommand("formatBlock",!1,t),e.syncCode()}),0)})).on("cut drop",(function(){setTimeout((function(){e.semanticCode(!1,!0),e.$c.trigger("tbwchange")}),0)})).on("paste",(function(n){if(e.o.removeformatPasted){n.preventDefault(),t.getSelection&&t.getSelection().deleteFromDocument&&t.getSelection().deleteFromDocument();try{var o=t.clipboardData.getData("Text");try{e.doc.selection.createRange().pasteHTML(o)}catch(t){e.doc.getSelection().getRangeAt(0).insertNode(e.doc.createTextNode(o))}e.$c.trigger("tbwchange",n)}catch(t){e.execCmd("insertText",(n.originalEvent||n).clipboardData.getData("text/plain"))}}a.each(e.pasteHandlers,(function(e,t){t(n)})),setTimeout((function(){e.semanticCode(!1,!0),e.$c.trigger("tbwpaste",n),e.$c.trigger("tbwchange")}),0)})),e.$ta.on("keyup",(function(){e.$c.trigger("tbwchange")})).on("paste",(function(){setTimeout((function(){e.$c.trigger("tbwchange")}),0)})),a(e.doc.body).on("keydown."+e.eventNamespace,(function(t){if(27===t.which&&a("."+n+"modal-box").length>=1)return e.closeModal(),!1}))},autogrowEditorOnEnter:function(){var e=this;e.$ed.removeClass("autogrow-on-enter");var t=e.$ed[0].clientHeight;e.$edBox.height("auto");var n=e.$ed[0].scrollHeight;e.$ed.addClass("autogrow-on-enter"),t!==n&&(e.$edBox.height(t),setTimeout((function(){e.$edBox.css({height:n}),e.$c.trigger("tbwresize")}),0))},buildBtnPane:function(){var e=this,t=e.o.prefix,n=e.$btnPane=a("<div/>",{class:t+"button-pane"});a.each(e.o.btns,(function(o,r){Array.isArray(r)||(r=[r]);var i=a("<div/>",{class:t+"button-group "+(r.indexOf("fullscreen")>=0?t+"right":"")});a.each(r,(function(t,n){try{e.isSupportedBtn(n)&&i.append(e.buildBtn(n))}catch(e){}})),i.html().trim().length>0&&n.append(i)})),e.$box.prepend(n)},buildBtn:function(e){var t=this,n=t.o.prefix,o=t.btnsDef[e],r=o.dropdown,i=null==o.hasIcon||o.hasIcon,s=t.lang[e]||e,l=a("<button/>",{type:"button",class:n+e+"-button "+(o.class||"")+(i?"":" "+n+"textual-button"),html:t.hasSvg&&i?'<svg><use xlink:href="'+t.svgPath+"#"+n+(o.ico||e).replace(/([A-Z]+)/g,"-$1").toLowerCase()+'"/></svg>':t.hideButtonTexts?"":o.text||o.title||t.lang[e]||e,title:(o.title||o.text||s)+(o.key?" ("+(t.isMac?"Cmd":"Ctrl")+" + "+o.key+")":""),tabindex:-1,mousedown:function(){return r&&!a("."+e+"-"+n+"dropdown",t.$box).is(":hidden")||a("body",t.doc).trigger("mousedown"),!((t.$btnPane.hasClass(n+"disable")||t.$box.hasClass(n+"disabled"))&&!a(this).hasClass(n+"active")&&!a(this).hasClass(n+"not-disable"))&&(t.execCmd((!r?o.fn:"dropdown")||e,o.param||e,o.forceCss),!1)}});if(r){l.addClass(n+"open-dropdown");var d=n+"dropdown",c={class:d+"-"+e+" "+d+" "+n+"fixed-top "+(o.dropdownClass||"")};c["data-"+d]=e;var u=a("<div/>",c);a.each(r,(function(e,n){t.btnsDef[n]&&t.isSupportedBtn(n)&&u.append(t.buildSubBtn(n))})),t.$box.append(u.hide())}else o.key&&(t.keys[o.key]={fn:o.fn||e,param:o.param||e});return r||(t.tagToButton[(o.tag||e).toLowerCase()]=e),l},buildSubBtn:function(e){var t=this,n=t.o.prefix,o=t.btnsDef[e],r=null==o.hasIcon||o.hasIcon;return o.key&&(t.keys[o.key]={fn:o.fn||e,param:o.param||e}),t.tagToButton[(o.tag||e).toLowerCase()]=e,a("<button/>",{type:"button",class:n+e+"-dropdown-button "+(o.class||"")+(o.ico?" "+n+o.ico+"-button":""),html:t.hasSvg&&r?'<svg><use xlink:href="'+t.svgPath+"#"+n+(o.ico||e).replace(/([A-Z]+)/g,"-$1").toLowerCase()+'"/></svg>'+(o.text||o.title||t.lang[e]||e):o.text||o.title||t.lang[e]||e,title:o.key?"("+(t.isMac?"Cmd":"Ctrl")+" + "+o.key+")":null,style:o.style||null,mousedown:function(){return a("body",t.doc).trigger("mousedown"),t.execCmd(o.fn||e,o.param||e,o.forceCss),!1}})},isSupportedBtn:function(e){try{return this.btnsDef[e].isSupported()}catch(e){}return!0},buildOverlay:function(){var e=this;return e.$overlay=a("<div/>",{class:e.o.prefix+"overlay"}).appendTo(e.$box),e.$overlay},showOverlay:function(){var e=this;a(t).trigger("scroll"),e.$overlay.fadeIn(200),e.$box.addClass(e.o.prefix+"box-blur")},hideOverlay:function(){var e=this;e.$overlay.fadeOut(50),e.$box.removeClass(e.o.prefix+"box-blur")},fixedBtnPaneEvents:function(){var e=this,n=e.o.fixedFullWidth,o=e.$box;e.o.fixedBtnPane&&(e.isFixed=!1,a(t).on("scroll."+e.eventNamespace+" resize."+e.eventNamespace,(function(){if(o){e.syncCode();var r=a(t).scrollTop(),i=o.offset().top+1,s=e.$btnPane,l=s.outerHeight()-2;r-i>0&&r-i-e.height<0?(e.isFixed||(e.isFixed=!0,s.css({position:"fixed",top:0,left:n?0:"auto",zIndex:7}),e.$box.css({paddingTop:s.height()})),s.css({width:n?"100%":o.width()-1}),a("."+e.o.prefix+"fixed-top",o).css({position:n?"fixed":"absolute",top:n?l:l+(r-i),zIndex:15})):e.isFixed&&(e.isFixed=!1,s.removeAttr("style"),e.$box.css({paddingTop:0}),a("."+e.o.prefix+"fixed-top",o).css({position:"absolute",top:l}))}})))},setDisabled:function(e){var t=this,n=t.o.prefix;t.disabled=e,e?t.$ta.attr("disabled",!0):t.$ta.removeAttr("disabled"),t.$box.toggleClass(n+"disabled",e),t.$ed.attr("contenteditable",!e)},destroy:function(){var e=this,n=e.o.prefix;e.isTextarea?e.$box.after(e.$ta.css({height:""}).val(e.html()).removeClass(n+"textarea").show()):e.$box.after(e.$edBox.css({height:""}).removeClass(n+"editor").removeAttr("contenteditable").removeAttr("dir").html(e.html()).show()),e.$ed.off("dblclick","img"),e.destroyPlugins(),e.$box.remove(),e.$c.removeData("trumbowyg"),a("body").removeClass(n+"body-fullscreen"),e.$c.trigger("tbwclose"),a(t).off("scroll."+e.eventNamespace+" resize."+e.eventNamespace),a(e.doc.body).off("keydown."+e.eventNamespace)},empty:function(){this.doc.execCommand("insertHTML",!1,""),this.$ta.val(""),this.syncCode(!0)},toggle:function(){var e=this,t=e.o.prefix;e.o.autogrowOnEnter&&(e.autogrowOnEnterDontClose=!e.$box.hasClass(t+"editor-hidden")),e.semanticCode(!1,!0),e.$c.trigger("tbwchange"),setTimeout((function(){e.doc.activeElement.blur(),e.$box.toggleClass(t+"editor-hidden "+t+"editor-visible"),e.$btnPane.toggleClass(t+"disable"),a("."+t+"viewHTML-button",e.$btnPane).toggleClass(t+"active"),e.$box.hasClass(t+"editor-visible")?e.$ta.attr("tabindex",-1):e.$ta.removeAttr("tabindex"),e.o.autogrowOnEnter&&!e.autogrowOnEnterDontClose&&e.autogrowEditorOnEnter()}),0)},toggleSpan:function(e){this.$ed.find("span").each((function(){!0===e?a(this).attr("data-tbw-flag",!0):a(this).attr("data-tbw-flag")?a(this).removeAttr("data-tbw-flag"):a(this).contents().unwrap()}))},dropdown:function(e){var n=this,o=a("body",n.doc),r=n.o.prefix,i=a("[data-"+r+"dropdown="+e+"]",n.$box),s=a("."+r+e+"-button",n.$btnPane),l=i.is(":hidden");if(o.trigger("mousedown"),l){var d=s.offset().left;s.addClass(r+"active"),i.css({position:"absolute",top:s.offset().top-n.$btnPane.offset().top+s.outerHeight(),left:n.o.fixedFullWidth&&n.isFixed?d:d-n.$btnPane.offset().left}).show(),a(t).trigger("scroll"),o.on("mousedown."+n.eventNamespace,(function(e){i.is(e.target)||(a("."+r+"dropdown",n.$box).hide(),a("."+r+"active",n.$btnPane).removeClass(r+"active"),o.off("mousedown."+n.eventNamespace))}))}},html:function(e){var t=this;return null!=e?(t.$ta.val(e),t.syncCode(!0),t.$c.trigger("tbwchange"),t):t.$ta.val()},syncTextarea:function(){var e=this;e.$ta.val(e.$ed.text().trim().length>0||e.$ed.find(e.o.tagsToKeep.join(",")).length>0?e.$ed.html():"")},syncCode:function(e){var t=this;if(!e&&t.$ed.is(":visible"))t.syncTextarea();else{var n=a("<div>").html(t.$ta.val()),o=a("<div>").append(n);a(t.o.tagsToRemove.join(","),o).remove(),t.$ed.html(o.contents().html())}if(t.o.autogrow&&(t.height=t.$edBox.height(),t.height!==t.$ta.css("height")&&(t.$ta.css({height:t.height}),t.$c.trigger("tbwresize"))),t.o.autogrowOnEnter){t.$edBox.height("auto");var r=t.autogrowOnEnterWasFocused?t.$edBox[0].scrollHeight:t.$edBox.css("min-height");r!==t.$ta.css("height")&&(t.$edBox.css({height:r}),t.$c.trigger("tbwresize"))}},semanticCode:function(e,t,n){var o=this;o.saveRange(),o.syncCode(e);var r=!0;if(o.range&&o.range.collapsed&&(r=!1),o.o.semantic){if(o.semanticTag("b",o.o.semanticKeepAttributes),o.semanticTag("i",o.o.semanticKeepAttributes),o.semanticTag("s",o.o.semanticKeepAttributes),o.semanticTag("strike",o.o.semanticKeepAttributes),t){var i=o.o.inlineElementsSelector,s=":not("+i+")";o.$ed.contents().filter((function(){return 3===this.nodeType&&this.nodeValue.trim().length>0})).wrap("<span data-tbw/>");var l=function(e){if(0!==e.length){var t=e.nextUntil(s).addBack().wrapAll("<p/>").parent(),n=t.nextAll(i).first();t.next("br").remove(),l(n)}};l(o.$ed.children(i).first()),o.semanticTag("div",!0),a("[data-tbw]",o.$ed).contents().unwrap(),o.$ed.find("p:empty").remove()}!n&&r&&o.restoreRange(),o.syncTextarea()}},semanticTag:function(e,t,n){var o,r=this,i=e;if(null!=this.o.semantic&&"object"==typeof this.o.semantic&&this.o.semantic.hasOwnProperty(e))o=this.o.semantic[e];else{if(!0!==this.o.semantic||!this.DEFAULT_SEMANTIC_MAP.hasOwnProperty(e))return;o=this.DEFAULT_SEMANTIC_MAP[e]}n&&(e=o,o=i),a(e,this.$ed).each((function(){var e=!1,n=a(this);if(0===n.contents().length)return!1;r.range&&r.range.startContainer.parentNode===this&&(e=!0);var i=a("<"+o+"/>");i.insertBefore(n),t&&a.each(n.prop("attributes"),(function(){i.attr(this.name,this.value)})),i.html(n.html()),n.remove(),!0===e&&(r.range.selectNodeContents(i.get(0)),r.range.collapse(!1))}))},createLink:function(){for(var e,t,n,o=this,r=o.doc.getSelection(),i=r.getRangeAt(0),s=r.focusNode,l=(new XMLSerializer).serializeToString(i.cloneContents())||i+"",d=o.o.linkTargets[0];["A","DIV"].indexOf(s.nodeName)<0;)s=s.parentNode;if(s&&"A"===s.nodeName){var c=a(s);l=c.text(),e=c.attr("href"),o.o.minimalLinks||(t=c.attr("title"),n=c.attr("target")||d);var u=o.doc.createRange();u.selectNode(s),r.removeAllRanges(),r.addRange(u)}o.saveRange();var g={url:{label:o.lang.linkUrl||"URL",required:!0,value:e},text:{label:o.lang.text,value:l}};if(!o.o.minimalLinks){var f=o.o.linkTargets.reduce((function(e,t){return e[t]=o.lang[t],e}),{});a.extend(g,{title:{label:o.lang.title,value:t},target:{label:o.lang.target,value:n,options:f}})}o.openModalInsert(o.lang.createLink,g,(function(e){var t=o.prependUrlPrefix(e.url);if(!t.length)return!1;var n=a(['<a href="',t,'">',e.text||e.url,"</a>"].join(""));return e.title&&n.attr("title",e.title),(e.target||d)&&n.attr("target",e.target||d),o.range.deleteContents(),o.range.insertNode(n[0]),o.syncCode(),o.$c.trigger("tbwchange"),!0}))},prependUrlPrefix:function(e){if(!this.urlPrefix)return e;if(/^([a-z][-+.a-z0-9]*:|\/|#)/i.test(e))return e;return/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(e)?"mailto:"+e:this.urlPrefix+e},unlink:function(){var e=this,t=e.doc.getSelection(),n=t.focusNode;if(t.isCollapsed){for(;["A","DIV"].indexOf(n.nodeName)<0;)n=n.parentNode;if(n&&"A"===n.nodeName){var a=e.doc.createRange();a.selectNode(n),t.removeAllRanges(),t.addRange(a)}}e.execCmd("unlink",void 0,void 0,!0)},insertImage:function(){var e=this;e.saveRange();var t={url:{label:"URL",required:!0},alt:{label:e.lang.description,value:e.getRangeText()}};e.o.imageWidthModalEdit&&(t.width={}),e.openModalInsert(e.lang.insertImage,t,(function(t){e.execCmd("insertImage",t.url,!1,!0);var n=a('img[src="'+t.url+'"]:not([alt])',e.$box);return n.attr("alt",t.alt),e.o.imageWidthModalEdit&&n.attr({width:t.width}),e.syncCode(),e.$c.trigger("tbwchange"),!0}))},fullscreen:function(){var e,n=this,o=n.o.prefix,r=o+"fullscreen",i=r+"-placeholder",s=n.$box.outerHeight();n.$box.toggleClass(r),(e=n.$box.hasClass(r))?n.$box.before(a("<div/>",{class:i}).css({height:s})):a("."+i).remove(),a("body").toggleClass(o+"body-fullscreen",e),a(t).trigger("scroll"),n.$c.trigger("tbw"+(e?"open":"close")+"fullscreen")},execCmd:function(e,n,o,r){var i=this;r=!!r||"","dropdown"!==e&&i.$ed.focus(),"strikethrough"===e&&i.o.semantic&&i.semanticTag("strike",i.o.semanticKeepAttributes,!0);try{i.doc.execCommand("styleWithCSS",!1,o||!1)}catch(e){}try{i[e+r](n)}catch(o){try{e(n)}catch(o){"insertHorizontalRule"===e?n=void 0:"formatBlock"===e&&i.isIE&&(n="<"+n+">"),i.doc.execCommand(e,!1,n),i.syncCode(),i.semanticCode(!1,!0);try{var s=t.getSelection().focusNode;a(t.getSelection().focusNode.parentNode).hasClass("trumbowyg-editor")||(s=t.getSelection().focusNode.parentNode);var l=i.o.tagClasses[n];l&&a(s).addClass(l)}catch(e){}}"dropdown"!==e&&(i.updateButtonPaneStatus(),i.$c.trigger("tbwchange"))}},openModal:function(e,n,i){var s=this,l=s.o.prefix;if(i=!1!==i,a("."+l+"modal-box",s.$box).length>0)return!1;s.o.autogrowOnEnter&&(s.autogrowOnEnterDontClose=!0),s.saveRange(),s.showOverlay(),s.$btnPane.addClass(l+"disable");var d,c=a("<div/>",{class:l+"modal "+l+"fixed-top"}).css({top:s.$box.offset().top+s.$btnPane.height(),zIndex:99999}).appendTo(a(s.doc.body)),u=l+"dark";0!==s.$c.parents("."+u).length&&c.addClass(u),s.$overlay.one("click",(function(){return c.trigger(r),!1})),d=i?a("<form/>",{action:"",html:n}).on("submit",(function(){return c.trigger(o),!1})).on("reset",(function(){return c.trigger(r),!1})).on("submit reset",(function(){s.o.autogrowOnEnter&&(s.autogrowOnEnterDontClose=!1)})):n;var g=a("<div/>",{class:l+"modal-box",html:d}).css({top:"-"+s.$btnPane.outerHeight(),opacity:0,paddingBottom:i?null:"5%"}).appendTo(c).animate({top:0,opacity:1},100);return e&&a("<span/>",{text:e,class:l+"modal-title"}).prependTo(g),i&&(a(":input:first",g).focus(),s.buildModalBtn("submit",g),s.buildModalBtn("reset",g),c.height(g.outerHeight()+10)),a(t).trigger("scroll"),s.$c.trigger("tbwmodalopen"),c},buildModalBtn:function(e,t){var n=this.o.prefix;return a("<button/>",{class:n+"modal-button "+n+"modal-"+e,type:e,text:this.lang[e]||e}).appendTo(a("form",t))},closeModal:function(){var e=this,t=e.o.prefix;e.$btnPane.removeClass(t+"disable"),e.$overlay.off();var n=a("."+t+"modal-box",a(e.doc.body));n.animate({top:"-"+n.height()},100,(function(){n.parent().remove(),e.hideOverlay(),e.$c.trigger("tbwmodalclose")})),e.restoreRange()},openModalInsert:function(e,t,n){var i=this,s=i.o.prefix,l=i.lang,d="",c=s+"form-"+Date.now()+"-";return a.each(t,(function(e,t){var n=t.label||e,o=t.name||e,r=t.attributes||{},i=c+e,u=Object.keys(r).map((function(e){return e+'="'+r[e]+'"'})).join(" ");if("function"==typeof t.type)return t.name||(t.name=o),void(d+=t.type(t,i,s,l));d+='<div class="'+s+'input-row">',d+='<div class="'+s+'input-infos"><label for="'+i+'"><span>'+(l[n]?l[n]:n)+"</span></label></div>",d+='<div class="'+s+'input-html">',a.isPlainObject(t.options)?(d+='<select name="target">',d+=Object.keys(t.options).map((e=>'<option value="'+e+'" '+(e===t.value?"selected":"")+">"+t.options[e]+"</option>")).join(""),d+="</select>"):(d+='<input id="'+i+'" type="'+(t.type||"text")+'" name="'+o+'" '+u,d+=("checkbox"===t.type&&t.value?' checked="checked"':"")+' value="'+(t.value||"").replace(/"/g,"&quot;")+'">'),d+="</div></div>"})),i.openModal(e,d).on(o,(function(){var e=a("form",a(this)),r=!0,s={};a.each(t,(function(t,n){var o=n.name||t,l=a(':input[name="'+o+'"]',e);switch(l[0].type.toLowerCase()){case"checkbox":s[o]=l.is(":checked");break;case"radio":s[o]=l.filter(":checked").val();break;default:s[o]=a.trim(l.val())}n.required&&""===s[o]?(r=!1,i.addErrorOnModalField(l,i.lang.required)):n.pattern&&!n.pattern.test(s[o])&&(r=!1,i.addErrorOnModalField(l,n.patternError))})),r&&(i.restoreRange(),n(s,t)&&(i.syncCode(),i.$c.trigger("tbwchange"),i.closeModal(),a(this).off(o)))})).one(r,(function(){a(this).off(o),i.closeModal()}))},addErrorOnModalField:function(e,t){var n=this.o.prefix,o=n+"msg-error",r=e.closest("."+n+"input-row");e.on("change keyup",(function(){r.removeClass(n+"input-error"),setTimeout((function(){r.find("."+o).remove()}),150)})),r.addClass(n+"input-error").find("."+n+"input-infos label").append(a("<span/>",{class:o,text:t}))},getDefaultImgDblClickHandler:function(){var e=this;return function(){var t=a(this),n=t.attr("src"),o="(Base64)";0===n.indexOf("data:image")&&(n=o);var r={url:{label:"URL",value:n,required:!0},alt:{label:e.lang.description,value:t.attr("alt")}};return e.o.imageWidthModalEdit&&(r.width={value:t.attr("width")?t.attr("width"):""}),e.openModalInsert(e.lang.insertImage,r,(function(n){return n.url!==o&&t.attr({src:n.url}),t.attr({alt:n.alt}),e.o.imageWidthModalEdit&&(parseInt(n.width)>0?t.attr({width:n.width}):t.removeAttr("width")),!0})),!1}},saveRange:function(){var e=this,t=e.doc.getSelection();if(e.range=null,t&&t.rangeCount){var n,a=e.range=t.getRangeAt(0),o=e.doc.createRange();o.selectNodeContents(e.$ed[0]),o.setEnd(a.startContainer,a.startOffset),n=(o+"").length,e.metaRange={start:n,end:n+(a+"").length}}},restoreRange:function(){var e,t=this,n=t.metaRange,a=t.range,o=t.doc.getSelection();if(a){if(n&&n.start!==n.end){var r,i=0,s=[t.$ed[0]],l=!1,d=!1;for(e=t.doc.createRange();!d&&(r=s.pop());)if(3===r.nodeType){var c=i+r.length;!l&&n.start>=i&&n.start<=c&&(e.setStart(r,n.start-i),l=!0),l&&n.end>=i&&n.end<=c&&(e.setEnd(r,n.end-i),d=!0),i=c}else for(var u=r.childNodes,g=u.length;g>0;)g-=1,s.push(u[g])}try{o.removeAllRanges()}catch(e){}o.addRange(e||a)}},getRangeText:function(){return this.range+""},clearButtonPaneStatus:function(){var e=this,t=e.o.prefix,n=t+"active-button "+t+"active",o=t+"original-icon";a("."+t+"active-button",e.$btnPane).removeClass(n),a("."+o,e.$btnPane).each((function(){a(this).find("svg use").attr("xlink:href",a(this).data(o))}))},updateButtonPaneStatus:function(){var e=this,t=e.o.prefix,n=t+"active-button "+t+"active",o=t+"original-icon",r=e.getTagsRecursive(e.doc.getSelection().anchorNode);e.clearButtonPaneStatus(),a.each(r,(function(r,i){var s=e.tagToButton[i.toLowerCase()],l=a("."+t+s+"-button",e.$btnPane);if(l.length>0)l.addClass(n);else try{var d=(l=a("."+t+"dropdown ."+t+s+"-dropdown-button",e.$box)).find("svg use"),c=l.parent().data(t+"dropdown"),u=a("."+t+c+"-button",e.$box),g=u.find("svg use");u.addClass(n),e.o.changeActiveDropdownIcon&&d.length>0&&(u.addClass(o).data(o,g.attr("xlink:href")),g.attr("xlink:href",d.attr("xlink:href")))}catch(e){}}))},getTagsRecursive:function(e,t){var n=this;if(t=t||(e&&e.tagName?[e.tagName]:[]),!e||!e.parentNode)return t;e.nodeType!==Node.ELEMENT_NODE&&(e=e.parentNode);var o=e.tagName;return"DIV"===o?t:("P"===o&&""!==e.style.textAlign&&t.push(e.style.textAlign),a.each(n.tagHandlers,(function(a,o){t=t.concat(o(e,n))})),t.push(o),n.getTagsRecursive(e.parentNode,t).filter((function(e){return null!=e})))},initPlugins:function(){var e=this;e.loadedPlugins=[],a.each(a.trumbowyg.plugins,(function(t,n){n.shouldInit&&!n.shouldInit(e)||(n.init(e),n.tagHandler&&e.tagHandlers.push(n.tagHandler),e.loadedPlugins.push(n))}))},destroyPlugins:function(){var e=this;a.each(this.loadedPlugins,(function(t,n){n.destroy&&n.destroy(e)}))}}}(navigator,window,document,jQuery);