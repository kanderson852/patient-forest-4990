class Studio < ApplicationRecord
  has_many :movies

  validates_presence_of :name
  validates_presence_of :location
end
