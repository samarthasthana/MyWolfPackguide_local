class UsersController < ApplicationController
	def login		
		if request.post?			
				# check if the user id is ncsu email id				
				# check userid blank # check pwd blank
				if(params[:user]=="" || params[:password]=="")
					flash[:error]="Username or password cannot be blank"					
		 			redirect_to '/'
				end				
				#authenticate the uid and pwd
					# check if the user exists
					# check if the password hash match
					
		end
	end

	def new
		
	end

	def home_page
		
	end	
end
