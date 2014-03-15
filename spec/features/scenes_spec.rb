require 'spec_helper'


describe 'Scenes' do 
	let(:user) { FactoryGirl.create(:user)}
	let(:character) { user.characters.create(
				first_name: "Frank", 
				last_name: "Frankfurter",
		)}
	let(:email_account) { character.create_email_account(
				address: "frank@example.com"
		)}
	let(:story) { FactoryGirl.create(:story) }
	let(:scene) { story.scenes.create(
				character_id: character.id.to_s
		) }
	let(:scene2) { story.scenes.create(
			preceding_scene_id: scene.id.to_s,
			character_id: character.id.to_s
		) }
	let(:scene3) { story.scenes.create(
			preceding_scene_id: scene.id.to_s,
			character_id: character.id.to_s
		) }
	let(:choice) { scene.choices.create(target_scene_id: scene2.id.to_s) }
	let(:choice2) { scene.choices.create(target_scene_id: scene3.id.to_s) }
	
	before :each do 
		story
		scene
		character
		login_as(user, :scope => :user)
	end

	after :each do 
			Warden.test_reset! 
	end

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

		it "creates a new choice" do 
			click_link "Create Choice"
			expect(current_path).to eql new_story_scene_choice_path(story, scene)
		end

		it "assigns a character" do 
			pending "How to get options to appear?"
			select('Frank Frankfurter', :from => 'scene_character_id')
			expect(scene.character.full_name).to eq 'Frank Frankfurter'
		end
	end



end