module Mokio
  module Backend
    module JavascriptHelper

      def notice
        capture_haml do
          haml_tag :script do
            haml_concat(
              "setTimeout(function(){
                $(\".alert-block\").fadeOut(\"slow\");
              },4000)")
          end
        end
      end

      def fancybox
        capture_haml do
          haml_tag :script do
            haml_concat(
              "$(document).ready(function() {
                $(\"a.fancybox\").fancybox();
              });")
          end
        end
      end 

      def flash_message(message)
        capture_haml do
          haml_tag :script do
            haml_concat(
              "$(document.body).prepend(\"<div id=\\\"FlashInfo\\\">\" + 
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
            });")
          end
        end
      end
    end
  end
end