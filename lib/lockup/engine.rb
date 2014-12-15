module Lockup
  class Engine < ::Rails::Engine
    isolate_namespace Lockup

    config.generators do |g|
      g.test_framework :rspec, fixture: false
      g.assets false
      g.helper false
    end

    initializer 'lockup.app_controller' do |app|
      ActiveSupport.on_load(:action_controller) { include Lockup }
    end
  end
end
