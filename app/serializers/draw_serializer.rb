class DrawSerializer < ActiveModel::Serializer
  attributes :name, :drawn_date

  def drawn_date 
    object.drawn_date.to_s
  end
end
