class UsersController < Clearance::UsersController
	#Added to make sure that only logged in users can make these changes
	before_action :require_login 
	def new
		if @user.nil?
      if !current_user.admin?
        redirect_to sign_in_path
      else
        super
        if @user.nil?
          @Invite.create
        end
      end
    end

	end

	def create
    @user = user_from_params
    if @user.save
      #redirect the user back to the user page so that they can verify that the user has been added
      redirect_to users_path
    else
      render template: "users/new"
    end
  end

	#Need to overwrite this so that admins can sign others up, or else they won't be able to get to the sign up page
	def redirect_signed_in_users 
    # if signed_in?
    #   redirect_to Clearance.configuration.redirect_url
    # end
  	end

    #Deletes a user from the database
	def destroy
		#Before we destroy an User we want to make sure there is at least 1 admin
    #Left just in case someone tries to delete the database
    User.find(params[:id]).destroy
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
  		if @user.nil?
        if !current_user.admin?
          redirect_to sign_in_path
        else
          @users = User.all
        end
      end
  	end

  	#Mark - I don't beleive we need this method anymore
	def show
    	@user = User.find(params[:id])
	end

	def admin?
		@User.admin == true
	end

   def edit
    @user = User.find_by_email(params[:email])
    if !@user.nil?
      render 'update'
    end
  end

  def update
    #Find the user
    @user = User.find(params[:id])
    if @user.update_attributes(user_update_params)
      # Handle a successful update.
      redirect_to graphs_path
    else
      #Can't find the user so they can't be here
      render sign_in_path
    end
  end

  private
  #params for new user
  def user_param
    params[Clearance.configuration.user_parameter] || Hash.new
  end
#need for update
  def user_update_params
        params.require(:user).permit(:email, :password)

  end
end
