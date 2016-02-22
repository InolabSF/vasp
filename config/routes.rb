Rails.application.routes.draw do
  get 'sensor', :to => 'sensor#get'
  post 'sensor', :to => 'sensor#post'
  get 'sensor/type'
  get 'air', :to => 'air#get'
  get 'user', :to => 'user#get'
  post 'user', :to => 'user#post'
  get 'square', :to => 'square#index'
end
