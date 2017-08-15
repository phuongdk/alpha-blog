require 'json'
require 'pp'

class User
    attr_accessor :email,:name,:permission
    
    def initialize(*args)
        @email = args[0]
        @name = args[1]
        @permissions = User.permissions_from_template
    end    
    
    def self.permissions_from_template
            file = File.read('user_permission_template.json')
            JSON.load(file, nil, symbolize_names:true)
    end
    
    def save
        self_json = {email => @email, name => @name, permission => @permissions}.to_json
        open('users.json','a') do |file|
        file.puts self_json
        end    
    end
    def empty
        File.truncate('users.json',0)
    end    
end    

user = User.new("phuongdkk@gmail.com","phuongdk")
pp user
user.save
# user.empty