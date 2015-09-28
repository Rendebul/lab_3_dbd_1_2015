Rails.application.routes.draw do

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'
  
  #Usuario:
  get '/registrar' => 'usuario#registrar'
  post '/registrar' => 'usuario#create'
  get '/cuenta/' => 'usuario#show'
  post '/busqueda'=> 'usuario#search'
  get '/usuario/:id_usuario'=>'usuario#mostrar'
  get '/transferir/'=> 'usuario#gold'
  get '/editar' => 'usuario#edit'
  patch '/editar' => 'usuario#cambiar_usuario'
  get '/cuentas'=>'usuario#index'
  get '/bloquear_usuario/:id_usuario'=>'usuario#bloquear'
  get '/desbloquear_usuario/:id_usuario'=>'usuario#desbloquear'
  get '/eliminar_usuario/:id_usuario'=>'usuario#delete'
  get '/crear_cuenta' => 'usuario#crear_cuenta'
  patch '/crear_cuenta' => 'usuario#create_admin'
  
  #Auditoria
  get '/auditoria' => 'usuario#auditoria'

  #Sesiones
  get '/iniciar' => 'sessions#new'  
  post '/iniciar' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  #Amistad
  get '/agregar_amigo/:id_usuario'=>'amistad#create'
  get '/amigos'=>'amistad#index'
  get '/eliminar_amigo/:id_amigo'=>'amistad#destroy'
  
  #Fotos
  get '/fotos/'=>'fotos#index'
  get '/subir_foto' =>'fotos#new'
  post '/subir' => 'fotos#create'
  get '/eliminar_foto/:id_foto'=>'fotos#delete'
  get '/:id_usuario/fotos'=>'fotos#indexpublic'
  get '/:id_usuario/:id_foto'=>'fotos#show'

  #Comentarios
  post '/comentario_usuario'=>'comentario#createUser'
  post '/comentario_anon'=>'comentario#createAnnon'


  #Calificacion
  post '/calificar'=>'calificacion#create'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
