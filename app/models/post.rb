class Post < ApplicationRecord
  validates :days, {presence: true}
  validates :hours, {presence: true}
  validates :content, {presence: true, length: {maximum: 140}}
  validates :user_id, {presence: true}
end
