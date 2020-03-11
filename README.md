# Mokio CMS

## In short:
MOKIO is open source CMS compatible with rails 6.0.1 and ruby 2.6.5.

## Instalation:
1. Add `gem mokio` to `Gemfile` in your project
2. Run `bundle install`
3. Run `rake mokio:install`
4. Ensure is add the following line added to `config/routes.rb`
  ```mount Mokio::Engine => "/backend"```
5. Start rails server `rails s` and open `http://localhost:3000/backend`
6. Your login is `admin@admin.com`, password `admin`
7. Remember to change this sample credentials!

## Usage:
### Overriding Mokio js
In case you need to add some custom logic to Mokio panel's javascript, run:

`rails mokio:add_custom_js`

in your project's folder.

This task will create `custom.js` file in under `assets/javascripts/backend` folder, which will be imported in the panel.

### Adding gallery to your custom model
#### In your model:
Include Gallery
```
include Mokio::CustomGallery
```

Change DataFile type if needed (Mokio::Photo is set by default)
```
def default_data_file
  # Available options:
  # Mokio::Photo 
  # Mokio::Youtube
end
```

Optionaly add gallery title
```
def gallery_title
  "Gallery title"
end
```

## More docs:
- [Custom model and controller](docs/custom_models_and_controllers.md) - How to create own model and controller in CMS
- [SeoTags](docs/seo_tags.md) - How to add meta tags to your own models
- [Generate sitemap.xml](docs/sitemap_generator.md) - How to generate automatic sitemap.xml for dynamic and static content
- [Select2 helper](docs/select2.md) - How to use select inputs with autosearch
- [Backend input helpers](docs/backend_inputs_helpers.md) - Describes some input helpers
More docs soon!

---
### Secure login with Google reCAPTCHA v3
To turn on login with reCAPTCHA go to config/mokio.rb and update configs:
```
  config.mokio_login_with_recaptcha = true
  config.mokio_login_recaptcha_site_key = 'KEY'
  config.mokio_login_recaptcha_secret_key = 'KEY'
  config.mokio_login_recaptcha_score = 0.9
```
More info: [reCAPTCHA v3](https://developers.google.com/recaptcha/docs/v3)

### Gems and sample_app:

##### Sample app using Mokio CMS

See https://github.com/versoft/mokio_sample_app

##### Gems dedicated for Mokio CMS:

mokio_skins https://github.com/versoft/mokio_skins

##### Tutorials, documentation & useful tips

See http://www.mokio.org/support

##### Known issues

To use Mokio::MovGallery you have to add this to your Gemfile:

`gem 'youtube_it', github: 'LiveWorld/youtube_it'`

because original version of `youtube_it` gem is not maintained anymore and uncompatibile with Rails 5.


### Description

Mokio is a Content Management System that allows creation of
sophisticated websites. It consists maily of administration panel for your
desired website.
It provides the following types of content: Article (piece of text with
pictures, lists, links, etc.), Picture Gallery (easily managed article with
a number of photos - thumbs and edition provided), Movie Gallery
(article with links to Dailymotion, Vimeo and Youtube movies - thumbs
and edition provided), Contact Page with Google map and contact form.

Apart from content it is possible to manage menu structure of your
website for each language and defined position (part of the screen).

If this is not enough for what you need, you can also include pieces of
HTML code that should be shared by some (or all) subpages - called
HTML Blocks. You can define on which part of the page, these blocks
should be displayed.
Mokio provides also administration panel for javascripts, languages
and backend users.

Beside Mokio itself, there are various gems dedicated for Mokio, that
extends its core functionality.

### Licence

GNU AGPLv3: http://www.gnu.org/licenses/agpl-3.0.html

