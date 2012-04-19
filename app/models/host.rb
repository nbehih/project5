class Host < ActiveRecord::Base
	 attr_accessible :first_name, :last_name, :email, :username
email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :first_name, :presence => true,
  					  :length   => { :maximum => 50 }
  validates :last_name, :presence => true,
    				:length   => { :maximum => 50 }
  validates :email, :presence   => true,
                    :format     => { :with => email_regex },
                    :uniqueness => { :case_sensitive => false }
   validates :username, :presence => true,
     				:length   => { :maximum => 50 }
                 
end
