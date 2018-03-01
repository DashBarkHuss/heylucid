module UsersHelper 

	def current_user
		User.find(session[:user_id]) if session[:user_id] 
	end

 	def logged_in?
 		current_user != nil && session[:user_id] != nil 
 	end


 	def fake_user
 		User.first
 	end
end
