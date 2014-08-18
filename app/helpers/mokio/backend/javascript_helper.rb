module Mokio
  module Backend
    module JavascriptHelper

      def notice
        "<script>
          setTimeout(function(){
            $(\".alert-block\").fadeOut(\"slow\");
          },4000)
        </script>".html_safe
      end

      def fancybox
        "<script>
          $(document).ready(function() {
            $(\"a.fancybox\").fancybox();
          });
        </script>".html_safe
      end 

      def flash_message(message)
        "<script>
          $(document.body).prepend(\"<div id=\\\"FlashInfo\\\">\" + 
              \"<div id=\\\"FlashMessage\\\">\" +
                \"<span class=\\\"icomoon-icon-warning-2 white\\\"></span>\" +
                \"#{message}\" + 
                \"<span class=\\\"icon12 icomoon-icon-cancel white infobtn\\\"></span>\" +
              \"</div>\" +
          \"</div>\");

            var $info = $('#FlashInfo');
            $info.hide();

          // hide with user action
          $('.infobtn').click(function(event) {
            $info.slideUp();
          });

          // hide after 10sec
          $info.slideDown(1500, function() {
            setTimeout(function() {
              $info.slideUp();
            }, 5000);
          });
        </script>".html_safe
      end

    end
  end
end