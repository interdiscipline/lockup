Lockup::Engine.routes.draw do
  get   'unlock' => 'lockup#unlock', as: 'unlock'
  post  'unlock' => 'lockup#unlock'
end
