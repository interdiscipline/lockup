Rails.application.routes.draw do
  mount Lockup::Engine, at: '/lockup', :as => 'lockup'
end

Lockup::Engine.routes.draw do
  get   'unlock' => 'lockup#unlock', :as => 'unlock'
  post  'unlock' => 'lockup#unlock'
end
