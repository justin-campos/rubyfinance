class User < ApplicationRecord
    has_secure_password

    has_many :saving_goals, dependent: :destroy
    validates :email, presence: true, uniqueness: true
    self.table_name = 'users'
    has_many :transactions
end