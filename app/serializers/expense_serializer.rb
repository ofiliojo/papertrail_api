class ExpenseSerializer < ActiveModel::Serializer
  attributes :id, :amount, :description, :created_at, :updated_at
  belongs_to :user
end
