Rails.application.routes.draw do
  resources :lockup
  
  mount Lockup::Engine, at: '/lockup'
end

Lockup::Engine.routes.draw do
  match 'unlock' => 'lockup#unlock'
end
