require 'rails_helper'

RSpec.describe Person, type: :model do
  subject { Person.new(name: "Joao", cpf:'123.456.798-00') }
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:cpf) }
    it { should validate_uniqueness_of(:cpf).case_insensitive }
  end
end
