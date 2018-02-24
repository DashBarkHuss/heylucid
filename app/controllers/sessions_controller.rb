class SessionsController < ApplicationController

	def new
		@user = User.new
		render 'home/login_form'

	end

	def create
		session[:user_id] = current_user.id
		render 'show'
	end

	def destroy
		session.destroy
		redirect_to login_path
	end
end
