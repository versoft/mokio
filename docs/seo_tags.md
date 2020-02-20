## Mokio SeoTags

### Internal models
Mokio::Menu and Mokio::Content are using SeoTags out of the box. You do not have to do anything.

### External models:
Include SeoTags module:
```
include Mokio::Concerns::Common::SeoTags
```

If you want override some columns in SeoTags use:
`def seo_tagable_custom_columns`
example:
```
def seo_tagable_custom_columns
  %w(some_key some_key2)
end
```
List of all keys is here: `lib/mokio/concerns/models/seo_tag.rb` in method `seo_tags_list`. Look on `key`.

Remeber to add `:seo_tags_attributes: [:id, :tag_key, :tag_value, :_destroy]` in your controller's params.

### Default meta tags
There are two ways to setup default meta tags:
1. Add meta tags to render if is not created relation with SeoTag.
In your model add method:
```
def default_seo_tags
  [{
    key: 'title',
    value: self.name
  },
  {
    key: 'og:type',
    value: "some type"
  }]
end
```
2. Auto create relation after create object model.
```
def auto_create_meta_tags
  [{
    key: 'title',
    value: self.name
  },
  {
    key: 'og:type',
    value: "some type"
  }]
end
```
**Important! the `key` have to match to key used in `seo_tags_list` method.**


### Render meta tags
To render meta tags in fronted use helper:
` = render_seo_meta_tags(object_from_activerecord)`


If you get error "Method not found" include helper: `helper Mokio::FrontendHelpers::SeoTagHelper`.

### Migrating from Mokio < 2.0
To generate `Mokio::Seotags` from `Mokio::Menu` data run `rails seotags:generate_from_meta` task in terminal.