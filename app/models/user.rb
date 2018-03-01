class User < ApplicationRecord
	has_many :reality_checks


	def authenticate
	  	if self.id == params[:user_id] || self.admin == true
	  		return true
	  	else
	  		render file: Rails.public_path.join("404.html"), layout: true # /public/templates/home.html
	  	end
  	end
end