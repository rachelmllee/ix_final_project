class User < ActiveRecord::Base

    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable, 
           :omniauthable, :omniauth_providers => [:facebook]

    enum role: [:student, :tutor, :admin]

    has_many :courses

    acts_as_messageable

    def mailboxer_email(object)
      email
    end

    def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
      data = access_token.extra.raw_info
      if user = User.where(:email => data.email).first
        user
      else
        User.create!(:email => data.email, :password => Devise.friendly_token[0,20])
      end
    end

end
