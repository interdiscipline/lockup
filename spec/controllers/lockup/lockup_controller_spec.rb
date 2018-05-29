require 'spec_helper'


describe Lockup::LockupController do
  routes { Lockup::Engine.routes }

  describe 'a malicious user posts invalid data' do
    it 'does not fail' do
      post 'unlock', params: {foo: 'bar'}
    end
  end
  describe 'a malicious user requests a format that is not HTML' do
    it 'throws an unknown format error' do
      lambda { get 'unlock', format: 'text' }.should raise_error(ActionController::UnknownFormat)
    end
  end

  describe "#cookie_lifetime" do
    context "COOKIE_LIFETIME_IN_SECONDS is set to an integer" do
      before { ENV['COOKIE_LIFETIME_IN_SECONDS'] = '123' }

      it "returns the integer" do
        controller.send(:cookie_lifetime).should eq(123)
      end
    end

    context "COOKIE_LIFETIME_IN_SECONDS is not a valid integer" do
      before { ENV['COOKIE_LIFETIME_IN_SECONDS'] = 'invalid value' }

      it "returns the integer" do
        controller.send(:cookie_lifetime).should eq(5.years)
      end
    end

    context "COOKIE_LIFETIME_IN_SECONDS is not set" do
      before { ENV.delete('COOKIE_LIFETIME_IN_SECONDS') }

      it "returns the integer" do
        controller.send(:cookie_lifetime).should eq(5.years)
      end
    end
  end
end
