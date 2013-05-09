module Lockup
  class Engine < ::Rails::Engine
    isolate_namespace Lockup

    ENV["LOCKUP_CODEWORD"] ||= "dave"

    initializer 'lockup.app_controller' do |app|
      ActiveSupport.on_load(:action_controller) do
        include Lockup::InstanceMethods
        extend Lockup::ClassMethods
        before_filter :check_for_lockup
      end
    end
  end
end
