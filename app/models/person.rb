class Person < ApplicationRecord
  validates :name, presence: true
  validates :cpf, presence: true, uniqueness: true

  scope :winners, -> { where( drawn: :true) }
  scope :available, -> { where( drawn: :false,  deleted: :false) }
  scope :random, -> { offset(rand(Person.available.count)).first }
end
