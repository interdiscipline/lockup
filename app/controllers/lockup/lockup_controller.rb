module Lockup
  class LockupController < Lockup::ApplicationController
    CRAWLER_REGEX = /crawl|googlebot|slurp|spider|bingbot|tracker|click|parser|spider/

    if self.respond_to?(:skip_before_action)
      skip_before_action :check_for_lockup
    else
      skip_before_filter :check_for_lockup
    end

    def unlock
      if params[:lockup_codeword].present?
        user_agent = request.env['HTTP_USER_AGENT'].presence
        if user_agent && user_agent.downcase.match(CRAWLER_REGEX)
          head :ok
          return
        end

        @codeword = params[:lockup_codeword].to_s.downcase
        @return_to = params[:return_to]
        if @codeword == lockup_codeword.to_s.downcase
          set_cookie
          run_redirect
        end
      elsif request.post?
        if params[:lockup].present? && params[:lockup].respond_to?(:'[]')
          @codeword = params[:lockup][:codeword].to_s.downcase
          @return_to = params[:lockup][:return_to]
          if @codeword == lockup_codeword.to_s.downcase
            set_cookie
            run_redirect
          else
            @wrong = true
          end
        else
          head :ok
        end
      else
        respond_to :html
      end
    end

    private

    def set_cookie
      cookies[:lockup] = { value: @codeword.to_s.downcase, expires: (Time.now + lockup_cookie_lifetime) }
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
