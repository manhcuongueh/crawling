Rails.application.routes.draw do
  root 'user#index'
  get  'new'=> 'user#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
