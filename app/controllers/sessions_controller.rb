class SessionsController < ApplicationController
	def new
		render 'login'
	end
	def create
		@usuario = Usuario.where(email_usuario: params[:session][:EMAIL_USUARIO]).take
		
		sql = "CALL REVISAR_ESTADO_GOLD(#{@usuario.ID_USUARIO});"
		response = ActiveRecord::Base.connection.execute(sql)
		ActiveRecord::Base.clear_active_connections!
		sql = "CALL REVISAR_BLOQUEO(#{@usuario.ID_USUARIO});"
		response2 = ActiveRecord::Base.connection.execute(sql)
		ActiveRecord::Base.clear_active_connections!

		if @usuario && @usuario.authenticate(params[:session][:PASSWORD_USUARIO]) && !(@usuario.BLOQUEADO) && @usuario.ACTIVO_USUARIO
			login_in @usuario
			redirect_to '/cuenta/'
		else
			flash[:danger] = 'Combinacion de email/contraseña incorrecta!'
			render 'login'
		end
	end
	def destroy
		log_out
		redirect_to '/'
	end
end
