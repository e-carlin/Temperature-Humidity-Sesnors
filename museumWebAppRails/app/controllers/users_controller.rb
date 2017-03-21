class UsersController < Clearance::UsersController
	def new
		super
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
end