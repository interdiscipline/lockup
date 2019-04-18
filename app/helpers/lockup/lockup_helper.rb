module Lockup
  module LockupHelper

    def lockup_hint_present?
      ENV["LOCKUP_HINT"].present? ||
      ENV["lockup_hint"].present? ||
      (Rails.application.respond_to?(:secrets) && Rails.application.secrets.lockup_hint.present?) ||
      (Rails.application.respond_to?(:credentials) && Rails.application.credentials.lockup_hint.present?)
    end

    def lockup_hint_display
      if ENV["LOCKUP_HINT"].present?
        ENV["LOCKUP_HINT"].to_s
      elsif ENV["lockup_hint"].present?
        ENV["lockup_hint"].to_s
      elsif Rails.application.respond_to?(:secrets) && Rails.application.secrets.lockup_hint.present?
        Rails.application.secrets.lockup_hint.to_s
      elsif Rails.application.respond_to?(:credentials) && Rails.application.credentials.lockup_hint.present?
        Rails.application.credentials.lockup_hint.to_s
      end
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
