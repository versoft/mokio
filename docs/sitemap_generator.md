## Sitemap generator

### Setup
1. Add in `config/initializers/mokio.rb` config:
  - enable sitemap generator:
	```
	config.mokio_sitemap_generator_enable = true
	```
  - if you want you can add static routes like:
	```
    config.mokio_sitemap_generator_static = [
	    {loc: '/address', lastmod: '2019-11-21T11:03:04+00:00', priority: 1, changefreq: 'monthly'},
	    {loc: '/address-another'}
    ]
	```
  - Default folder for generate sitemap.xml is /public. You can override it by below config.
  For example to generate sitemap.xml in /public/xml/ do:
	```
	config.mokio_sitemap_generator_path = "xml/sitemap.xml"
	```
  Remeber to check if new directory exists.
  - add dynamic created content by setting models name in config:
	```
	config.mokio_sitemap_enabled_models = ["Mokio::Content", "Category", "Mokio::StaticPage"]
	```

2. Create `ENV['APP_HOST']`. It will be used for prefix in generated URLS. For example:
	```
	ENV['APP_HOST']='http://mypage.com/'
	```
3. If you want add some external, dynamic logic during generation of the sitemap you can use `Mokio::SitemapExternalLogic`.
Overwrite this file in: `app/models/mokio/sitemap_external_logic.rb`.
Method `self.data_for_xml` executes automatically. DO NOT change this method's name.
  ```
  module Mokio
    class SitemapExternalLogic
      def self.data_for_xml
        [
          { loc: 'url', lastmod: date, priority: 1, changefreq: 'monthly'  },
          ...
        ]
      end
    end
  end
  ```

### Use in models
1. In your class add:
```
include Mokio::Concerns::Common::Services::Sitemap::Model
```
2. If you want you can setup the way of generating content:
```
  def sitemap_url_strategy
    {
      loc: Rails.application.routes.url_helpers.category_path(self.slug),
      priority: 1,
      lastmod: self.updated_at,
      changefreq: 'monthly'
    }
  end
  ```
3. If you want add conditional check before add to sitemap.xml use:
  ```
  def can_add_to_sitemap?
    self.active
  end
  ```
4. If you want disable generation during save use:
  ```
  obj.disable_sitemap_generator = true
  obj.save
  ```
4. Sitemap will generate automatically after save or destroy model.

Manually recreate sitemap.xml by command:
`rake mokio:recreate_sitemap`
