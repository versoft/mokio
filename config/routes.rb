Mokio::Engine.routes.draw do
  root to: "dashboard#show"
  devise_for :users, class_name: "Mokio::User", module: :devise
  
      #
      # menus routes
      #
      resources :menus do 
        member do
          get :update_menu_breadcrumps
          get :copy
        end

        collection do
          post :sort
          get  :lang_changed
        end
      end

      #
      # static_modules routes
      #
      resources :static_modules do
        member do
          get :copy
          get :update_active
        end
      end
      
      resources :users do
        member do
          get :copy
          get :edit_password
          patch :update_password
        end
      end

      #
      # contents routes
      #
      resources :contents do
        member do
          get  :copy
          post :update_active
        end

        collection do
          get '/only_loose', to: 'contents#index', :only_loose => 1
        end
      end

      resources :articles,      only: [:new, :create, :update, :copy]
      resources :pic_galleries, only: [:new, :create, :update, :copy]
      resources :mov_galleries, only: [:new, :create, :update, :copy]
      resources :contacts,      only: [:new, :create, :update, :copy]
      get '/articles'      => redirect("#{Mokio::Engine.routes.url_helpers.root_path}contents")
      get '/pic_galleries' => redirect("#{Mokio::Engine.routes.url_helpers.root_path}contents")
      get '/mov_galleries' => redirect("#{Mokio::Engine.routes.url_helpers.root_path}contents")
      get '/contacts'      => redirect("#{Mokio::Engine.routes.url_helpers.root_path}contents")

      # TODO: do we realy want it?
      # content_children_routes()

      #
      # data_files routes
      #
      resources :data_files do
        collection do
          post :sort        
        end
      end
      
      #
      # photos routes
      #
      resources :photos do
        member do
          get    :get_photo
          get    :get_thumb
          get    :rotate_photo
          get    :rotate_thumb
          post   :crop_photo
          post   :crop_thumb
          post   :upload_external_links
          patch  :update_thumb
          delete :remove_thumb
        end
      end

      #
      # youtubes routes
      #
      resources :youtubes do
        member do
          patch :update_thumb
          get   :preview_movie
          get   :load_new_form
        end

        collection do
          post :find
        end
      end
      
          #
      # external_scripts
      #
      resources :external_scripts do
        member do
          get :update_active
          get  :copy

        end
      end


      resources :module_positions do
        member do
          get :update_active
          get  :copy
        end
      end

      resources :langs do
        member do
          get :update_active
          get :copy
        end
      end
      
end

Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
end
