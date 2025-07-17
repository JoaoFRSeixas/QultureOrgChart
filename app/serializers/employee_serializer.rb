class EmployeeSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :picture, :company_id, :manager_id
end
