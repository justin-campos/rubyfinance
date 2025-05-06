class JwtService
  SECRET_KEY = '4645fae7d2b339ff7566fcab816165390d455bd365b8ec8366a33676100187f9fc3b25744f334c38a04d72780db180619c18327f44ba9173a47b0a9df08e1801'

  def self.encode_token(payload)
    payload[:exp] = 2.months.from_now.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode_token(token)
    decoded_token = JWT.decode(token, SECRET_KEY, true, { algorithm: 'HS256' })
    decoded_token.first
  rescue JWT::DecodeError => e
    # error
    nil
  end
end