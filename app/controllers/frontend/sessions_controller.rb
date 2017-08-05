module Frontend
  class SessionsController < BaseController
    skip_before_action :require_authentication
    layout 'sessions'

    def new
      @resource = Forms::LogIn.new(email: params[:email])
    end

    def create
      @resource = User.find_by(email: params[:forms_log_in][:email])
      if @resource.valid_password?(params[:forms_log_in][:password])
        login_user(@resource)
        redirect_to walks_path
      else
        redirect_to new_sessions_path, email: params[:forms_log_in][:email]
      end
    end

    def destroy
      logout_user
      redirect_to new_sessions_path
    end
  end
end
