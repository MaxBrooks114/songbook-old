# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :require_login, only: %i[edit update destroy]

  def index
    redirect_to '/'
    flash[:notice] = 'That account was created manually please sign in without google'
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.username.downcase!
    if @user.save
      log_in(@user)
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    if @user == current_user
      render 'show'
    else
      session.delete :user_id
      redirect_to '/'
      flash[:notice] = 'You are not logged in'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render 'edit'
   end
  end

  def destroy
    @user = User.find(params[:id])
    session.delete :user_id
    @user.destroy
    redirect_to root_path
  end

  def stats
    @user = current_user
    respond_to do |f|
      f.html { render :stats, layout: false }
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation)
  end
end
