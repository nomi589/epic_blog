class Post < ActiveRecord::Base
  belongs_to :author, foreign_key: 'user_id', class_name: 'User'

  validates :title, presence: true, length: { minimum: 3, maximum: 30 }
  validates :body, presence: true
end