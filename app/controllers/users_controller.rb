class UsersController < ApplicationController
  # Endpoint para registro
  def signup
    @user = User.new(user_params)
    if @user.save
      token = JwtService.encode_token({ user_id: @user.id, name: @user.name })
      render json: { user: @user, token: token }, status: :created
    else
      render json: { error: 'Invalid user data' }, status: :unprocessable_entity
    end
  end

  # Endpoint para login
  def login
    @user = User.find_by(email: login_params[:email])
    if @user && @user.authenticate(login_params[:password])
      token = JwtService.encode_token({ user_id: @user.id, name: @user.name })
      render json: {
        user: @user.slice(:id, :name, :email),  # Solo seleccionamos las columnas que necesitamos
        token: token
      }
    else
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end

  # Endpoint para obtener los datos del usuario autenticado
  def show
    # Extraemos el token del encabezado Authorization
    token = request.headers['Authorization'].to_s.split(' ').last

    # Decodificamos el token
    decoded_token = JwtService.decode_token(token)

    if decoded_token.nil?
      return render json: { error: 'Invalid or missing token' }, status: :unauthorized
    end

    Rails.logger.debug "Decoded Token: #{decoded_token}"

    # Extraemos el user_id del token
    user_id = decoded_token['user_id']

    # Buscamos al usuario con el user_id
    @user = User.find_by(id: user_id)

    if @user
      render json: @user.slice(:id, :name, :email), status: :ok
    else
      render json: { error: 'User not found' }, status: :not_found
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
  def login_params
    params.require(:user).permit(:email, :password)
  end


end
