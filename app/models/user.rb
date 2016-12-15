class User < ApplicationRecord
  attr_accessor :password

  validates :username, :presence => true,
                       :length => { :maximum => 18 },
		       :uniqueness => true
  validates :password, :confirmation => true
  validates :password, :presence => true, :on => :create

  before_save :encrypt_password

  def self.authenticate(username, password)
    user = find_by_username(username)
    if user && user.match_password(password)
      user
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.encrypted_password = BCrypt::Engine.hash_secret(password, salt)
    end
  end

  def match_password(password)
    encrypted_password == BCrypt::Engine.hash_secret(password, salt)
  end
end
