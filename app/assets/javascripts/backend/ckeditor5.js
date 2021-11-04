function Ckeditor5Helper() {
	var ckeditorHtmlObject = null;

	function init(ckeObj) {
		ckeditorHtmlObject = ckeObj;
		initCkeditorField();
		setupHeight();
	}

	function initCkeditorField() {
		var ckeVariant = ckeditorHtmlObject.attr('data-ckeditor5');
		var isReadOnly = ckeditorHtmlObject.attr('disabled');

		ckeVariant = ckeVariant.trim();
		ckeVariant = ckeVariant.toLowerCase();
		var config = null;
		if (ckeVariant == 'mini') {
			config = miniToolbar();
		} else if (ckeVariant == 'medium') {
			config = mediumToolbar();
		} else if (ckeVariant == 'full') {
			config = fullToolbar();
		} else {
			config = mediumToolbar();
		}

		ClassicEditor.create(ckeditorHtmlObject[0], config)
			.then(editor => {
				if (isReadOnly) {
					editor.isReadOnly = true;
				}
			})
			.catch(error => {
				console.error('There was a problem initializing the editor.', error);
			});
	}

	function setupHeight() {
		var ckeHeight = ckeditorHtmlObject.attr('data-height');
		if (ckeHeight) {
			var name = ckeditorHtmlObject.attr('name');
			var rule = '';
			rule += 'textarea[name="' + name + '"] + div .ck-editor__editable { min-height: ' + ckeHeight + 'px }';
			rule += ' textarea[name="' + name + '"] + div .ck-source-editing-area { min-height: ' + ckeHeight + 'px }';

			$('<style>').text(rule).appendTo(document.head)
		}
	}

	// ################################################################
	// ############################ MINI ##############################
	function miniToolbar() {
		return {
			toolbar: {
				items: [
					'undo',
					'redo',
					'|',
					'alignment',
					'|',
					'bold',
					'italic',
					'underline',
					'|',
					'outdent',
					'indent',
					'link',
					'mediaEmbed',
					'specialCharacters',
					'sourceEditing'
				],
				shouldNotGroupWhenFull: true
			},
			image: {
				toolbar: [
					'imageStyle:inline',
					'imageStyle:block',
					'imageStyle:side',
					'|',
					'toggleImageCaption',
					'imageTextAlternative',
					'imageResize'
				]
			},
			fontSize: {
				options: [
					9,
					11,
					13,
					'default',
					17,
					19,
					21

				]
			},
			table: {
				contentToolbar: [
					'tableColumn',
					'tableRow',
					'mergeTableCells'
				]
			},
		}
	}

	// ################################################################
	// ########################### MEDIUM #############################
	function mediumToolbar() {
		return {
			toolbar: {
				items: [
					'undo',
					'redo',
					'|',
					'mokioFileBrowser',
					'|',
					'heading',
					'|',
					'alignment',
					'|',
					'bold',
					'italic',
					'underline',
					'|',
					'bulletedList',
					'numberedList',
					'|',
					'outdent',
					'indent',
					'|',
					'insertTable',
					'link',
					'mediaEmbed',
					'specialCharacters',
					'sourceEditing'
				],
				shouldNotGroupWhenFull: true
			},
			image: {
				toolbar: [
					'imageStyle:inline',
					'imageStyle:block',
					'imageStyle:side',
					'|',
					'toggleImageCaption',
					'imageTextAlternative',
					'imageResize'
				]
			},
			fontSize: {
				options: [
					9,
					11,
					13,
					'default',
					17,
					19,
					21
				]
			},
			table: {
				contentToolbar: [
					'tableColumn',
					'tableRow',
					'mergeTableCells'
				]
			},
		}
	}

	// ################################################################
	// ############################ FULL ##############################
	function fullToolbar() {
		return {
			toolbar: {
				items: [
					'undo',
					'redo',
					'|',
					'mokioFileBrowser',
					'|',
					'heading',
					'|',
					'alignment',
					'|',
					'bold',
					'italic',
					'underline',
					'|',
					'fontColor',
					'fontFamily',
					'fontSize',
					'fontBackgroundColor',
					'-',
					'bulletedList',
					'numberedList',
					'|',
					'outdent',
					'indent',
					'|',
					'blockQuote',
					'horizontalLine',
					'insertTable',
					'link',
					'mediaEmbed',
					'specialCharacters',
					'sourceEditing'
				],
				shouldNotGroupWhenFull: true
			},
			image: {
				toolbar: [
					'imageStyle:inline',
					'imageStyle:block',
					'imageStyle:side',
					'|',
					'toggleImageCaption',
					'imageTextAlternative',
					'imageResize'
				]
			},
			fontSize: {
				options: [
					9,
					11,
					13,
					'default',
					17,
					19,
					21
				]
			},
			table: {
				contentToolbar: [
					'tableColumn',
					'tableRow',
					'mergeTableCells'
				]
			},
		}
	}

	return {
		init: init
	}
}

$(document).ready(function () {
	var ckeditorTextareas = $('textarea[data-ckeditor5]');
	ckeditorTextareas.each(function () {
		var ckeHelper = new Ckeditor5Helper();
		ckeHelper.init($(this));
	});
});
