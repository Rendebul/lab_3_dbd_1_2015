class AmistadController < ApplicationController
	def new

	end
	def create
		@id_usuario = current_user.ID_USUARIO.to_s
		@id_amigo = params[:id_usuario]
		sql = "CALL AGREGAR_AMISTAD("<<@id_usuario<<","<<@id_amigo<<");"
		response2 = ActiveRecord::Base.connection.execute(sql)
		redirect_to '/amigos'
	end
	def destroy
		@id_usuario = current_user.ID_USUARIO.to_s
		@id_amigo = params[:id_amigo]
		sql = "CALL ELIMINAR_AMISTAD("<<@id_usuario<<","<<@id_amigo<<");"
		response2 = ActiveRecord::Base.connection.select_all(sql)
		redirect_to :back

	end
	def index
		@id_usuario = current_user.ID_USUARIO.to_s
		sql = "CALL MOSTRAR_AMIGOS("<<@id_usuario<<");"
		response2 = ActiveRecord::Base.connection.select_all(sql)
		@amigos = response2.to_a

	end
end
