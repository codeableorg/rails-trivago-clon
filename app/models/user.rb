class User < ApplicationRecord

  before_create :generate_token
  after_create :send_welcome_email, :send_registration_mail
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook github]
  has_many :bookings
  

  def self.from_omniauth(auth)
    user = where(email: auth.info.email.downcase).first_or_create do |user|
      user.email = auth.info.email.downcase
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.email.split("@")[0]
    end
    provider = Provider.find_or_create_by(name: auth.provider, uid: auth.uid, user_id: user.id)
    user
  end

  def send_welcome_email
    UserMailer.welcome_email(self).deliver_now
  end

  def send_registration_mail
    User.where(role: "admin").each do |user|
      AdminMailer.with(user: user, user_created:self).notify_admin.deliver_later
    end
  end

  def admin? 
    self.role == "admin"
  end

  def regular? 
    self.role == "regular"
  end

  
  def generate_token
    self.token = Devise.friendly_token[0, 30]
  end

end
