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

- It returns collection of childrens
```ruby
  model_object.childrens
```
- You can simply add child element with shovel operator "<<"

```ruby
  model_object.first.childrens << other_model.last
```

- It returns a parent model object ( If your model is Mokio::Category this method return Mokio::Category object related to parent structure object)

```ruby
  model_object.parent
```