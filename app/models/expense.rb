class Expense < ApplicationRecord
  belongs_to :user

  validates_presence_of :amount, :description
end
