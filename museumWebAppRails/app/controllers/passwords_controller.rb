class PasswordsController < Clearance::PasswordsController
#Might not need this controller
#overwrite the edit method so that we can hide it from the outside
def edit
    @user = find_user_for_edit

    if params[:token]
      session[:password_reset_token] = params[:token]
      redirect_to url_for
    else
      render template: 'passwords/edit'
    end
  end
end