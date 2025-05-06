class ApplicationController < ActionController::API

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # allow_browser versions: :modern
  # protect_from_forgery with: :null_session

  SECRET_KEY = '4645fae7d2b339ff7566fcab816165390d455bd365b8ec8366a33676100187f9fc3b25744f334c38a04d72780db180619c18327f44ba9173a47b0a9df08e1801'

  def encode_token(payload)
    JwtService.encode_token(payload)
  end

  def decode_token(token)
    JwtService.decode_token(token)
  end

  def authorize_request
    header = request.headers['Authorization']
    token = header.split(' ').last if header
    decoded = decode_token(token)
    if decoded
      @current_user = User.find(decoded['user_id'])
    else
      render json: { error: 'Not Authorized' }, status: :unauthorized
    end
  end

end
