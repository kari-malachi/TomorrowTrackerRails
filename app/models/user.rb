class User < ApplicationRecord
  attr_accessor :password

  validates :name, :presence => true
  validates :username, :presence => true,
                       :length => { :maximum => 18 },
		               :uniqueness => true
  validates :password, :confirmation => true
  validates :password, :presence => true, :on => :create

  before_save :encrypt_password

  def admin?
    # returns true if the user is an Admin
    type == 'Admin'
  end

  def stacker?
    # returns true if the user is a stacker
    type == 'Stacker'
  end

  def stackee?
    # returns true if the user is a stackee
    type == 'Stackee'
  end
 
  def belongs_to_stack?(id)
    # returns true if the user belongs to the stack with the given
    # id. false if the user does not or doesn't belong to a stack at all
    stack_id == id
  end

  def is_user?(other)
    id == other.id
  end

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
