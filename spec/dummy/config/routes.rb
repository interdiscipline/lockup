Rails.application.routes.draw do

  mount Lockup::Engine, at: '/lockup', as: 'lockup'

  resources :posts, only: [:index, :show]

  # this makes tests fail with endless redirect loop b/c it is before lockup routes
  # catch all route b/c Rails `rescue_from` doesn't catch ActionController::RoutingError
  match '*path', via: :all, to: 'application#render_404'
end
