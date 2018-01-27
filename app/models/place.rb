class Place < ApplicationRecord
  #because a place belongs to a specific user and a place has many comments
  belongs_to :user
  #place has many comments
  has_many :comments
  #place has many photos
  has_many :photos
  
  geocoded_by :address
  after_validation :geocode
  #Uses active_record validations to mean that each place has to have a name, address, and description
  validates :name, length: { minimum: 3 }, presence: true
  validates :address, presence: true
  validates :description, presence: true


  
end
