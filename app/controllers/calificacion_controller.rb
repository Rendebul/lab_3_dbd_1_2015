class CalificacionController < ApplicationController
	def new

	end
	def create
		@id_usuario = current_user.ID_USUARIO.to_s
		@id_foto = params[:calificar][:ID_FOTO]
		@calificacion = params[:NOTA]
		sql = "CALL CALIFICAR("<<@id_usuario<<","<<@id_foto<<","<<@calificacion<<");"
		response2 = ActiveRecord::Base.connection.execute(sql)
		redirect_to :back
	end
	def destroy
			
	end
	def index

	end
end
