class User < ApplicationRecord
  include Clearance::User
  # def new_admin
  # 	super new
  # 	#Is this how you set the field?
  # 	@user.admin = true
end
