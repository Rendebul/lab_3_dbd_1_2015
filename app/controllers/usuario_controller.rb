class UsuarioController < ApplicationController
	def new	

	end
	def index
		sql = "CALL MOSTRAR_USUARIOS(#{current_user.ADMIN})"
		response = ActiveRecord::Base.connection.select_all(sql)
		@usuarios = response.to_a
	end

	def registrar
		@usuario=Usuario.new
	end

	def search
		logger.debug 'HOLAAAAAAA!!'
		@parametros = params.deep_symbolize_keys
		@opcion = @parametros[:OPCION]
		sql = ''
		logger.debug 'Params: '<<params[:busqueda].inspect
		logger.debug 'Parametros:'<<@parametros.inspect
		logger.debug 'OPCION: '<<@opcion.to_s
		if @opcion == "0"
			sql = "CALL BUSCAR_USUARIO_NOMBRE('"<<params[:busqueda][:CAMPO]<<"');"
		elsif @opcion == "1"
			sql = "CALL BUSCAR_USUARIO_EMAIL('"<<params[:busqueda][:CAMPO]<<"');"
		else
			redirect_to '/'
		end
		if sql!=''
			begin
				response = ActiveRecord::Base.connection.select_all(sql)
				@usuarios = response.to_a 
				logger.debug ":D!! "<<@usuarios
			rescue 
			
			end
		end
	end	
	
	def create
		@usuario = Usuario.new(usuarios_params)
		if @usuario.valid?
			
		end
		@usuario.ADMIN = false; 
 		if params[:SEXO_USUARIO] == '0'
			@usuario.SEXO_USUARIO = 0
		end
		if params[:SEXO_USUARIO] == '1'
			@usuario.SEXO_USUARIO = 1
		end
		if params[:SEXO_USUARIO] == '2'
			@usuario.SEXO_USUARIO = 2
		end
  		sql= "CALL inscribir_usuario('"<<@usuario.NOMBRE_USUARIO.to_s<<"','"<<@usuario.APELLIDO_USUARIO.to_s<<"','"<<@usuario.PASSWORD_USUARIO.to_s<<"','"<<@usuario.EMAIL_USUARIO.to_s<<"',#{@usuario.ADMIN},#{@usuario.SEXO_USUARIO},'"<<@usuario.FECHA_NACIMIENTO.to_s<<"'
  			);"
		begin
			response = ActiveRecord::Base.connection.execute(sql)
			ActiveRecord::Base.clear_active_connections!
			@usuario = Usuario.where(email_usuario: params[:usuario][:EMAIL_USUARIO]).take
			login_in @usuario
			redirect_to '/cuenta/'
		rescue Exception => e
			render 'registrar'
		end
	end
	
	def show
		if logged_in?
			@usuario = Usuario.find(current_user.ID_USUARIO)
			render 'show'
		else
			redirect_to '/'
		end	
	end

	def mostrar
		@id_usuario = params[:id_usuario]
		@foto = Foto.where(ID_USUARIO: @id_usuario).last
		redirect_to '/'<<@id_usuario<<'/'<<@foto.ID_FOTO.to_s
	end

	def delete
		@id_usuario = params[:id_usuario]
		sql = "CALL ELIMINAR_USUARIO("<<@id_usuario<<");"
		response = ActiveRecord::Base.connection.execute(sql)
		redirect_to :back
	end

	def bloquear
		@id_usuario= params[:id_usuario]
		sql = "CALL BLOQUEAR_USUARIO("<<@id_usuario<<");"
		response = ActiveRecord::Base.connection.execute(sql)
		redirect_to :back
	end

	def desbloquear
		@id_usuario= params[:id_usuario]
		sql = "CALL DESBLOQUEAR_USUARIO("<<@id_usuario<<");"
		response = ActiveRecord::Base.connection.execute(sql)
		redirect_to :back
	end

	def cambiar_usuario
		@usuario = Usuario.new(usuarios_params)
		if @usuario.valid?
		end
 		@usuario.SEXO_USUARIO = true;
  		sql= "CALL ACTUALIZAR_DATOS_USUARIO('"<<@usuario.NOMBRE_USUARIO.to_s<<"','"<<@usuario.APELLIDO_USUARIO.to_s<<"','"<<@usuario.PASSWORD_USUARIO.to_s<<"','"<<@usuario.EMAIL_USUARIO.to_s<<"',#{@usuario.SEXO_USUARIO},'"<<@usuario.FECHA_NACIMIENTO.to_s<<"'
  			);"
		begin
			response = ActiveRecord::Base.connection.execute(sql)
			ActiveRecord::Base.clear_active_connections!
			@usuario = Usuario.where(email_usuario: params[:usuario][:EMAIL_USUARIO]).take
			login_in @usuario
			redirect_to '/cuenta/'
		rescue Exception => e
			render 'show'
		end
	end

	def gold
		if logged_in?
			@usuario = Usuario.find(current_user.ID_USUARIO)
			render 'gold'
		else
			redirect_to '/'
		end	
	end

	def edit
		if logged_in?
			@usuario = Usuario.find(current_user.ID_USUARIO)
			render 'editar'
		else
			redirect_to '/'
		end	
	end
	def auditoria
		if logged_in? and is_admin?
			@usuario = Usuario.find(current_user.ID_USUARIO)
			@auditoria = Auditoria.all
			render 'auditoria'
		else
			redirect_to '/'
		end	
	end
	def create_admin
		@usuario = Usuario.new(admin_params)
		if @usuario.valid?
			
		end
		if params[:ADMIN] == '1'
			@usuario.ADMIN = true;
		else
			@usuario.ADMIN = false;
		end
		if params[:SEXO_USUARIO] == '0'
			@usuario.SEXO_USUARIO = 0
		end
		if params[:SEXO_USUARIO] == '1'
			@usuario.SEXO_USUARIO = 1
		end
		if params[:SEXO_USUARIO] == '2'
			@usuario.SEXO_USUARIO = 2
		end
  		sql= "CALL inscribir_usuario('"<<@usuario.NOMBRE_USUARIO.to_s<<"','"<<@usuario.APELLIDO_USUARIO.to_s<<"','"<<@usuario.PASSWORD_USUARIO.to_s<<"','"<<@usuario.EMAIL_USUARIO.to_s<<"',#{@usuario.ADMIN},#{@usuario.SEXO_USUARIO},'"<<@usuario.FECHA_NACIMIENTO.to_s<<"'
  			);"
		begin
			response = ActiveRecord::Base.connection.execute(sql)
			ActiveRecord::Base.clear_active_connections!
			@usuario = Usuario.where(email_usuario: params[:usuario][:EMAIL_USUARIO]).take
			login_in @usuario
			redirect_to '/cuenta/'
		rescue Exception => e
			render 'show'
		end
	end
	def crear_cuenta
		if logged_in? and is_admin?
			@usuario = Usuario.find(current_user.ID_USUARIO)
			@auditoria = Auditoria.all
			render 'crear_cuenta'
		else
			redirect_to '/'
		end	
	end

	private
	  	def usuarios_params
	  		params.require(:usuario).permit(:NOMBRE_USUARIO, :APELLIDO_USUARIO, :EMAIL_USUARIO, :PASSWORD_USUARIO, :SEXO_USUARIO, :FECHA_NACIMIENTO)
	  	end
	  	def usuario
	  		params.require(:usuario)
	  	end
	  	def admin_params
			params.require(:usuario).permit(:NOMBRE_USUARIO, :APELLIDO_USUARIO, :EMAIL_USUARIO, :PASSWORD_USUARIO, :SEXO_USUARIO, :FECHA_NACIMIENTO, :ADMIN)
	  	end
end
