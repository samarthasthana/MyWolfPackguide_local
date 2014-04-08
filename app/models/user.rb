require 'bcrypt'
class User < ActiveRecord::Base
include BCrypt
	
	def password
		@password ||= Password.new(pwd)
	end

	def password=(new_password)
		@password = Password.create(new_password)
    	self.pwd = @password
	end

	def check_password(value)
		return self.pwd==Password.create(value)	
	end

end
