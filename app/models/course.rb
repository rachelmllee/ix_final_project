class Course < ActiveRecord::Base
  belongs_to :user
  has_many :videos
  has_many :documents

  validates :name, :category, :grade, presence: true

  CATEGORIES = ['accounting', 'art', 'biology', 'business', 'chemistry', 'computer science', 
  	'drama', 'economics', 'english', 'geography', 'history', 'mathematics', 'music', 'physics']

  GRADES = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12']
end
