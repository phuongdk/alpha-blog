class User < ActiveRecord::Base
validates :username,
     presence: true,
     uniqueness: { case_sensitive: false },
     length: {minimum:3,maximum:30}
validates :email, 
     presence: true,
     uniqueness: { case_sensitive: false },
     length: {minimum:5,maximum:30},
     format: { with:/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: "Wrong email format" }
end    