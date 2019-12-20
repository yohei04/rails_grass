class User < ApplicationRecord
  has_secure_password
  
  validates :name, {presence: true, uniqueness: true}

  def posts
    return Post.where(user_id: self.id).order(created_at: :desc)
  end
end
