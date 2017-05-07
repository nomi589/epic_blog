class User < ActiveRecord::Base
  has_many :posts
  has_many :comments

  has_secure_password

  validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 15 }, format: { without: /\s/, message: "can't have spaces" }
  validates :email, presence: true, uniqueness: true

  before_save :generate_slug

  def generate_slug
    slug = self.username.downcase.parameterize

    if User.exists?(slug: slug)
      postfix = 1

      loop do
        slug = "#{slug}-#{postfix}"
        break unless User.exists?(slug: slug)
        postfix += 1
        slug = self.username.downcase.parameterize
      end
    end

    self.slug = slug
  end

  def to_param
    self.slug
  end
end