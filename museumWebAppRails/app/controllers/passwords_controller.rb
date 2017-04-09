class PasswordsController < Clearance::PasswordsController
#Might not need this controller
#overwrite the edit method so that we can hide it from the outside
def edit
	#don't really need this method
    @user = current_user
    #@user = find_user_for_edit
    if params[:token]
      session[:password_reset_token] = params[:token]
      pp "Here"
      #redirect_to url_for
      redirect_to sign_in
    else
    	pp "else"
      render template: 'passwords/edit'
      redirect_to sign_in
    end
  end

  def index
  	render template: 'passwords/edit'
  end

  def find_user_for_create
    Clearance.configuration.user_model.
      find_by_normalized_email params[:password][:email]
  end
end