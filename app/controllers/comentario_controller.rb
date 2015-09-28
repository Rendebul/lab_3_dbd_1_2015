class ComentarioController < ApplicationController
	def destroy
	end
	
	def createUser
  		sql= "CALL COMENTAR_USUARIO(#{current_user.ID_USUARIO},#{params[:comentario][:ID_FOTO]},'"<<params[:comentario][:COMENTARIO]<<"'
  			);"
		logger.debug "HOLA CONCHETUMADRE"
		begin
			response = ActiveRecord::Base.connection.execute(sql)
			logger.debug 'Respuesta:'<<response.to_s
			redirect_to :back
		rescue Exception => e
			redirect_to :back
		end
	end
	
	def createAnnon
		sql= "CALL COMENTAR_ANONIMO(#{params[:comentario][:ID_FOTO]},'"<<params[:comentario][:COMENTARIO]<<"'
  			);"
		logger.debug "HOLA CONCHETUMADRE"
		begin
			response = ActiveRecord::Base.connection.execute(sql)
			redirect_to :back
		rescue Exception => e
			redirect_to :back
		end
	end
end