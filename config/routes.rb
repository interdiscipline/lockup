Rails.application.routes.draw do
  mount Lockup::Engine, at: '/lockup'
end

Lockup::Engine.routes.draw do
  get   'unlock' => 'lockup#unlock'
  post  'unlock' => 'lockup#unlock'
end
