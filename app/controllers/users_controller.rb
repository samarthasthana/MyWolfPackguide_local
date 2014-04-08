class UsersController < ApplicationController
	def login		
		redirect_path=nil
		if request.post?			
			# check if the user id is ncsu email id				
			# check userid blank # check pwd blank
			if(params[:user]=="" || params[:password]=="")
				flash[:error]="Username or password cannot be blank"					
	 			redirect_path= '/'
	 		else
	 			#authenticate the uid and pwd
				# check if the user exists
	 			@user_entry=User.find_by_user_name(params[:user])
				puts(@user_entry.nil?)
				if(@user_entry.nil?)					
					flash[:error]="User was not found"					
		 			redirect_path= '/'
				else							
					# check if the password hash match
					if(@user_entry.password!=params[:password])
						flash[:error]="Incorrect password"					
			 			redirect_path= '/'
					end
				end	
			end	
			if(!redirect_path.nil?)
				redirect_to redirect_path
			else
				# redirect to home_page with session [:name]
				if(@user_entry.user_type=="A")
					#redirect to admin home page
				else
					session[:user_name]=@user_entry.user_name
					redirect_to '/home_page'
				end				
			end								
		end
	end

	def new
		if request.post?
			redirect_path=nil
			# check if any of the fields are empty
			if(params[:new_user_name]=="" || params[:new_user_password]=="" || params[:new_user_confirm]=="" || params[:new_user_email]=="" )
				flash[:error]="A required field was left empty"					
	 			redirect_path='/users/new'
	 		else
	 			# check if the user already exists
	 			@user_check=User.find_by_user_name(params[:new_user_name])
				@user_check2=User.find_by_email(params[:new_user_email])
				if(!@user_check.nil? || !@user_check2.nil?)
					flash[:error]="User with this username or email id already exists in the system"					
		 			redirect_path= '/users/new'
		 		else
		 			# check if password and confirm password match
					if(params[:new_user_password]!=params[:new_user_confirm])
						flash[:error]="Password and confirm password do not match"					
			 			redirect_path= '/users/new'
			 		else
			 			# check if the email id is an ncsu email id
			 			exp=/\A[\w+\-.]+@ncsu.edu\z/i
						if((params[:new_user_email]=~exp).nil?)
							flash[:error]="Email id is not of NCSU domain"					
				 			redirect_path= '/users/new'
						end 
					end
				end
			end

			if(redirect_path.nil?)
				# register the new user and persist 
				@user_new=User.new
				@user_new.user_name=params[:new_user_name]
				@user_new.pwd=params[:new_user_password]
				@user_new.user_type="N"
				@user_new.email=params[:new_user_email]
				if(@user_new.save!)
					flash[:notice]="User successfully registered"					
			 	else
			 		flash[:error]="Something went wrong, registration failed"
				end
				redirect_to '/'
			else
				redirect_to redirect_path
			end			
		end
	end

	def home_page
		
	end	
end
