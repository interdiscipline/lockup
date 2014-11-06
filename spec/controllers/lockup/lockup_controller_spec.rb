require 'spec_helper'

describe Lockup::LockupController do
  describe 'a malicious user posts invalid data' do
    it 'does not fail' do
      post 'unlock', {use_route: :lockup, foo: 'bar'}
    end
  end
end
