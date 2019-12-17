class User < ApplicationRecord
  validates :name, {presence: true, uniqueness: true}
  validates :password, {presence: true}

  def posts
    return Post.where(user_id: self.id).order(created_at: :desc)
  end
end
