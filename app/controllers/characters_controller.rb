class CharactersController < ApplicationController
	before_filter :authenticate_user!

	respond_to :html
	def index
		@user = User.find(params[:user_id])
		@characters = @user.characters
	end

	def show
		@user = User.find(params[:user_id])
		@character = Character.find(params[:id])
	end

	def new
		@user = User.find(params[:user_id])
		@character = @user.characters.new
	end

	def create
		@user = User.find(params[:user_id])
		@character = @user.characters.new(params[:character])
		if @character.save
			flash[:notice] = "Success!"
			redirect_to user_character_path(@user, @character)
		else
			flash[:error] = "Failed to create user."
			redirect_to new_user_character_path(@user)
		end
	end

	def edit
		@user = User.find(params[:user_id])
		@character = Character.find(params[:id])
	end

	def update
		@user = User.find(params[:user_id])
		@character = Character.find(params[:id])
		if @character.update_attributes(params[:character])
			flash[:notice] = "Successfully updated character"
			redirect_to user_character_path(@user, @character)
		else
			flash[:error] = "Failed to update character."
			redirect_to edit_user_character_path(@user, @character)
		end
	end

	def destroy
		@user = User.find(params[:user_id])
		@character = Character.find(params[:id])
		if @character.remove
			flash[:notice] = "Successfully deleted character"
			redirect_to user_characters_path(@user)
		else
			flash[:error] = "Failed to delete character."
			redirect_to edit_user_character_path(@user, @character)
		end
	end
end
