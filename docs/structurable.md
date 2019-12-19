## Mokio Structurable


### Usage

- Include structurable model
```ruby
  include Mokio::Concerns::Common::Structurable
```

- Example: app/models/mokio/category.rb

```ruby
  class Mokio::Category < ActiveRecord::Base
    include Mokio::Concerns::Common::Structurable
  end
```

- Regenerate / Build structure in existing model

```ruby
  model_name = "Mokio::Category"
  rake mokio:structurable:rebuild[model_name]
```
### Childrens and parent

- For example:
```ruby
  model_object = Mokio::Category
```

#### Childrens

- It returns collection of childrens
```ruby
  model_object.first.childrens
```

```ruby
  model_object.find(1).childrens
```

- You can simply add child element with shovel operator "<<"

```ruby
  model_object.first.childrens << model_object.last
```

#### Parent

- It returns a parent model object ( If your model is Mokio::Category this method return Mokio::Category object related to parent structure object)

```ruby
  model_object.parent
```

### Backend view integration

- You can set table columns in method structurable_custom_columns

```ruby
  def self.structurable_custom_columns
    %w(name content)
  end
```
- Example with full model code:

```ruby
class Mokio::Category < ActiveRecord::Base
  include Mokio::Concerns::Common::Structurable

  def self.structurable_custom_columns
    %w(name content)
  end
end

```