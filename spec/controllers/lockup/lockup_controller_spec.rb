require 'spec_helper'

describe Lockup::LockupController do
  describe 'a malicious user posts invalid data' do
    it 'does not fail' do
      post 'unlock', {use_route: :lockup, foo: 'bar'}
    end
  end
  describe 'a malicious user requests a format that is not HTML' do
    it 'does not fail' do
      get 'unlock', use_route: :lockup, format: 'text'
    end
  end
end
