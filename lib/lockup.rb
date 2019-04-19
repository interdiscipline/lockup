require "lockup/engine"

module Lockup
  extend ActiveSupport::Concern

  included do
    if self.respond_to?(:before_action)
      before_action :check_for_lockup, except: ["unlock"]
    else
      before_filter :check_for_lockup, except: ["unlock"]
    end
  end

  def self.from_config(setting, secrets_or_credentials = :credentials)
    return unless Rails.application.respond_to?(secrets_or_credentials)

    store = Rails.application.public_send(secrets_or_credentials)

    store.lockup.respond_to?(:fetch) &&
      store.lockup.fetch(setting, store.public_send("lockup_#{setting}")) ||
      store.public_send("lockup_#{setting}")
  end

  private

  def check_for_lockup
    return unless respond_to?(:lockup) && lockup_codeword_present?
    return if cookies[:lockup].present? && cookies[:lockup] == lockup_codeword

    redirect_to lockup.unlock_path(
      return_to: request.fullpath.split('?lockup_codeword')[0],
      lockup_codeword: params[:lockup_codeword],
    )
  end

  def lockup_codeword_present?
    ENV["LOCKUP_CODEWORD"].present? ||
    ENV["lockup_codeword"].present? ||
    (Rails.application.respond_to?(:secrets) && Rails.application.secrets.lockup_codeword.present?) ||
    (Rails.application.respond_to?(:credentials) && Rails.application.credentials.lockup_codeword.present?)
  end

  def lockup_codeword
    if ENV["LOCKUP_CODEWORD"].present?
      ENV["LOCKUP_CODEWORD"].to_s.downcase
    elsif ENV["lockup_codeword"].present?
      ENV["lockup_codeword"].to_s.downcase
    elsif Rails.application.respond_to?(:secrets) && Rails.application.secrets.lockup_codeword.present?
      Rails.application.secrets.lockup_codeword.to_s.downcase
    elsif Rails.application.respond_to?(:credentials) && Rails.application.credentials.lockup_codeword.present?
      Rails.application.credentials.lockup_codeword.to_s.downcase
    end
  end

  def cookie_lifetime_variable
    if ENV["COOKIE_LIFETIME_IN_WEEKS"].present?
      ENV["COOKIE_LIFETIME_IN_WEEKS"]
    elsif ENV["cookie_lifetime_in_weeks"].present?
      ENV["cookie_lifetime_in_weeks"]
    elsif Rails.application.respond_to?(:secrets) && Rails.application.secrets.cookie_lifetime_in_weeks.present?
      Rails.application.secrets.cookie_lifetime_in_weeks
    elsif Rails.application.respond_to?(:credentials) && Rails.application.credentials.cookie_lifetime_in_weeks.present?
      Rails.application.credentials.cookie_lifetime_in_weeks
    end
  end

  def cookie_lifetime
    weeks = (cookie_lifetime_variable || 0).to_f
    seconds = (weeks * 1.week).to_i
    if seconds > 0
      seconds
    else
      5.years
    end
  end
end
