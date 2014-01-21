class CharactersController < ApplicationController

	def index
		@user = User.find(params[:user_id])
		@characters = @user.characters
	end

end