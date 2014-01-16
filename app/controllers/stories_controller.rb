class StoriesController < ApplicationController

	respond_to :html

	def index
		@stories = Story.all
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
		@story = Story.new(params[:story])
		if @story.save
			flash[:notice] = "Great! You have created a new story!"
			redirect_to story_path(@story)
		else
			flash[:error] = "Whoops! Something's wrong."
			redirect_to new_story_path
		end
	end

end