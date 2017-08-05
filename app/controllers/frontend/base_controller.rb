module Frontend
  class BaseController < ApplicationController
    before_action :require_authentication
    helper_method :logged_in?, :current_user

    def logged_in?
      session[:user_id].present?
    end

    def current_user
      @current_user ||= User.find(session[:user_id]) if logged_in?
    end

    def login_user(user)
      @current_user = user
      reset_session
      session[:user_id] = user.id
    end

    def logout_user
      reset_session
    end

    def require_authentication
      return if logged_in?

      respond_to do |format|
        format.html { not_authenticated }
      end
    end

    def not_authenticated
      reset_session
      redirect_to new_sessions_path
    end
  end
end
