class StoriesController < ApplicationController
	before_filter :authenticate_user!, except: [:confirmation_success]

	respond_to :html

	def index
		@stories = current_user.stories
		respond_with @stories
	end

	def show
		@story = Story.find(params[:id])
		respond_with @story
	end

	def new
		@story = Story.new
		respond_with @story
	end

	def create
		@story = current_user.stories.create(params[:story])
		if @story.save
			flash[:notice] = "Great! You have created a new story!"
			redirect_to story_path(@story)
		else
			flash[:error] = "Whoops! Something's wrong."
			redirect_to new_story_path
		end
	end

	def edit
		@story = Story.find(params[:id])
		respond_with @story
	end

	def update
		@story = Story.find(params[:id])
		if @story.update_attributes(params[:story])
			flash[:notice] = "Your changes have been saved!"
			redirect_to story_path(@story)
		else
			flash[:error] = "Whoops! Something's wrong."
			redirect_to edit_story_path
		end
	end

	def destroy
		@story = Story.find(params[:id])
		if @story.remove
			flash[:notice] = "You have deleted the story '#{@story.title}'"
			redirect_to stories_path
		else
			flash[:error] = "Whoops! Failed to delete this story"
			redirect_to @story
		end
	end

	def confirmation_success
		@story = Story.find(params[:story_id])
		@player_account = PlayerAccount.find(params[:player_account_id])
		@player_account.add_story(@story)
		if params[:confirmation_token] == @player_account.confirmation_token
			SceneMailer.scene_email(
				@story, 
				@story.scenes.first, 
				@story.scenes.first.character,
				@player_account
			).deliver
		else
			flash[:error] = "Sorry, that link didn't work!"
			# TODO: this should actually redirect to a 'failed to confirm' page
		end
		respond_with @story
	end

	
end