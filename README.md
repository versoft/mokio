# Mokio CMS

### DOCS:
- [SeoTags](docs/seo_tags.md)
- [Generate sitemap.xml](docs/sitemap_generator.md)
- [Select2 helper](docs/select2.md)
- [Backend input helpers](docs/backend_inputs_helpers.md)

---
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

