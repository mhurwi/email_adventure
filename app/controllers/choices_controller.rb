class ChoicesController < ApplicationController

	respond_to :html

	def new
		@story = Story.find(params[:story_id])
		@scene = Scene.find(params[:scene_id])
		@choice = @scene.choices.new
	end

	def create
		@story = Story.find(params[:story_id])
		@scene = Scene.find(params[:scene_id])
		if @choice = @scene.choices.create(params[:choice])
			flash[:notice] = "Saved!"
			redirect_to edit_story_scene_path(@story, @scene)
		else
			flash[:error] = "Whoops! Error updating this choice"
			redirect_to edit_story_scene_path(@story, @scene)
		end
	end

	def edit
		@story = Story.find(params[:story_id])
		@scene = Scene.find(params[:scene_id])
		@choice = @scene.choices.find(params[:id])
	end

	def update
		@story = Story.find(params[:story_id])
		@scene = Scene.find(params[:scene_id])
		@choice = @scene.choices.find(params[:id])
		if @choice.update_attributes(params[:choice])
			flash[:notice] = "Your changes have been saved!"
			redirect_to edit_story_scene_path(@story, @scene)
		else
			flash[:error] = "Whoops! Error updating this choice"
			redirect_to edit_story_scene_path(@story, @scene)
		end
	end

	def destroy
		@story = Story.find(params[:story_id])
		@scene = Scene.find(params[:scene_id])
		@choice = @scene.choices.find(params[:id])
		if @choice.remove
			flash[:notice] = "Successfully deleted choice"
			redirect_to edit_story_scene_path(@story, @scene)
		else
			flash[:error] = "Whoops! Error deleting this choice"
			redirect_to edit_story_scene_path(@story, @scene)
		end
	end

end