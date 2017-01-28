class Expense < ApplicationRecord
  belongs_to :user
  self.per_page = 50
end
