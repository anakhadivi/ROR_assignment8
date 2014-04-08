class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
	def twitter
		puts request.env['omniauth.auth']
		@user = User.find_for_twitter_oauth(request.env['omniauth.auth'])
		if @user.persisted?
			sign_in_and_direct @user, :event => :authentication
			set_flash_message(:notice, :success, :kind => 'Twitter') if is navigational format?
		else
			session['devise.user_attributes'] = @user.attributes
			redirect_to new_user_registration_url
		end
	end
end