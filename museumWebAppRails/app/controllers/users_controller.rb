class UsersController < Clearance::UsersController
	#Added to make sure that only logged in users can access our site
	before_action :require_login 
	def new
		super
		if @user.nil?
			@Invite.create
		end

	end
#Need to overwrite this so that admins can sign others up
def redirect_signed_in_users
    # if signed_in?
    #   redirect_to Clearance.configuration.redirect_url
    # end
  end
# DELETE /users/1
  # DELETE /users/1.json
	def destroy
		#@user.destroy
		User.find(params[:id]).destroy
		# respond_to do |format|
  #     		format.html { redirect_to candidates_url, notice: 'User was successfully destroyed.' }
  #     		format.json { head :no_content }
  #   end
		redirect_to users_path
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

  	def index
  		@users = User.all
  	end


	def show
		#@user = User.find(:email)
    	@user = User.find(params[:id])
		# respond_to do |format|
  #     		format.html { render :html => @user } # show.html.erb
  #     		format.xml  { render :xml => @user }
  #   	end
    	#render('show')

	end

	def admin?
		@User.admin == true
	end

	# def is_admin
	# 	return  true if self.admin == true
	# end
end
