module Lockup
  module LockupHelper

    def lockup_hint_present?
      if ENV["LOCKUP_HINT"].present? || ENV["lockup_hint"].present? || Figaro.env.lockup_hint.present? || ((Rails::VERSION::MAJOR >= 4 && Rails::VERSION::MINOR >= 1) && Rails.application.secrets.lockup_hint.present?)
        true
      else
        false
      end
    end

    def lockup_hint_display
      if ENV["LOCKUP_HINT"].present?
        ENV["LOCKUP_HINT"].to_s
      elsif ENV["lockup_hint"].present?
        ENV["lockup_hint"].to_s
      elsif Figaro.env.lockup_hint.present?
        Figaro.env.lockup_hint.to_s
      elsif (Rails::VERSION::MAJOR >= 4 && Rails::VERSION::MINOR >= 1) && Rails.application.secrets.lockup_hint.present?
        Rails.application.secrets.lockup_hint.to_s
      end
    end

  end
end
