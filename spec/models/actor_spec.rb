require 'rails_helper'

RSpec.describe Actor, type: :model do
  before do
    @actor2 = Actor.create!(name:"Josh", age: 29)
    @actor1 = Actor.create!(name:"Kara", age: 23)
    @actor3 = Actor.create!(name:"Jana", age: 54)
  end
  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :age}
  end
  describe 'relationships' do
    it { should have_many(:movies).through(:actor_movies) }
  end

  it '#average_age' do
    expect(Actor.average_age).to eq(35)
  end 
end
