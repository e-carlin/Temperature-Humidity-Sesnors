class PasswordsController < Clearance::PasswordsController
     #added for forgot password
     #before_filter :ensure_existing_user, except: [:edit, :update]
  #   skip_before_filter :ensure_existing_user, only: [:edit, :update]

  # def deliver_email(user)
  #   mail = ::ClearanceMailer.change_password(user)

  #   if mail.respond_to?(:deliver_later)
  #     mail.deliver_later
  #   else
  #     mail.deliver
  #   end
  # end


  # def new
  #   render template: 'passwords/new'
  # end



 # if respond_to?(:before_action)
 #    skip_before_action :require_login,
 #      only: [:create, :edit, :new, :update],
 #      raise: false
 #    skip_before_action :authorize,
 #      only: [:create, :edit, :new, :update],
 #      raise: false
 #    #before_action :ensure_existing_user, only: [:edit, :update]
 #  else
 #    skip_before_filter :require_login,
 #      only: [:create, :edit, :new, :update],
 #      raise: false
 #    skip_before_filter :authorize,
 #      only: [:create, :edit, :new, :update],
 #      raise: false
 #    #before_filter :ensure_existing_user, only: [:edit, :update]
 #  end
#Might not need this controller
#overwrite the edit method so that we can hide it from the outside
# def edit
#     #@user = find_user_for_edit
#     @user = current_user
#     if params[:token]
#       session[:password_reset_token] = params[:token]
#       #redirect_to url_for
#       redirect_to sign_in
#     else
#       render template: 'passwords/edit'
#     end
#   end

# def update
#     @user = find_user_for_update

#     if @user.update_password password_reset_params
#       sign_in @user
#       redirect_to url_after_update
#       session[:password_reset_token] = nil
#     else
#       flash_failure_after_update
#       render template: 'passwords/edit'
#     end
#   end

# def edit
# 	#don't really need this method
#     @user = current_user
#     #@user = find_user_for_edit
#     if params[:token]
#       session[:password_reset_token] = params[:token]
#       pp "Here"
#       #redirect_to url_for
#       redirect_to sign_in
#     else
#     	pp "else"
#       render template: 'passwords/edit'
#       redirect_to sign_in
#     end
#   end


  # def index
  # 	render template: 'passwords/edit'
  # end

  # def find_user_for_create
  #   Clearance.configuration.user_model.
  #     find_by_normalized_email params[:password][:email]
  # end
end