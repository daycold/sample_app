class Micropost < ActiveRecord::Base
  belongs_to :user
  has_many  :miclikers, dependent: :destroy
  has_many  :miccomments, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate  :picture_size
  # validates :users.liked_micropost_id, presence: false
  #

  def like_status(user)
    if !liking?(user)
      return "like"
    else
      return "unlike"
    end
  end
 
  def like(user)
    miclikers.create(liker_id: user.id)
  end

  def unlike(user)
    miclikers.find_by(liker_id: user.id).destroy
  end

  def liking?(user)
    !miclikers.find_by(liker_id: user.id).nil?
  end

  def Micropost.dolike(user,micropost)
    if micropost.liking?(user)
      micropost.unlike(user)
    else
      micropost.like(user)
    end
  end

  def comment_create(user,content)
    miccomments.create(commenter_id: user.id, content: content)
  end

  #评论时间也是主键，所以只能用 id 删除
  def comment_destroy(miccomment)
    miccomments.find_by(id: miccomment.id).destroy
  end

  private
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end

end
