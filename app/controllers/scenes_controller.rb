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

	def edit
		@story = Story.find(params[:story_id])
		@scene = @story.scenes.find(params[:id])
	end

	def destroy
		@story = Story.find(params[:story_id])
		@scene = @story.scenes.find(params[:id])
		if @scene.remove
			flash[:notice] = "Successfully deleted scene"
			redirect_to story_path(@story)
		else
			flash[:error] = "Whoops! Could not delete this scene"
		end
	end

end