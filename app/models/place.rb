class Place < ApplicationRecord
  belongs_to :user
  #Means that each place has to have a name
  validates :name, presence: true

end
