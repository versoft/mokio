# frozen_string_literal: true

Mokio::Engine.routes.draw do
  root to: 'dashboard#show'

  devise_for :users, class_name: 'Mokio::User', module: :devise, controllers: { passwords: 'mokio/passwords', :sessions => "mokio/sessions" }

  devise_scope :user do
    post '/users/send_pass_change_link' => "passwords#send_pass_change_link", as: 'send_pass_change_link'
  end

  resources :backend_search,only: [:index]

  resources :menus do
    member do
      get :update_menu_breadcrumps
      get :copy
    end
    collection do
      post :sort
      get :lang_changed
      get :new_menu_position
      post :create_menu_position
    end
  end

  resources :static_modules do
    member do
      get :copy
      post :update_active
    end
  end

  resources :users do
    member do
      get :copy
      get :edit_password
      patch :update_password
    end
  end

  resources :contents do
    member do
      get  :copy
      post :update_active
      delete :delete_main_pic
    end
    collection do
      get '/only_loose', to: 'contents#index', only_loose: 1
    end
  end

  resources :articles do
    member do
      get  :copy
      post :update_active
    end
  end

  resources :static_pages

  resources :pic_galleries do
    member do
      get  :copy
      post :update_active
    end
  end

  resources :mov_galleries do
    member do
      get  :copy
      post :update_active
    end
  end

  resources :contacts do
    member do
      get  :copy
      post :update_active
    end
  end

  resources :data_files do
    collection do
      post :sort
    end
  end

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

  resources :external_scripts do
    member do
      post :update_active
      get  :copy
    end
  end

  resources :module_positions do
    member do
      post :update_active
      get  :copy
    end
  end

  resources :langs do
    member do
      post :update_active
      get :copy
    end
  end

  resources :support, only: :index

  post '/histories/get_n_more' => 'histories#get_n_more'
end
