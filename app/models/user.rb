class User < ApplicationRecord
  attr_accessor :password, :admin

  validates :username, :presence => true,
                       :length => { :in => 3..20 },
		       :uniqueness => true
  validates :password, :confirmation => true
  validates_length_of :password, :in => 6..20, :on => :create

  before_save :encrypt_password
  after_save :clear_password

  def encrypt_password
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.encrypted_password = BCrypt::Engine.hash_secret(password, salt)
    end
  end

  def clear_password
    self.password = nil
  end

  def self.authenticate(username='', login_password='')
    user = User.find_by_username(username)
    if user and user.match_password(login_password)
      return user
    else
      return false
    end
  end

  def match_password(login_password="")
    self.encrypted_password == BCrypt::Engine.hash_secret(login_password, self.salt)
  end
end
