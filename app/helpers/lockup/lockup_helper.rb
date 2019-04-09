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
      elsif (Rails::VERSION::MAJOR >= 4 && Rails::VERSION::MINOR >= 1) && Rails.application.secrets.lockup_hint.present?
        Rails.application.secrets.lockup_hint.to_s
      end
    end

  end
end
