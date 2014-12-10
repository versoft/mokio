module Mokio
  class GaScriptGenerator < Rails::Generators::Base #:nodoc:
    source_root File.expand_path("../templates", __FILE__)
    argument :uid, :type => :string
    desc "Creates Google Analytics script and partial view"

    def create_script
      script = <<TEXT
        (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
                (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
                m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
              })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

              ga('create', '#{uid}', 'auto');
              ga('send', 'pageview');
TEXT
      Mokio::ExternalScript.create(:name => "Google Analytics", :script =>script)
    end

    def create_view
      puts "Paste it into your layout body: " + "= render :partial => 'frontend/layout_elements/google_analytics'".green
      template "_google_analytics.html.slim", "app/views/frontend/layout_elements/_google_analytics.html.slim"
    end

  end
end