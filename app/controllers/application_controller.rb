class ApplicationController < ActionController::Base
    helper_method :current_user




    def home

    end



  private

    def require_login
      unless logged_in?
        flash[:error] = "You must be logged in to access this section"
        redirect_to '/'
      end
    end

    def log_in(id)
      session[:user_id] = @user.id
    end

    def logged_in?
      session[:user_id]
    end


    def current_user
       @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def set_user
     @user = current_user
    end

end
