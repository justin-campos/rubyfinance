# spec/rails_helper.rb

require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'rswag/specs'  # Debe ir después de require 'rspec/rails'

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

RSpec.configure do |config|
  # Configuración básica de RSpec (actualizada para Rails 7.1+)
  config.fixture_paths = [Rails.root.join('spec/fixtures')]  # ¡Ahora es un array!
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  # Configuración actualizada de RSwag (OpenAPI 3.0+)
  config.openapi_specs = {  # Reemplaza swagger_docs
                            'v1/swagger.json' => {  # Cambiado a .json (recomendado)
                                                    openapi: '3.0.1',
                                                    info: {
                                                      title: 'API Documentation',
                                                      version: 'v1',
                                                      description: 'Documentación generada con RSwag'
                                                    },
                                                    servers: [
                                                      { url: 'http://{defaultHost}', variables: { defaultHost: { default: 'localhost:3000' } } }
                                                    ],
                                                    components: {
                                                      securitySchemes: {
                                                        bearer_auth: {
                                                          type: :http,
                                                          scheme: :bearer
                                                        }
                                                      }
                                                    }
                            }
  }

  config.openapi_format = :json  # Reemplaza swagger_format

  # Opcional: Ejemplos de respuestas automáticas
  config.after(:each, type: :request) do |example|
    next unless example.metadata[:openapi]  # Cambiado de :swagger a :openapi

    example.metadata[:response][:content] = {
      'application/json' => {
        example: JSON.parse(response.body, symbolize_names: true)
      }
    }
  end
end

Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }