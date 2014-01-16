class ScenesController < ApplicationController

	respond_to :html

	def new
		@story = Story.find(params[:story_id])
		@scene = @story.scenes.new
	end

	def create
		@story = Story.find(params[:story_id])
		@scene = @story.scenes.create(params[:scene])
		redirect_to story_path(@story)
	end

end