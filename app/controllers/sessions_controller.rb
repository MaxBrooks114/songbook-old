class SessionsController < ApplicationController

  def new

  end

  def create
    if request.env["omniauth.auth"]
    	@user = User.find_or_create_from_auth_hash(request.env["omniauth.auth"])
    	log_in(@user)
    	redirect_to @user
    elsif
      @user = User.find_by(username: params[:username])
      if @user && @user.authenticate(params[:password])
        log_in(@user)
        redirect_to @user
      end
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end


  def auth
    request.env['omniauth.auth']
  end

  def destroy
    session.delete :user_id
    redirect_to root_path
  end


end
