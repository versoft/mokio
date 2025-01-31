Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor' 
  mount Mokio::Engine, at: "/backend"
end


