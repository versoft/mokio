## Custom models and controllers

You can generate new model/controller pair either by doing it yourself or using a generator.

#### Step-by-step version for ambitious people

Suppose you want add new model called Product to CMS.
1. Create standard model in `app/models/product.rb`,
    ```
    class Product < ApplicationRecord
      ...
    end
    ```
      with database columns:
      - id - integer
      - active - boolean
      - name - string
      - content - text
      (I skipped creating migrations)

2. Configure index view (a list with product columns)
    - columns in index view
    Suppose you want columns with ID, active info and name of a product.
    Use `self.columns_for_table` - it returns an array of string with column names
      ```
      def self.columns_for_table
        %w[id active_label name]
      end

      def active_label
        if active
          "<span style='color:green'>yes</span>"
        else
          "<span style='color:red'>no</span>"
        end
      end
      ```
      Here we use `active_label` instead of `active` to get better looking
    - sorting columns and search
      By default all :text and :string columns are being searched in database.
      To override this use `self.allowed_search_columns` and return column names to be searched.
      ```
      # search only by column name
      def self.allowed_search_columns
        ['name']
      end
      ```
      Above we use custom `active_label` method. To make this column properly sortable use `self.override_column_sort` and bind custom method with column name
      ```
      def self.override_column_sort
        {
          active_label: 'active',
        }
      end
      ```
      To setup default sorting use `self.default_datatable_sorting`. Below method will sort first column (ID) by desc, and second column (active_label) by asc. Check `self.columns_for_table`
      ```
      def self.default_datatable_sorting
        [[0, 'desc'], [1, 'asc']]
      end
      ```
    - To add preview link to frontend use method `mokio_preview_link_in_edit_page`:
      ```
      def mokio_preview_link_in_edit_page
        Rails.application.routes.url_helpers.show_news_path(slug)
      end
      ```
    - other options:
      ```
      # can edit
      def editable
        true
      end

      #can remove
      def deletable
        true
      end

      #can clone
      def cloneable?
        false
      end
      ```
    - You can hide action button column in index view by adding `show_index_table_actions?` class method set to `false` in your model:
      ```
      def self.show_index_table_actions?
        false
      end
      ```
3. Create controller `app/controllers/mokio/products_controller.rb` and add private params method
      ```
      module Mokio
        class ProductsController < Mokio::CommonController
          private
          def product_params
            params.require(:product).permit(
              :name,
              :active,
              :content
            )
          end
        end
      end
      ```
4. Update Routes `config/routes.rb`
    ```
    Mokio::Engine.routes.draw do
      resources :products
      ...
    end
    ```
5. Create create/edit form `app/views/products/_form.html.slim`
    ```
    div
      = f.input :active, label: "Active"
      = f.input :name, label: "Name"
      = f.input :content, label: "Content"
    ```
6. Update sidebar. To do it you have to overwrite it.
  Create file `app/views/mokio/layout/sidebar.html.slim` and copy content from Mokio sidebar [https://github.com/versoft/mokio/blob/master/app/views/mokio/layout/sidebar.html.slim](https://github.com/versoft/mokio/blob/master/app/views/mokio/layout/sidebar.html.slim)
  Now you can customize it to your needs

#### Content generator
You can use a provided generator to create a new model/controller easily:
`bundle exec rails g mokio:contents cat`

The generator will create the following files for you:
```
      create  app/models/mokio/cat.rb
      create  app/controllers/mokio/cats_controller.rb
      create  app/views/mokio/cats/_form.html.slim
      create  app/views/mokio/overrides/cat_sidebar_btn.html.slim
      create  config/locales/en_backend_cat.yml
      create  config/cat_views_template.yml.example
```