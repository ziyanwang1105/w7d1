class ApplicationController < ActionController::Base

    helper_method :current_user, :login?

    def current_user
        @current_user ||= User.find_by(session_token: session[:session_token])
    end

    def login?
        !!current_user
    end

    def login(user)
        @current_user = user
        session[:session_token] = user.reset_session_token

    end

    def log_out
        current_user.reset_session_token
        session[:session_token] = nil
    end

    def require_logged_out
        redirect_to cats_url if logged_in?
    end
end
