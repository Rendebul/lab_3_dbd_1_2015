class Usuario < ActiveRecord::Base



	validates :PASSWORD_USUARIO, presence: {:message => "no puede estar vacio"}, length: {minimum: 6, :message => "debe tener al menos 6 caracteres"}
	validates :EMAIL_USUARIO, presence: {:message => "no puede estar vacio"}, :uniqueness => {:message => "ya esta asociado a una cuenta"}
	validates :FECHA_NACIMIENTO, presence: {:message => "es obligatoria"}
	validates :NOMBRE_USUARIO, presence: {:message => "no puede estar vacio"}
	validates :APELLIDO_USUARIO, presence: {:message => "no puede estar vacio"}

	self.table_name = "USUARIO"

	
	def create()
		#execute_procedure("inscribir_usuario",:nombre_usuario,:apellido_usuario,:password_usuario,:email_usuario,:admin, :sexo,:fecha_nacimiento)
	end
	def authenticate(password)
		if ((self.PASSWORD_USUARIO).eql? password)
			return true
		else
			return false
		end
	end
end
