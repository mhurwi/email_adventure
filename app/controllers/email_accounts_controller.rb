class EmailAccountsController < ApplicationController

	respond_to :html

	def show
		@user = User.find(params[:user_id])
		@character = Character.find(params[:character_id])
		@email_account = EmailAccount.find(params[:id])
	end

	def new
		@user = User.find(params[:user_id])
		@character = Character.find(params[:character_id])
		@email_account = EmailAccount.new
	end

	def create
		@user = User.find(params[:user_id])
		@character = Character.find(params[:character_id])
		@email_account = @character.create_email_account(params[:email_account])
		redirect_to user_character_email_account_path(@user, @character, @email_account)
	end

	def edit
		@user = User.find(params[:user_id])
		@character = Character.find(params[:character_id])
		@email_account = EmailAccount.find(params[:id])
	end

	def update
		@user = User.find(params[:user_id])
		@character = Character.find(params[:character_id])
		@email_account = EmailAccount.find(params[:id])
		if @email_account.update_attributes(params[:email_account])
			flash[:notice] = "Your changes have been saved"
			redirect_to user_character_email_account_path(@user, @character, @email_account)
		else
			flash[:notice] = "Whoops!  Failed to save your changes"
			redirect_to edit_user_character_email_account_path(@user, @character, @email_account)
		end
	end

	def destroy
		@user = User.find(params[:user_id])
		@character = Character.find(params[:character_id])
		@email_account = EmailAccount.find(params[:id])
		if @email_account.remove
			flash[:notice] = "Email account deleted."
			redirect_to user_character_path(@user, @character)
		else
			flash[:notice] = "Whoops!  Failed to delete this account"
			redirect_to user_character_email_account_path(@user, @character, @email_account)
		end
	end


end
