module Mokio
  module Concerns #:nodoc:
    module Common #:nodoc:
      module Services
        module Sitemap
          module Service
            extend ActiveSupport::Concern
            attr_accessor :regenerate_sitemap

            def self.regenerate_sitemap
              begin
                sitemap_enabled  = Mokio.mokio_sitemap_generator_enable || false
                return unless sitemap_enabled

                mokio_cfg_sitemap_enabled_models = Mokio.mokio_sitemap_enabled_models
                mokio_cfg_routes = Mokio.mokio_sitemap_generator_static
                mokio_cfg_path = Mokio.mokio_sitemap_generator_path

                @sitemap_generator_enabled_models = (mokio_cfg_sitemap_enabled_models.any?) ? mokio_cfg_sitemap_enabled_models : []
                @sitemap_generator_static_routes = (mokio_cfg_routes.any?) ? mokio_cfg_routes : []
                @sitemap_generator_path = (mokio_cfg_path.present?) ? mokio_cfg_path :  "sitemap.xml"
                @sitemap_generator_base_url = parse_base_url

                @static_content_priority = 1
                @dynamic_content_priority = 1

                @default_date = DateTime.now.strftime("%Y-%m-%dT%H:%M:%S%:z")
                generate_sitemap

              rescue StandardError => e
                Rails.logger.error "Sitemap service: error"
                Rails.logger.error "Rescued: #{e.inspect}"
              end
            end

            private

            def self.parse_base_url
              root_url =  ENV['APP_HOST']
              if root_url.blank?
                "/"
              else
                root_url = root_url.strip
                root_url = "#{root_url}/" if root_url.last != "/"
                root_url
              end
            end

            def self.generate_sitemap
              puts "Sitemap service: call"
              generate_xml
            end

            def self.generate_static_sitemap(xml)
              puts "Sitemap service: Generate static sitemap: start"
              return xml_static_collection(xml)
              return nil
            end

            def self.generate_dynamic_sitemap(xml)

              puts "Sitemap service: Generate dynamic sitemap: start"
              data = []

              @sitemap_generator_enabled_models.each do |model_name|
                model = model_name.classify.constantize
                model.all.each do |rec|
                  if rec.can_add_to_sitemap?
                    data << rec.sitemap_url_strategy_default
                  end
                end
              end

              puts "Sitemap service: empty collection" if data.nil?
              return xml_dynamic_collection(data,xml) if data.present?
              return nil
            end

            def self.generate_xml
              puts "Sitemap service: Generate new xml file"

              begin
                xml = Nokogiri::XML::Builder.new { |xml|
                  xml.urlset('xmlns:xsi' => "http://www.w3.org/2001/XMLSchema-instance",:xmlns => "http://www.sitemaps.org/schemas/sitemap/0.9") do
                    generate_static_sitemap(xml)
                    generate_dynamic_sitemap(xml)
                  end
                }.to_xml

                path_file = "#{Rails.public_path}/#{@sitemap_generator_path}"
                puts "Sitemap service: Save xml file to public #{@sitemap_generator_path} - #{path_file}"
                file = File.new(path_file, "w")
                file.write(xml)
                file.close
                return true
              rescue StandardError => e
                Rails.logger.error "Sitemap service: error"
                Rails.logger.error "Rescued: #{e.inspect}"
              end
            end

            def self.xml_dynamic_collection(obj,xml)
              obj.each do |item|
                path = item[:loc]
                date = item[:lastmod].strftime("%Y-%m-%dT%H:%M:%S%:z") || @default_date

                if path.present?
                  xml.url do
                    xml.loc parse_url(path)
                    xml.lastmod date
                    xml.priority @dynamic_content_priority
                  end
                end
              end
            end

            def self.xml_static_collection(xml)
              @sitemap_generator_static_routes.each do |item|
                path = item[:loc]
                date = item[:lastmod] || @default_date
                if path.present?
                  xml.url do
                    xml.loc parse_url(path)
                    xml.priority item[:priority] || @static_content_priority
                    xml.lastmod date
                  end
                end
              end
            end

            def self.parse_url(path)
              if path.first == "/"
                result_path = path
              else
                result_path = "/#{path}"
              end
              base_url = @sitemap_generator_base_url[0...-1] if @sitemap_generator_base_url.last == "/"
              "#{base_url}#{result_path}"
            end
          end

          module Model
            extend ActiveSupport::Concern

            included do
              after_save :regenerate_sitemap
              after_destroy :regenerate_sitemap
            end

            def regenerate_sitemap
              Service.regenerate_sitemap
            end

            def can_add_to_sitemap?
              true
            end

            def sitemap_url_strategy_default
              if self.respond_to? :sitemap_url_strategy
                return self.sitemap_url_strategy
              else
                if self.respond_to? :title
                  value = self.title
                elsif self.respond_to? :name
                  value = self.name
                elsif self.respond_to? :columns_for_table
                  first_column = self.class.columns_for_table.first
                  value = self.send("#{first_column }")
                else
                  raise "sitemap_url_strategy not found in #{self.class} and service can't find any compatible columns for path generation"
                end

                return {loc: "#{value}", priority: 1, lastmod: self.updated_at }
              end
            end

            # EXAMPLE USAGE OF sitemap_url_strategy METHOD IN INCLUDED MODEL
            # def sitemap_url_strategy(obj)
            #   {loc: "#{self.title}",priority: 1,lastmod: self.updated_at }
            # end

            # EXAMPLE USAGE OF sitemapable METHOD IN INCLUDED MODEL
            # def sitemapable
            #   (self.title == "title2") ? true : false
            # end

          end
        end
      end
    end
  end
end
