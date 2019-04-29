# frozen_string_literal: true

require 'lockup/engine'

module Lockup
  extend ActiveSupport::Concern

  included do
    if respond_to?(:before_action)
      before_action :check_for_lockup, except: ['unlock']
    else
      before_filter :check_for_lockup, except: ['unlock']
    end
  end

  def self.from_config(setting, secrets_or_credentials = :credentials)
    return unless Rails.application.respond_to?(secrets_or_credentials)

    store = Rails.application.public_send(secrets_or_credentials)

    store.lockup.respond_to?(:fetch) &&
      store.lockup.fetch(setting, store.public_send("lockup_#{setting}")) ||
      store.public_send("lockup_#{setting}") || store.public_send(setting)
  end

  private

  def check_for_lockup
    return unless respond_to?(:lockup) && lockup_codeword
    return if cookies[:lockup].present? && cookies[:lockup] == lockup_codeword.to_s.downcase

    redirect_to lockup.unlock_path(
      return_to: request.fullpath.split('?lockup_codeword')[0],
      lockup_codeword: params[:lockup_codeword]
    )
  end

  def cookie_lifetime
    @cookie_lifetime ||=
      ENV['COOKIE_LIFETIME_IN_WEEKS'] ||
      ENV['cookie_lifetime_in_weeks'] ||
      Lockup.from_config(:cookie_lifetime_in_weeks, :secrets) ||
      Lockup.from_config(:cookie_lifetime_in_weeks)
  end

  def lockup_codeword
    @lockup_codeword ||=
      ENV['LOCKUP_CODEWORD'] ||
      ENV['lockup_codeword'] ||
      Lockup.from_config(:codeword, :secrets) ||
      Lockup.from_config(:codeword)
  end

  def lockup_cookie_lifetime
    seconds = (cookie_lifetime.to_f * 1.week).to_i
    if seconds > 0
      seconds
    else
      5.years
    end
  end
end
