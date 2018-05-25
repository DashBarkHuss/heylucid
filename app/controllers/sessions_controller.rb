class SessionsController < ApplicationController
  def new
    @user = User.new
    render 'home/_login_form'
  end

  def create
    @user = User.find_by(email: params[:email], password: params[:password])

    if @user != nil
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
      flash[:notice] = 'You have successfully logged in'
    else
      flash[:error] = 'error logging in'
      redirect_to login_path
    end
  end

  def destroy
    session.destroy
    redirect_to login_path
    flash[:notice] = 'Logged out'
  end
end
