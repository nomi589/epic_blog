class Category < ActiveRecord::Base
  has_many :post_categories
  has_many :posts, through: :post_categories

  validates :name, length: { minimum: 3, maximum: 15 }, presence: true, uniqueness: true

  before_save :sanitize_name

  def sanitize_name
    self.name = self.name.downcase.parameterize.gsub(/\d/, '')
  end

  def to_param
    self.name
  end
end