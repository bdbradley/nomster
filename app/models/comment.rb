class Comment < ApplicationRecord
#because a comment belongs specifically to one user and one place
#comments point to user and place, other tables in the db
  belongs_to :user
  belongs_to :place
  #an active record callback
  after_create :send_comment_email

    RATINGS = {
    'one star': '1_star',
    'two stars': '2_stars',
    'three stars': '3_stars',
    'four stars': '4_stars',
    'five stars': '5_stars'
  }
#Calls this method for all comments
  def humanized_rating
    RATINGS.invert[self.rating]
  end

#Use the after_create callback to send an email about comment after user comments
  def send_comment_email
    #Self uses the current comment this method is called on
    NotificationMailer.comment_added(self).deliver_now
  end
end
