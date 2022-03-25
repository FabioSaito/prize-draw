class DrawSerializer < ActiveModel::Serializer
  attributes :winner, :created_at

  def created_at 
    object.created_at.to_s
  end
end
