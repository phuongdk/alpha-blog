class User < ActiveRecord::Base
    has_many :articles
    before_save { self.email = email.downcase }
    validates :username,
     presence: true,
     uniqueness: { case_sensitive: false },
     length: {minimum:3,maximum:30}
    validates :email, 
     presence: true,
     uniqueness: { case_sensitive: false },
     length: {minimum:5,maximum:50},
     format: { with:/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: "Wrong email format" }
     has_secure_password
end    