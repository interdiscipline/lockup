# frozen_string_literal: true

module Lockup
  module LockupHelper
    def lockup_hint
      @lockup_hint ||=
        ENV['LOCKUP_HINT'] ||
        ENV['lockup_hint'] ||
        lockup_hint_from_config(:secrets) ||
        lockup_hint_from_config(:credentials)
    end

    private

    def lockup_hint_from_config(secrets_or_credentials = :credentials)
      return unless Rails.application.respond_to?(secrets_or_credentials)

      store = Rails.application.public_send(secrets_or_credentials)

      store.lockup.respond_to?(:fetch) &&
        store.lockup.fetch(:hint, store.lockup_hint) ||
        store.lockup_hint
    end
  end
end
