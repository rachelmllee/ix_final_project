class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # :role
  # student == 0
  # tutor == 1
  # admin == 2
  enum role: [:student, :tutor, :admin]
  has_many :users, dependent: :destroy

  acts_as_messageable

  def mailboxer_email(object)
    email
  end
end
