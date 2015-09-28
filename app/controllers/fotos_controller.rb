class FotosController < ApplicationController
	def index
		sql= "CALL MOSTRAR_FOTOS_USUARIO('"<<current_user.ID_USUARIO.to_s<<"'
  			);"
		begin
			result = ActiveRecord::Base.connection.select_all(sql, :as => :hash)
			ActiveRecord::Base.clear_active_connections!
			@fotos = result.to_a
		rescue Exception => e
			logger.debug 'error'
			render 'index'
		end
	end

	def new
		
	end
	def indexpublic
		id_usuario = params[:id_usuario]
		sql= "CALL MOSTRAR_FOTOS_USUARIO('"<<id_usuario.to_s<<"'
  			);"
		begin
			result = ActiveRecord::Base.connection.select_all(sql, :as => :hash)
			ActiveRecord::Base.clear_active_connections!
			@fotos = result.to_a
			render 'indexpublic'
		rescue Exception => e
			logger.debug 'error'
			redirect_to :back
		end
	end

	def show
		logger.debug "Parametro:"<<params.inspect.to_s
		id_foto = params[:id_foto]
		id_usuario = params[:id_usuario]
		@foto = Foto.find(id_foto)
		sql = "CALL MOSTRAR_COMENTARIOS("<<@foto.ID_FOTO.to_s<<");"
		begin
			result = ActiveRecord::Base.connection.select_all(sql, :as => :hash)
			ActiveRecord::Base.clear_active_connections!
			sql2 = "CALL PROMEDIO_CALIFICACION("<<id_foto<<");"
			result2 = ActiveRecord::Base.connection.select_all(sql2, :as => :hash)
			ActiveRecord::Base.clear_active_connections!
			@calificacion = result2.to_a
			logger.debug "CALIFICACION:"<<@calificacion.inspect
			@comentarios = result.to_a
			logger.debug "SQL3"
			sql3 = "CALL MOSTRAR_FOTOS_AMIGOS("<<id_usuario<<"
				);"
			logger.debug "RESULT3"
			result3 = ActiveRecord::Base.connection.select_all(sql3, :as => :hash,:limit=>5).first(5)
			logger.debug "FOTOS AMIGOS"
			@fotos_amigos = result3.to_a
			logger.debug "f am:"<<@fotos_amigos.inspect
		rescue Exception => e
			logger.debug 'error :('
		end
	end

	def create
		logger.debug "Parametros:"<<params.inspect
		@fotos = params[:foto];
		@archivo = @fotos[:FOTO]
		@extension = File.extname(@archivo.original_filename).to_s
		@nombrebase = File.basename(@archivo.original_filename,".*")
		@nombreNuevo = current_user.ID_USUARIO.to_s+"_"+@nombrebase+@extension
		logger.debug "Extension:"<<@extension
		if['.jpg','.bmp','.png','.JPG','.BMP','.PNG'].include?(@extension)
			logger.debug "Archivo valido"
			File.open(Rails.root.join('app','assets','images', @archivo.original_filename), 'wb') do |file|
				file.write(@archivo.read)
				@uniq_path = Rails.root.join('app','assets','images',@nombreNuevo)
				File.rename(file, @uniq_path)
			end
			sql = "CALL SUBIR_FOTO("<<current_user.ID_USUARIO.to_s<<",'"<<@nombreNuevo<<"','"<<@fotos[:TITULO]<<"','"<<@fotos[:DESCRIPCION]<<"'
				);"
			begin
				result = ActiveRecord::Base.connection.execute(sql)
				redirect_to '/fotos'
			rescue Exception => e
				render 'index'
			end
		else
			logger.debug "Archivo Invalido"
			render 'new'
		end
	end
	
	def delete
	 	@id_foto = params[:id_foto]
		sql = "CALL ELIMINAR_FOTO("<<@id_foto<<");"
		response = ActiveRecord::Base.connection.execute(sql)
		redirect_to :back
	end
end
