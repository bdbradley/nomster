class Place < ApplicationRecord
  belongs_to :user
  geocoded_by :address
  after_validation :geocode
  #Uses active_record validations to mean that each place has to have a name, address, and description
  validates :name, length: { minimum: 3 }, presence: true
  validates :address, presence: true
  validates :description, presence: true


  
end
