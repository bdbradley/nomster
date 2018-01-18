class Comment < ApplicationRecord
#because a comment belongs specifically to one user and one place
#comments point to user and place, other tables in the db
  belongs_to :user
  belongs_to :place
end
