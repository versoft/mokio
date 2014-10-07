var PhotoEditForm = {
  photo_type: "",
  isInitialized: false,

  //
  // coordinates set to 0
  // this prevent cuting photo when nothing is marked while croping image
  // also prevent checking existance of params outside javascript
  //
  crop_x: 0,
  crop_y: 0,
  crop_h: 0,
  crop_w: 0,

  init: function() {
    updateAjaxPhoto();
    PhotoEditForm.isInitialized = true;

    $(".modal-backdrop").animate({opacity: "0.85"}, 1000);

    //
    // style form
    //
    $(".photo_holder").fadeIn(500);

    //
    // create buttons
    //
    $(".editwrapper").append('<span class="photo_exit icon32 icomoon-icon-cancel white"></span>')
                     .append('<span class="photo_crop icon32 icomoon-icon-crop white"></span>')
                     .append('<span class="photo_rotate icon32 icomoon-icon-redo white"></span>');

    $file_upload = document.getElementById('uploadthumb');

    if ( !$file_upload ) {
      $(".photo_exit, .photo_crop, .photo_rotate").hide().each(function(index, el) {
        $(this).delay(400 * index).fadeIn(500);
      });

      if ( PhotoEditForm.photo_type == "thumb" ) {
        $(".editwrapper").append('<span class="thumb_remove icon32 icomoon-icon-remove white"></span>');

        $(".thumb_remove").hide().fadeIn(500);
        $(".thumb_remove").click(function(event) {
          /* Act on the event */
          showLoader();

          $.ajax({
            url: "/" + Mokio.engine_root() + "/"+default_data_file+"/" + Modal.id() + "/remove_thumb",
            type: 'DELETE'
          })
          .done(function(){
            $(".thumb_remove").fadeOut(500, function() {
              $(this).remove();
            });

            PhotoEditForm.isInitialized = false;

            $(".editwrapper").remove();
            $(".modal-backdrop").fadeOut(500, function() {
              $(this).remove();

              setTimeout(function(){
                Modal.show();
              })
            });
          });
        });           
      }
    }
    else {
      $(".photo_crop, .photo_rotate").hide();
    }

    $(".photo_exit, .photo_crop, .photo_rotate, .thumb_remove").hover(function() {
      /* Stuff to do when the mouse enters the element */
      $(this).addClass('icon42');
    }, function() {
      /* Stuff to do when the mouse leaves the element */
      $(this).removeClass('icon42');
    });

    //
    // exit form
    //
    $(".photo_exit").click(function(event) {
      /* Act on the event */
      PhotoEditForm.isInitialized = false;

      $(".editwrapper").remove();
      $(".modal-backdrop").fadeOut(500, function() {
        $(this).remove();

        setTimeout(function(){
          Modal.show();
        })
      });
    });

    //
    // rotate photo
    //
    $(".photo_rotate").click(function(event) {
      /* Act on the event */
      showLoader();

      $.ajax({
        url: "/" + Mokio.engine_root() + "/"+default_data_file+"/" + Modal.id() + "/rotate_" + PhotoEditForm.photo_type
      })
      .done(function() {
        updateAjaxPhoto();
        reloadScripts();
      });
    });

    //
    // calculating the coordinates
    //
    function showPreview(coords) {
      if (parseInt(coords.w) > 0) {
        var rx = 150 / coords.w;
        var ry = 150 / coords.h;

        $('#preview-img').css({
          width: Math.round(rx * photox) + 'px',
          height: Math.round(ry * photoy) + 'px',
          marginLeft: '-' + Math.round(rx * coords.x) + 'px',
          marginTop: '-' + Math.round(ry * coords.y) + 'px'
        });
      } 
      //
      // remember coordinates
      //
      PhotoEditForm.crop_x = coords.x;
      PhotoEditForm.crop_y = coords.y;
      PhotoEditForm.crop_w = coords.w;
      PhotoEditForm.crop_h = coords.h;
    }

    //
    // crop photo
    //
    $(".photo_crop").click(function(event) {
      /* Act on the event */
      if ( !$(this).hasClass('show') ) {
        $(this).addClass('show')

        $(".editwrapper").append('<span class="photo_cut icon32 icomoon-icon-scissors-2 white"></span>')
                         .append("<div class=\"preview\"><img id=\"preview-img\" src=\"" + $("#photo_edited").attr('src') + "\"</div>");

        $(".photo_cut").hide().fadeIn(500);
        $(".preview").hide().fadeIn(500);

        photox = $("#photo_edited").width();
        photoy = $("#photo_edited").height();

        $(".photo_cut").hover(function() {
          /* Stuff to do when the mouse enters the element */
          $(".photo_cut").addClass('icon42');
        }, function() {
          /* Stuff to do when the mouse leaves the element */
          $(".photo_cut").removeClass('icon42');
        });

        //
        // Jcrop to crop photo
        //
        $('#photo_edited').Jcrop({
          minSize: [30, 30],
          onChange: showPreview, // calculate coordinates on change 
          onSelect: showPreview, // same on select
          aspectRatio: 1,
          boxWidth: 700,
          setSelect: [150, 150, 100, 100]
        }, function() {});

        //
        // send crop coordinates
        //
        $(".photo_cut").click(function(event) {
          /* Act on the event */
          showLoader();

          $.ajax({
            url: "/" + Mokio.engine_root() + "/"+ default_data_file +"/" + Modal.id() + "/crop_" + PhotoEditForm.photo_type,
            type: 'POST',
            dataType: 'script',
            data: {
              x: PhotoEditForm.crop_x, // position x
              y: PhotoEditForm.crop_y, // position y
              w: PhotoEditForm.crop_w, // width
              h: PhotoEditForm.crop_h  // height
            }
          })
          .done(function() {
            updateAjaxPhoto();

            $(".photo_crop").removeClass('show')

            $(".photo_cut").fadeOut(500, function() {
              $(".photo_cut").remove();
            });
            $(".preview").fadeOut(500, function() {
              $(".preview").remove();
            });

            reloadScripts();   
          });
        });
      }
      else {
        $(this).removeClass('show');

        $("#photo_edited").css('display', 'inline-block');

        $(".photo_cut").fadeOut(500, function() {
          $(".photo_cut").remove();
        });

        $(".preview").fadeOut(500, function() {
          $(".preview").remove();
        });
        //
        // disable Jcrop
        //
        JcropAPI = $('#photo_edited').data('Jcrop'); 
        JcropAPI.destroy();
      }
    });
  }
}