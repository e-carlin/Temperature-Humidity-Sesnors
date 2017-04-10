class UsersController < Clearance::UsersController
	#Added to make sure that only logged in users can access our site
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
      #sign_in @user #Don't necessarily want to sign the user in after they sign up so that admins can 
      #redirect the user back to the user page so that they can verify that the user has been added
      redirect_to users_path
    else
      render template: "users/new"
    end
  end

	#Need to overwrite this so that admins can sign others up
	def redirect_signed_in_users
    # if signed_in?
    #   redirect_to Clearance.configuration.redirect_url
    # end
  	end

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
    if @user.update_attributes(user_params)
      # Handle a successful update.
      redirect_to graphs_path
    else
      #Can't find the user so they can't be here
      render sign_in_path
      #render 'edit'
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
                
    #params[Clearance.configuration.user_parameter] || Hash.new
  end
  
  #Helper methods for edit (probably don't need)

 def find_user_for_update
    find_user_by_id_and_confirmation_token
  end

def find_user_for_edit
    find_user_by_id_and_confirmation_token
  end

def find_user_by_id_and_confirmation_token
    user_param = Clearance.configuration.user_id_parameter
    token = session[:password_reset_token] || params[:token]

    Clearance.configuration.user_model.
      find_by_id_and_confirmation_token params[user_param], token.to_s
  end

def password_reset_params
   #params[:password]
    if params.has_key? :user
      ActiveSupport::Deprecation.warn %{Since locales functionality was added, accessing params[:user] is no longer supported.}
      params[:user][:password]
      #params[:password]

    else
      params[:password]
      #params[:password_reset][:password]
    end
  end

end
