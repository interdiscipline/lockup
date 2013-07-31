require "lockup/engine"

module Lockup
  module InstanceMethods

    def check_for_lockup
      if ENV["LOCKUP_CODEWORD"].present?
        if cookies[:lockup].present?
          if cookies[:lockup] == ENV["LOCKUP_CODEWORD"].to_s.downcase
            return
          else
            redirect_to :controller => '/lockup', :action => 'unlock', :return_to => request.fullpath.split('?lockup_codeword')[0], :lockup_codeword => params[:lockup_codeword]
          end
        else
          redirect_to :controller => '/lockup', :action => 'unlock', :return_to => request.fullpath.split('?lockup_codeword')[0], :lockup_codeword => params[:lockup_codeword]
        end
      end
    end
  end
  module ClassMethods
  end
end
