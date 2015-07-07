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
      else # Direct user to sign up page. 
        user = User.new # , notice: "Signing up with facebook, please enter a password!"
      end
    end

    # def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    #   data = access_token.extra.raw_info
    #   if user = User.where(:email => data.email).first
    #     user
    #   else # Create a user with a stub password. 
    #     User.create!(:email => data.email,
    #                  :name => data.name,
    #                  # :image => data.image,
    #                  :password => Devise.friendly_token[0,20])
    #   end
    # end

    def self.new_with_session(params, session)
        super.tap do |user|
          if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
            user.email = data["email"]
            user.name = data["name"]
            # user.image = data["image"]
          end
        end
      end

end
