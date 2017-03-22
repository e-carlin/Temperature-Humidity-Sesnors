class UsersController < Clearance::UsersController
	def new
		super
		@Invite.create
	end

	def destroy
		User.find(params[:id]).destroy
		redirect_to root_path
	end

	#Overwrote this method to add the admin field when a user is created
	def user_from_params
		email = user_params.delete(:email)
    	password = user_params.delete(:password)
    	admin = user_params.delete(:admin)
    	Clearance.configuration.user_model.new(user_params).tap do |user|
      		user.email = email
      		user.password = password
      		user.admin = admin
   		 end
  	end


		def show
		end

	def admin?
		@User.admin == true
	end

	def is_admin
		return true if self.admin == true
	end
end
