module Lockup
  class ApplicationController < ActionController::Base
    skip_before_filter :check_for_lockup
    
    layout "lockup"
    
    def unlock
      if params[:lockup_codeword].present?
        @codeword = params[:lockup_codeword].to_s.downcase
        @return_to = params[:return_to]
        if @codeword == ENV["LOCKUP_CODEWORD"].to_s.downcase
          set_cookie
          run_redirect
        end
      end

      if request.post?
        @codeword = params[:lockup][:codeword].to_s.downcase
        @return_to = params[:lockup][:return_to]
        if @codeword == ENV["LOCKUP_CODEWORD"].to_s.downcase
          set_cookie
          run_redirect
        else
          @wrong = true
        end
      end
    end
    
    private
    
    def set_cookie
      cookies[:lockup] = { :value => @codeword.to_s.downcase, :expires => (Time.now + 5.years) }
    end
    
    def run_redirect
      if @return_to.present?
        redirect_to "#{@return_to}"
      else
        redirect_to '/'
      end
    end

  end
end
