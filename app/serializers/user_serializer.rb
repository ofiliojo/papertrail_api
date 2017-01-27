class UserSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :email, :admin, :created_at
end
