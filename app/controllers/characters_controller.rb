class CharactersController < ApplicationController

	def index
		@user = User.find(params[:user_id])
		@characters = @user.characters
	end

	def show
		@user = User.find(params[:user_id])
		@character = @user.characters.find(params[:id])
	end

	def new
		@user = User.find(params[:user_id])
		@character = @user.characters.new
	end
end
