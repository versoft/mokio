## Mokio BackendSearch

### Enable search in models

For enable backend search functionality You should set models array in mokio config.
```
  config.backend_search_enabled = ["Mokio::Content","Mokio::Menu","Mokio::YourModel"]
```

### Columns
It's possible to customize which columns should be included in search results.
This method should be added into custom model:

```
  def self.backend_search_columns
    %w(title content)
  end
```
