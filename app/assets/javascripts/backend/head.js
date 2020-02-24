// ! Important plugins put in all pages
//= require jquery3
// require jquery.turbolinks
//= require backend/jquery-ui.min
//= require jquery_ujs

// Jquery migrate adds methods removed in newest jquery but still used by plugins
//= require backend/head/jquery-migrate-1.2.1

//= require backend/bootstrap/bootstrap
//= require backend/head/jquery.cookie
//= require backend/head/jquery.mousewheel
// !

// Ckeditor
// require ckeditor/override
//= require ckeditor/init
//= require backend/mokio_dynamic_fields

jQuery.fn.load = function(callback){$(window).on("load", callback)};