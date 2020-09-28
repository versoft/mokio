var shouldUpdateSlug = true;
setInitialState();

function setInitialState() {
  keepUpdatingSlug();
}

function slugHooks() {
  keepUpdatingSlug();

  var slugField = document.getElementById("slug");
  slugField.value = parameterizeString(slugField.value);
}

function updateSlug() {
  if (shouldUpdateSlug == true) {
    var title = document.getElementById("title").value;
    var slugField = document.getElementById("slug");

    slugField.value = parameterizeString(title);
  }
}

function keepUpdatingSlug() {
  var title = document.getElementById("title").value;
  var slug = document.getElementById("slug").value;
  var parameterizedTitle = parameterizeString(document.getElementById("title").value);

  if (slug == "") {
    shouldUpdateSlug = true;
    return;
  }
  if (parameterizedTitle != slug) {
    shouldUpdateSlug = false;
  }
}

function parameterizeString(text) {
  var noDiacritics = _.deburr(text);
  return noDiacritics.toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/(^-)/g, '');
}

function removeTracingDashes() {
  var slugField = document.getElementById("slug");
  var titleField = document.getElementById("title");

  slugField.value = slugField.value.replace(/(-$)/g, '');
  titleField.value = titleField.value.replace(/(-$)/g, '');
}

function slugPrefix(prefix) {
  if (prefix) {
    $('#slug').before('<span class="input-group-addon">' + prefix + '</span>');
    var span10 = $('#slug').closest('.span10');
    span10.css('position', 'relative');
    span10.css('display', 'table');
    span10.css('border-collapse', 'separate');
  }
}
