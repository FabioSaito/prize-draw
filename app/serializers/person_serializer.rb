class PersonSerializer < ActiveModel::Serializer
  attributes :id, :name, :cpf, :born_on
end
