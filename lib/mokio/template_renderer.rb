module Mokio
  module TemplateRenderer
    #
    # Reading config
    #
    def self.read_config
      conf_path =  "config/views.yml"

      #read app configuration
      config = YAML.load_file Rails.root + conf_path if File.exist?(Rails.root + conf_path)
      config ||= []

      #read gems configuration
      Gem.loaded_specs.each do |key, value|
        file = value.full_gem_path + "/" + conf_path
        if File.exist?(file)
          gem_config = YAML.load_file file
          MOKIO_LOG.info "[TemplateRenderer] Reading #{file}."
          config += gem_config
          MOKIO_LOG.info "[TemplateRenderer] Adding config #{gem_config}."
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

    #
    # Rendering view
    #
    def self.render(content, context, options, renderer)
      config = Rails.configuration.views_config

      tpl_name = options[:template] if options.has_key?(:template)
      tpl_name = options[:partial]  if options.has_key?(:partial)

      #
      # check for templates from controller actions
      #
      unless options[:prefixes].blank?
        options[:prefixes].each do |prefix|
          tpl = "#{prefix}/#{options[:template]}"

          if config.has_key?(tpl)
            tpl_name = tpl
            break
          end
        end
      end

      MOKIO_LOG.debug "[TemplateRenderer] tpl_name: #{tpl_name}, config.has_key?: #{config.has_key?(tpl_name)}."
      
      #
      # if view is an override
      #
      if config.has_key?(tpl_name)
        MOKIO_LOG.info "[TemplateRenderer] Overriding view #{tpl_name}."

        to_parse = content.html_safe

        config[tpl_name].each do |entry|
          @html = Nokogiri::HTML::Document.parse to_parse
                        
          element_path = entry["html_element_id"] if entry["html_element_id"]
          element_path ||= entry["element_path"] 
          
          if entry["type"] == "xpath"
            MOKIO_LOG.debug "[TemplateRenderer] Parsing element with xpath"
            html_element = @html.at_xpath element_path

          elsif entry["type"] == "css" || !entry["type"] || entry["type"] == "" 
            html_element = @html.at_css element_path
            MOKIO_LOG.debug "[TemplateRenderer] Parsing element with css"
          end
                      
          new_options          = {:template => entry["override_path"]} if options.has_key?(:template)
          new_options          = {:partial => entry["override_path"]}  if options.has_key?(:partial)
          new_options[:locals] = options[:locals]                      if options[:locals]
          
          new_html = renderer.render context, new_options
                  
          case entry["position"]
          when "before"
            html_element.add_previous_sibling(new_html)
          when "after"
            html_element.add_next_sibling(new_html)
          when "inside" || ""
            html_element.add_child(new_html)
          else
            html_element.add_child(new_html)
          end

          MOKIO_LOG.debug "[TemplateRenderer] Postion for '#{entry["override_path"]}' is: '#{entry["position"] ? entry["position"] : "inside"} #{element_path}'"
                
          to_parse = @html.to_s
        end

        ActiveSupport::SafeBuffer.new(to_parse)
      else
        content
      end
    end
  end
end

