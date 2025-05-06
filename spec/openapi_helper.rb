# spec/openapi_helper.rb
RSpec.configure do |config|
  config.openapi_root = Rails.root.to_s + '/swagger_docs'  # Misma ruta que rswag_api.rb
  config.openapi_specs = {
    'v1/swagger.json' => {
      openapi: '3.0.1',
      info: { title: 'API V1', version: 'v1' }
    }
  }
end