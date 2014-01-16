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

end