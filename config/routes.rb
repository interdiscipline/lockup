Rails.application.routes.draw do
  mount Lockup::Engine, at: '/lockup'
end

Lockup::Engine.routes.draw do
  match 'unlock' => 'lockup#unlock'
end
