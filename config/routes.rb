Rails.application.routes.draw do
  resources :users  # Esto agregará el endpoint `GET /users/:id`

  get '/profile', to: 'users#show'

  mount Rswag::Ui::Engine => 'api-docs'
  mount Rswag::Api::Engine => 'api-docs'

  # users
  post '/signup', to: 'users#signup'
  post 'login', to: 'users#login'

  # categories
  resources :categories, only: [:index, :show, :create]

  # Ruta para obtener el total de ingresos de un usuario por mes
  get 'transactions/total_ingresos/:mes', to: 'transactions#total_ingresos'

  # Ruta para obtener el total de gasto de un usuario por mes
  get 'transactions/total_gastos/:mes', to: 'transactions#total_gastos'

  # Ruta para obtener el total de gastos por categoría en un mes
  get 'transactions/gastos_por_categoria/:mes', to: 'transactions#gastos_por_categoria'

  # Ruta para obtener el total de transaciones por mes de un usuario
  get '/transactions/usuario/:mes', to: 'transactions#transactions_por_usuario'

  # ahorro
  resources :saving_goals, only: [:create, :index]

  # transactions
  resources :transactions, only: [:index, :show, :create, :update, :destroy]

  #  Ruta para calcular el porcentaje faltante
  get 'saving_goals/percentage_left', to: 'saving_goals#percentage_left'

  # Mes
  get 'months/:id', to: 'months#show'  # Ruta para buscar por ID

  get '/transactions/pie_chart/:month_id', to: 'transactions#pie_chart_data'
  resources :months, only: [:index, :show]  # Define las rutas para 'index' y 'show'


end


