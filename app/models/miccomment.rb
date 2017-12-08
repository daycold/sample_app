class Miccomment < ActiveRecord::Base
  belongs_to :micropost
  belongs_to :user, foreign_key: "commenter_id"
  belongs_to :to_comment, class_name: "Miccomment", foreign_key: "comment_to"
  has_many   :form_comments, class_name: "Miccoment", dependent: :destroy
  validates  :micropost_id, presence: true
  validates  :commenter_id,   presence: true
  validates  :content,      presence: true
end
