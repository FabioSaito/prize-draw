class DrawRandomSample
  private_class_method :new

  def self.call
    winner = Person.available.random
    winner.update!(drawn: :true, drawn_date: Time.current)
    winner
  end
end
