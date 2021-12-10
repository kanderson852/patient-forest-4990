class Actor < ApplicationRecord
  has_many :actor_movies
  has_many :movies, through: :actor_movies

  validates_presence_of :name
  validates_presence_of :age

  def self.average_age
    average(:age).round
  end

  def self.order_by_age
    order(age: :asc)
  end
end
