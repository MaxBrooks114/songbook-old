class SessionsController < ApplicationController

  def new

  end

  def create
    @user = User.find_by(username: params[:username].downcase)
    if @user && @user.authenticate(params[:password])
      log_in(@user)
      redirect_to @user
    else
      flash[:notice] = 'Invalid email/password combination'
      redirect_to '/login'
    end
  end

  def google_create
    @user = User.find_or_create_from_auth_hash(auth)
    log_in(@user)
    redirect_to @user
  end

  def spotify_create
    @user =  current_user 
    spotify = SpotifyService.new
    session[:token] = spotify.authenticate!(ENV['FOURSQUARE_CLIENT_ID'], ENV['FOURSQUARE_SECRET'], params[:code])
    redirect_to @user
  end


  def auth
    request.env['omniauth.auth']
  end

  def destroy
    session.delete :user_id
    redirect_to root_path
  end


end
