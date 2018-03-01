class SessionsController < ApplicationController

	def new
		@user = User.new
		render 'home/_login_form'

	end

	def create
		session[:user_id] = current_user.id
		redirect_to user_path(current_user.id)
		flash[:notice] = 'You have successfully logged in'
	end

	def destroy
		session.destroy
		redirect_to login_path
		flash[:notice] = 'Logged out'
	end
end
