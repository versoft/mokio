## Mokio Select2

### Add select2 support for select input
  - Standard  select input  should have css class `mokio-select2`. For example:
    ```
      = f.collection_select(:website_id, Website.active.order(:name), :id, :name, {selected: @website_id, include_blank: true}, {class: 'mokio-select2'})
    ```

  - Simple form rails input with collection should have `wrapper: :select2`. For example:
    ```
        = f.input :server, collection: Website.servers.keys, label: "Serwer", wrapper: :select2
    ```
### Asynchronous fetching data
  - Controller: Array data json response
    ```ruby
      def ajax_collection
        render json: [{id: 1, name: "Name1"}, {id: 2, name: "Name2"}]
      end
    ```
    Filter in select by param `term`.
  - Routing: get :ajax_collection
    ```ruby
      resources :resources do
        member do
          get :ajax_collection
        end
      end
    ```
  - View: data attribute for get ajax path
    ```ruby
      input_html: { data: { "ajax-collection" =>   ajax_collection_resource_path()}
    ```
    Example with `form_with`:
    ```
      = f.collection_select(:website_id, [], :id, :name, {selected: @website_id, include_blank: true}, {class: 'mokio-select2', data: {ajax_collection: websites_ajax_collection_path}})
    ```
