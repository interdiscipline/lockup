# frozen_string_literal: true

module Lockup
  module LockupHelper
    def lockup_hint
      @lockup_hint ||=
        ENV['LOCKUP_HINT'] ||
        ENV['lockup_hint'] ||
        ::Lockup.from_config(:hint, :secrets) ||
        ::Lockup.from_config(:hint)
    end
  end
end
