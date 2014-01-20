require 'spec_helper'

describe 'Scenes' do 
	let(:story) { FactoryGirl.create(:story) }
	let(:scene) { story.scenes.create }
	
	describe 'NEW /story/:story_id/scenes' do 
		before :each do 
			visit new_story_scene_path(story)
		end
		it "has story title" do 
			expect(page).to have_content "Test Story"
		end

		it "has input for subject" do 
			expect(page).to have_content "Subject"
		end

		it "has input for body" do 
			expect(page).to have_content "Body"
		end

		it "creates a new scene" do 
			fill_in "scene[subject]", with: "Can we talk?"
			fill_in "scene[body]", with: "You are in danger."
			click_button "Save"
			expect(page).to have_content "Can we talk?"
		end	

		it "displays new scene on the story page" do 
			fill_in "scene[subject]", with: "Can we talk?"
			fill_in "scene[body]", with: "You are in danger."
			click_button "Save"
			expect(current_path).to eql story_path(story)
		end
	end

	describe 'EDIT /story/:story_id/scenes' do 
		before :each do 
			target_scene = story.scenes.create(subject: "and you were killed!", body:"too bad the gnarfle ate you.")
			visit edit_story_scene_path(story, scene)
		end

		it "can create a new choice" do 
			click_link "Create Choice"
			expect(current_path).to eql new_story_scene_choice_path(story, scene)
		end
	end



end