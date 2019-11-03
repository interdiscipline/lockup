Lockup::Engine.routes.draw do
  get 'unlock', to: 'lockup#unlock', as: 'unlock'
  post 'unlock', to: 'lockup#unlock'
end
