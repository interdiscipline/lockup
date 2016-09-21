require 'spec_helper'

describe Lockup::LockupController do
  routes { Lockup::Engine.routes }

  describe 'a malicious user posts invalid data' do
    it 'does not fail' do
      post 'unlock', params: {foo: 'bar'}
    end
  end
  describe 'a malicious user requests a format that is not HTML' do
    it 'does not fail' do
      get 'unlock', format: 'text'
    end
  end
end
