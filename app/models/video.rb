class Video < ActiveRecord::Base
  belongs_to :course

  validates :title, :url, presence: true
end
