## Mokio Backend  - input helpers
  ### Rendering: language select
  ```ruby
    render_backend_input_lang_id(form_object)
  ```
  ### Rendering: active switch
  ```ruby
    render_backend_input_active(form_object)
  ```
  ### Rendering: homepage switch
  ```ruby
    render_backend_input_home_page(form_object)
  ```
  ### Rendering: custom switch
  ```ruby

    #Custom helper method:

    def backend_input_custom_switch_input(form_object)
      render_backend_input_active_checkbox(form_object,'boolean_column_name')
    end

    #Usage in view:

    backend_input_custom_switch_input(f)
  ```
  ### Slug helper
  Mokio comes with a slug generator for inputs. You can use it to create a text field that automatically converts its contents into a slug-like format. For example typed-in string `Hello WORLD 123 !!!` will be converted into `hello-world-123`.
  
  There are two options to use slug generator.
  
  #### Simple slug field
  Please pay attention to `input_html` hash. All of the parameters should be set with the values presented below. Also, please remember to include the js file.
```
    = f.input :slug, input_html: {id: 'slug', onkeyup: 'slugHooks()', onfocusout: 'removeTracingDashes()'}
    = javascript_include_tag 'backend/form_helpers/slug_generator'
```
  #### Slug field bound to another input
  Your slug field can be automatically filled in with a parameterized string from another input. In the example shown below, the `slug` field will be filled in with data from `name` field.
```
    = f.input :name, input_html: {id: 'title', onkeyup: 'updateSlug()', onfocusout: 'removeTracingDashes()'}
    = f.input :slug, input_html: {id: 'slug', onkeyup: 'slugHooks()', onfocusout: 'removeTracingDashes()'}
    = javascript_include_tag 'backend/form_helpers/slug_generator'
```

### Adding CKEditor to your text field
To change the CKEditor toolbar size set the parameter to either `small`, `medium`, or `full`.
```
= f.input :intro, :wrapper => :ckeditor, :as => :ckeditor, :input_html => {:ckeditor => {:toolbar => 'Full', :height => 150, :language => I18n.locale} }
```