module SessionsHelper
	def login_in(user)
		session[:id_usuario] = user.ID_USUARIO
	end
	def current_user
  		@current_user ||= Usuario.find_by(ID_USUARIO: session[:id_usuario])
	end
	
	def logged_in?
    	return !current_user.nil?
  	end
  	
  	def log_out
  		session.delete(:id_usuario)
  		@current_user = nil
  	end

  	def is_admin?
  		if @current_user
	  		if @current_user.ADMIN
	  			return true
	  		else
	  			return false
	  		end
  		else
  			return false
  		end
  	end

  	def is_gold?
  		if @current_user
  			if @current_user.GOLD
  				return true
  			else
  				return false
  			end
  		else
  			return false
  		end
  	end
end
