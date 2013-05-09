module Lockup
  class Engine < ::Rails::Engine
    isolate_namespace Lockup
    initializer 'lockup.app_controller' do |app|
      ActiveSupport.on_load(:action_controller) do
        include Lockup::InstanceMethods
        extend Lockup::ClassMethods
      end
    end
  end
end
