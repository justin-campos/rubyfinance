class Category < ApplicationRecord
  self.primary_key = 'category_id'
  self.table_name = 'categories'
  has_many :transactions
end

