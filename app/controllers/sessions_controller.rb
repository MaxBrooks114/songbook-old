class SessionsController < ApplicationController

  def new

  end

  def create
    if auth
    	@user = User.find_or_create_from_auth_hash(auth)
    	log_in(@user)
    	redirect_to @user
    elsif
      @user = User.find_by(username: params[:username].downcase)
      if @user && @user.authenticate(params[:password])
        log_in(@user)
        redirect_to @user
      end
    else
      flash[:notice] = 'Invalid email/password combination'
      redirect_to '/login'
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
