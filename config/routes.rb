Rails.application.routes.draw do
  get 'sensor', :to => 'sensor#get'
  post 'sensor', :to => 'sensor#post'
  get 'sensor/type'
  get 'air', :to => 'air#get'
end
