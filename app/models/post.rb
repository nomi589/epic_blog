class Post < ActiveRecord::Base
  belongs_to :author, foreign_key: 'user_id', class_name: 'User'
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories

  validates :title, presence: true, length: { minimum: 3, maximum: 30 }
  validates :body, presence: true

  before_save :generate_slug

  def generate_slug
    slug = self.title.downcase.parameterize

    if Post.exists?(slug: slug)
      postfix = 1

      loop do
        slug = "#{slug}-#{postfix}"
        break unless Post.exists?(slug: slug)
        postfix += 1
        slug = self.title.downcase.parameterize
      end
    end

    self.slug = slug
  end

  def to_param
    self.slug
  end
end