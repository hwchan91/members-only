class User < ApplicationRecord
  has_many :posts
  attr_accessor :remember_token

  before_save { self.email = email.downcase }
  #before_create { remember }
  validates :username,  presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  #def User.digest(string)
  #  cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
  #                                                BCrypt::Engine.cost
  #  BCrypt::Password.create(string, cost: cost)
  #end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = SecureRandom.urlsafe_base64
    #update_attribute(:remember_digest, User.digest(remember_token))
    update_attribute(:remember_digest, Digest::SHA1.hexdigest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    #BCrypt::Password.new(remember_digest).is_password?(remember_token)
    self.remember_digest == Digest::SHA1.hexdigest(remember_token)
  end

end
