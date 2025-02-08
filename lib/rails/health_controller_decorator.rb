# frozen_string_literal: true

module Rails
  module HealthControllerDecorator
    def check_for_lockup
      true
    end

    klass = '::Rails::HealthController'.safe_constantize
    klass.prepend(self) if klass
  end
end
