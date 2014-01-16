require 'spec_helper'

describe 'Scenes' do 
	let(:story) { FactoryGirl.create(:story) }
	
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
			fill_in "Subject", with: "Can we talk?"
			fill_in "Body", with: "You are in danger."
			click_button "Create Scene"
			expect(page).to have_content "Can we talk?"
		end	

		it "displays new scene on the story page" do 
			fill_in "Subject", with: "Can we talk?"
			fill_in "Body", with: "You are in danger."
			click_button "Create Scene"
			expect(current_path).to eql story_path(story)
		end
	end
end