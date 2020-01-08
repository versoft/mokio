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
