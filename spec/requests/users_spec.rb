require 'rails_helper'

describe 'Users API' do
  # Endpoints para /users
  path '/users' do
    # GET /users
    get 'Retrieves all users' do
      tags 'Users'
      produces 'application/json'

      response '200', 'users found' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   name: { type: :string },
                   email: { type: :string }
                 },
                 required: ['id', 'name', 'email']
               }

        run_test!
      end
    end

    # POST /users
    post 'Creates a new user' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          email: { type: :string },
          password: { type: :string }
        },
        required: ['name', 'email', 'password']
      }

      response '201', 'user created' do
        let(:user) { { name: 'John Doe', email: 'john@example.com', password: '123456' } }
        run_test!
      end
    end
  end

  # Endpoints para /users/:id
  path '/users/{id}' do
    # GET /users/:id
    get 'Retrieves a specific user' do
      tags 'Users'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer, description: 'User ID'

      response '200', 'user found' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 email: { type: :string }
               },
               required: ['id', 'name', 'email']

        run_test!
      end
    end

    # PUT /users/:id
    put 'Updates a user' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :integer, description: 'User ID'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          email: { type: :string },
          password: { type: :string }
        },
        required: ['name', 'email']
      }

      response '200', 'user updated' do
        let(:id) { 1 }
        let(:user) { { name: 'Updated Name', email: 'updated@example.com', password: 'newpassword' } }
        run_test!
      end
    end

    # PATCH /users/:id
    patch 'Partially updates a user' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :integer, description: 'User ID'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          email: { type: :string }
        }
      }

      response '200', 'user partially updated' do
        let(:id) { 1 }
        let(:user) { { name: 'Partial Update Name' } }
        run_test!
      end
    end

    # DELETE /users/:id
    delete 'Deletes a user' do
      tags 'Users'
      parameter name: :id, in: :path, type: :integer, description: 'User ID'

      response '204', 'user deleted' do
        let(:id) { 1 }
        run_test!
      end
    end
  end
end