class Micliker < ActiveRecord::Base
  belongs_to  :user, foreign_key: "liker_id"
  belongs_to  :micropost, foreign_key: "micropost_id"
  validates   :liker_id, presence: true
  validates   :micropost_id, presence: true

end
