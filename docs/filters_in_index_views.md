## Mokio Filters in index views

1. To add filters, add static method `filter_index_config` to your model. Full config:
```
enum field: [:value, :value2, :value3]
belongs_to :website
...
def self.filter_index_config
  {
    # generate <select>
    active: {
      field_type: 'select',
      values: [['Aktywny', true], ['Nieaktywny', false]]
    },
    # generate <select> with enum values
    my_integer_field: {
      field_type: 'select',
      values: SampleModel.fields.map {|k,v| [k,v]}
    },
    # generate <select> with all Website objects
    website_id: {
      field_type: 'select',
      values: Website.all.map {|w| [w.url, w.id]}
    },
    # generate <input type="date" ...>
    created_at: {
      field_type: 'date'
    },
    # generate <input type="text" ...>
    title: {
      field_type: 'text'
    }
  }
end
```

2. To use it in Mokio modules use:
```
module ClassMethods
  def filter_index_config
    {
      active: {
        field_type: 'select',
        values: [['Aktywny', true], ['Nieaktywny', false]]
      }
    }
  end
end
```

3. Translations is generated from key:
```
pl.activerecord.attributes.model_name.field_name
```
For example for model `Website` and field `title`:
```
pl.activerecord.attributes.website.title: My title
```

