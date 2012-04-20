require 'digest'
class Host < ActiveRecord::Base

   attr_accessible :first_name, :last_name, :email, :username, :password, :password_confirmation
email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
attr_accessor :password


  validates :first_name, :presence => true,
            :length   => { :maximum => 50 }
  validates :last_name, :presence => true,
            :length   => { :maximum => 50 }
  validates :email, :presence   => true,
            :format     => { :with => email_regex },
            :uniqueness => { :case_sensitive => false }
  validates :username, :presence => true,
            :length   => { :maximum => 50 }
  validates :password, :presence     => true,
            :confirmation => true,
            :length       => { :within => 6..40 }
                 
 before_save :encrypt_password

  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  def self.authenticate(email, submitted_password)
    host = find_by_email(email)
    return nil  if host.nil?
    return host if host.has_password?(submitted_password)
  end
  private

   def encrypt_password
      self.salt = make_salt unless has_password?(password)
      self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
end