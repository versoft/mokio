module Mokio
  module FrontendHelpers

    module TemplateHelper


      def self.read_config
        conf_path =  "config/views.yml"

        #read app configuration
        if File.exist?(Rails.root + conf_path)
          config = YAML.load_file Rails.root + conf_path
        else
          config ||= []
        end

        #read gems configuration
        Gem.loaded_specs.each do |key, value|
          file = value.full_gem_path + "/" + conf_path
          if File.exist?(file)
            gem_config = YAML.load_file file
            config += gem_config
          end
        end

        #build result hash
        result = Hash.new
        config.each do |value|
          new_key = value["original_view"]
          result[new_key] = [] if !result.has_key?(new_key)
          result[new_key].push value
        end
        result
      end

      def self.render(content, context, options, renderer)
        config = Rails.configuration.views_config
        tpl_name = options[:template] if options.has_key?(:template)
        tpl_name = options[:partial] if options.has_key?(:partial)

        if config.has_key?(tpl_name)
          to_parse = content.html_safe
          config[tpl_name].each do |entry|
            @html = Nokogiri::HTML::Document.parse to_parse
            html_element = @html.at_css entry["html_element_id"]
            new_options = {:template => entry["override_path"]} if options.has_key?(:template)
            new_options = {:partial => entry["override_path"]} if options.has_key?(:partial)
            new_options[:locals] = options[:locals] if options[:locals]
            new_html = renderer.render context, new_options
            html_element.add_child(new_html)
            to_parse = @html.to_s
          end
          ActiveSupport::SafeBuffer.new(to_parse)
        else
          content
        end

      end

    end
  end
end
