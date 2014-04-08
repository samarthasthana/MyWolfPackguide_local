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
				@user_entry=User.find_by_user_name(params[:user])
				if(@user_entry.nil?)
					flash[:error]="User was not found"					
		 			redirect_to '/'
				end								
				# check if the password hash match
				if(@user_entry.password!=params[:password])
					flash[:error]="Incorrect password"					
		 			redirect_to '/'
				end
				# redirect to home_page with session [:name]
				if(@user_entry.user_type=="A")
					#redirect to admin home page
				end
				session[:user_name]=@user_entry.user_name
				redirect_to '/home_page'
		end
	end

	def new
		if request.post?
			# check if any of the fields are empty
			if(params[:new_user_name]=="" || params[:new_user_password]=="" || params[:new_user_confirm]=="" || params[:new_user_email]=="" )
				flash[:error]="A required field was left empty"					
	 			redirect_to 'users/new'
			end
			# check if the user already exists
			@user_check=User.find_by_user_name(params[:new_user_name])
			@user_check2=User.find_by_email(param[:new_user_email])
			if(!@user_check.nil? || !@user_check2.nil?)
				flash[:error]="User with this username or email id already exists in the system"					
	 			redirect_to 'users/new'
			end
			# check if password and confirm password match
			if(params[:new_user_password]!=params[:new_user_confirm])
				flash[:error]="Password and confirm password do not match"					
	 			redirect_to 'users/new'
			end
			# check if the email id is an ncsu email id
			exp=/\A[\w+\-.]+@ncsu.edu\z/i
			if((params[:new_user_email]=~exp).nil?)
				flash[:error]="Email id is not of NCSU domain"					
	 			redirect_to 'users/new'
			end 
			# register the new user and persist 
			@user_new.user_name=params[:new_user_name]
			@user_new.pwd=params[:new_user_password]
			@user_new.user_type="N"
			@user_new.email=param[:new_user_email]
			@user_new.save!
			flash[:notice]="User successfully registered"					
		 	redirect_to '/'
		end
	end

	def home_page
		
	end	
end
