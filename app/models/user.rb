class User < ApplicationRecord

  # has_secure_password
  # Not needed, devise give us this :eye

            # has_secure_token

            # def invalidate_token
            #   update(token: nil)
            # end

            # def self.valid_login?(email, password)
            #   user = find_by(email: email)
            #   user if user && user.authenticate(password)
            # end
            # self.valid_long Check Slack from Kattya - 1st Find by email
            # 2nd User.validpassword 
  

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  after_create :send_welcome_email, :send_registration_mail

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook github]
  has_many :bookings
  

  def self.from_omniauth(auth)
    user = where(email: auth.info.email.downcase).first_or_create do |user|
      user.email = auth.info.email.downcase
      user.password = Devise.friendly_token[0, 20]
    end
    provider = Provider.find_or_create_by(name: auth.provider, uid: auth.uid, user_id: user.id)
    user
  end

  def send_welcome_email
    UserMailer.welcome_email(self).deliver_later
  end

  def send_registration_mail
    User.where(role: "admin").each do |user|
      AdminMailer.with(user: user, user_created:self).notify_admin.deliver_later
    end
  end

end
