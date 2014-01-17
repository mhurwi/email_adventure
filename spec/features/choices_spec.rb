require 'spec_helper'

describe 'Choices' do 
	let(:story) { FactoryGirl.create(:story) }
	let(:scene) { story.scenes.create(subject: "Hi!") }
	let(:choice) { scene.choices.create() }
	
	describe 'NEW /story/:story_id/scenes/:scene_id/choices/new' do 
		before :each do 
			choice
			visit new_story_scene_choice_path(story, scene)
		end

		it "has input for text" do 
			expect(page).to have_content "Text"
		end

	end

	describe 'NEW /story/:story_id/scenes/:scene_id/choices/new' do 
		before :each do 
			choice
			visit edit_story_scene_choice_path(story, scene, choice)
		end

	end
end