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


	describe 'EDIT /story/:story_id/scenes/:scene_id/choices/:choice_id' do 
		before :each do 
			choice
			visit edit_story_scene_choice_path(story, scene, choice)
		end

		it "has a button to create target scene" do 
			expect(page).to have_content "Create Target Scene"
		end

		context '#create_target_scene' do 
			before :each do
				click_link "Create Target Scene"
			end
			
			it "goes to new target scene" do 
				target_scene = Scene.find(choice.reload.target_scene_id)
				expect(current_path).to eq edit_story_scene_path(story, target_scene)
			end

		end
	end


end