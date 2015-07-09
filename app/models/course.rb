class Course < ActiveRecord::Base
  belongs_to :user
  has_many :videos
  has_many :documents

  validates :name, :category, :grade, presence: true

  CATEGORIES = ['accounting', 'art', 'biology', 'business', 'chemistry', 'computer science', 
  	'drama', 'economics', 'english', 'geography', 'history', 'mathematics', 'music', 'physics']

  GRADES = ['8', '9', '10', '11', '12']

  def self.search(query)
	where("name LIKE ? or category LIKE ?", "%#{query}%", "%#{query}%")
  end
end
